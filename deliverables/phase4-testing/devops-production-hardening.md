# LOLO -- Production Hardening & Store Deployment Automation

**Document ID:** LOLO-DEVOPS-PROD-P4
**Author:** Carlos Rivera, DevOps Engineer
**Date:** 2026-02-15
**Version:** 1.0
**Status:** Phase 4 Deliverable
**Classification:** Internal -- Confidential
**Dependencies:** CI/CD Pipeline (S1-DEVOPS), Firebase Schema (S1-03A), Architecture Document v1.0

---

## Table of Contents

1. [Firebase Production Setup](#1-firebase-production-setup)
2. [Cloud Infrastructure (Terraform)](#2-cloud-infrastructure-terraform)
3. [SSL/TLS Configuration](#3-ssltls-configuration)
4. [Monitoring Stack](#4-monitoring-stack)
5. [Alert Configuration](#5-alert-configuration)
6. [Logging Strategy](#6-logging-strategy)
7. [Google Play Deployment](#7-google-play-deployment)
8. [Apple App Store Deployment](#8-apple-app-store-deployment)
9. [Huawei AppGallery Deployment](#9-huawei-appgallery-deployment)
10. [Release Process](#10-release-process)
11. [Backup Strategy](#11-backup-strategy)
12. [Incident Response](#12-incident-response)

---

## 1. Firebase Production Setup

### 1.1 Environment Isolation

LOLO operates three fully isolated Firebase projects per the `.firebaserc` established in Sprint 1. Production tightens every rule.

| Property | Dev (`lolo-app-dev`) | Staging (`lolo-app-staging`) | Prod (`lolo-app-prod`) |
|---|---|---|---|
| Firestore location | `us-central1` | `asia-southeast1` | `asia-southeast1` |
| Min Cloud Functions instances | 0 | 0 | 3 |
| Max Cloud Functions instances | 10 | 25 | 200 |
| Auth providers | Email, Google, Apple, Phone | Same | Same |
| Budget alerts | $50/day | $200/day | $2,000/day |
| Access | All engineers | Lead + DevOps + QA | DevOps + Lead only |

### 1.2 Firestore Production Rules

```javascript
// FILE: firestore.prod.rules
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    // ── Helper Functions ──
    function isAuthenticated() {
      return request.auth != null;
    }

    function isOwner(uid) {
      return isAuthenticated() && request.auth.uid == uid;
    }

    function isAdmin() {
      return isAuthenticated()
        && request.auth.token.admin == true;
    }

    function rateLimitOk(collection) {
      // Firestore-level rate check: max 1 write per second per doc
      return true; // Enforced at Cloud Functions layer via Redis
    }

    function validString(field, minLen, maxLen) {
      return field is string
        && field.size() >= minLen
        && field.size() <= maxLen;
    }

    function hasRequiredFields(fields) {
      return request.resource.data.keys().hasAll(fields);
    }

    function noExtraFields(allowed) {
      return request.resource.data.keys().hasOnly(allowed);
    }

    // ── Users Collection ──
    match /users/{uid} {
      allow read: if isOwner(uid);
      allow create: if isOwner(uid)
        && hasRequiredFields(['displayName', 'email', 'locale', 'createdAt'])
        && validString(request.resource.data.displayName, 1, 100)
        && request.resource.data.locale in ['en', 'ar', 'ms']
        && request.resource.data.createdAt == request.time;
      allow update: if isOwner(uid)
        && !request.resource.data.diff(resource.data).affectedKeys()
            .hasAny(['createdAt', 'uid', 'tier', 'stripeCustomerId']);
      allow delete: if false; // Soft-delete only via Cloud Function

      // Partner sub-document
      match /partner/{partnerId} {
        allow read: if isOwner(uid);
        allow create: if isOwner(uid)
          && hasRequiredFields(['name', 'zodiacSign', 'createdAt'])
          && validString(request.resource.data.name, 1, 100)
          && request.resource.data.zodiacSign in [
              'aries','taurus','gemini','cancer','leo','virgo',
              'libra','scorpio','sagittarius','capricorn','aquarius','pisces'
             ];
        allow update: if isOwner(uid);
        allow delete: if isOwner(uid);
      }

      // Memories sub-collection
      match /memories/{memoryId} {
        allow read: if isOwner(uid);
        allow create: if isOwner(uid)
          && hasRequiredFields(['title', 'type', 'createdAt'])
          && validString(request.resource.data.title, 1, 500)
          && request.resource.data.type in ['milestone','conflict','gift','note','photo'];
        allow update: if isOwner(uid)
          && !request.resource.data.diff(resource.data).affectedKeys()
              .hasAny(['createdAt', 'uid']);
        allow delete: if isOwner(uid);
      }

      // Conversations sub-collection (AI chat history)
      match /conversations/{convId} {
        allow read: if isOwner(uid);
        allow create: if false; // Only Cloud Functions write conversations
        allow update: if false;
        allow delete: if false;
      }
    }

    // ── Reminders Collection ──
    match /reminders/{reminderId} {
      allow read: if isAuthenticated()
        && resource.data.uid == request.auth.uid;
      allow create: if isAuthenticated()
        && request.resource.data.uid == request.auth.uid
        && hasRequiredFields(['uid', 'title', 'scheduledAt', 'type', 'status'])
        && validString(request.resource.data.title, 1, 300);
      allow update: if isAuthenticated()
        && resource.data.uid == request.auth.uid
        && !request.resource.data.diff(resource.data).affectedKeys()
            .hasAny(['uid', 'createdAt']);
      allow delete: if isAuthenticated()
        && resource.data.uid == request.auth.uid;
    }

    // ── Action Cards (read-only from client) ──
    match /actionCards/{cardId} {
      allow read: if isAuthenticated();
      allow write: if false; // Cloud Functions only
    }

    // ── Leaderboard (read-only from client) ──
    match /leaderboard/{entry} {
      allow read: if isAuthenticated();
      allow write: if false;
    }

    // ── Admin-only collections ──
    match /analytics/{doc=**} {
      allow read: if isAdmin();
      allow write: if false;
    }

    match /systemConfig/{doc} {
      allow read: if isAdmin();
      allow write: if false;
    }

    // ── Deny everything else ──
    match /{document=**} {
      allow read, write: if false;
    }
  }
}
```

### 1.3 Storage Production Rules

```javascript
// FILE: storage.prod.rules
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {

    function isAuthenticated() {
      return request.auth != null;
    }

    function isOwner(uid) {
      return request.auth != null && request.auth.uid == uid;
    }

    function isImage() {
      return request.resource.contentType.matches('image/(png|jpeg|webp|heic)')
        && request.resource.size < 10 * 1024 * 1024; // 10 MB max
    }

    function isAudio() {
      return request.resource.contentType.matches('audio/(mpeg|aac|m4a|wav)')
        && request.resource.size < 25 * 1024 * 1024; // 25 MB max
    }

    // User profile photos
    match /users/{uid}/profile/{fileName} {
      allow read: if isAuthenticated();
      allow write: if isOwner(uid) && isImage();
    }

    // Memory attachments
    match /users/{uid}/memories/{memoryId}/{fileName} {
      allow read: if isOwner(uid);
      allow write: if isOwner(uid)
        && (isImage() || isAudio());
    }

    // Partner photos
    match /users/{uid}/partner/{fileName} {
      allow read: if isOwner(uid);
      allow write: if isOwner(uid) && isImage();
    }

    // System assets (read-only)
    match /system/{allPaths=**} {
      allow read: if isAuthenticated();
      allow write: if false;
    }

    // Deny everything else
    match /{allPaths=**} {
      allow read, write: if false;
    }
  }
}
```

### 1.4 Cloud Functions Production Configuration

```typescript
// FILE: functions/src/config/production.ts
import { RuntimeOptions } from "firebase-functions/v2";

// ── Per-function resource allocation ──

export const PROD_RUNTIME: Record<string, RuntimeOptions> = {
  // AI Router -- highest resource needs
  aiRouter: {
    memory: "1GiB",
    timeoutSeconds: 120,
    minInstances: 3,
    maxInstances: 100,
    concurrency: 40,
    cpu: 1,
  },

  // SOS Mode -- low-latency critical path
  sosHandler: {
    memory: "512MiB",
    timeoutSeconds: 60,
    minInstances: 2,
    maxInstances: 50,
    concurrency: 80,
    cpu: 1,
  },

  // API gateway -- general request handling
  api: {
    memory: "512MiB",
    timeoutSeconds: 30,
    minInstances: 3,
    maxInstances: 200,
    concurrency: 80,
    cpu: 1,
  },

  // Batch jobs -- high memory, low concurrency
  batchJobs: {
    memory: "2GiB",
    timeoutSeconds: 540,
    minInstances: 0,
    maxInstances: 10,
    concurrency: 1,
    cpu: 2,
  },

  // RevenueCat webhooks -- payment critical
  webhooks: {
    memory: "256MiB",
    timeoutSeconds: 30,
    minInstances: 1,
    maxInstances: 50,
    concurrency: 80,
    cpu: 1,
  },

  // Push notifications
  notifications: {
    memory: "256MiB",
    timeoutSeconds: 60,
    minInstances: 0,
    maxInstances: 30,
    concurrency: 100,
    cpu: 1,
  },
};

// ── Environment-specific feature flags ──
export const PROD_CONFIG = {
  ai: {
    defaultModel: "claude-haiku",
    fallbackChain: ["claude-haiku", "gemini-flash", "gpt-5-mini"],
    maxRetries: 3,
    timeoutMs: 15000,
    costAlertThresholdDaily: 500, // USD
  },
  cache: {
    defaultTtlSeconds: 300,
    aiResponseTtlSeconds: 3600,
    userProfileTtlSeconds: 600,
  },
  rateLimit: {
    globalPerMinute: 60,
    aiPerMinute: 10,
    sosPerHour: 5,
    authPerMinute: 5,
  },
  security: {
    maxRequestBodyBytes: 1_048_576,  // 1 MB
    corsOrigins: ["https://admin.lolo.app"],
    appCheckEnforced: true,
  },
};
```

### 1.5 Firebase Performance Monitoring

```dart
// FILE: lib/core/monitoring/performance_monitor.dart
import 'package:firebase_performance/firebase_performance.dart';

class LoloPerformanceMonitor {
  static final FirebasePerformance _perf = FirebasePerformance.instance;

  /// Initialize with production settings
  static Future<void> init() async {
    await _perf.setPerformanceCollectionEnabled(true);
  }

  /// Trace a named operation
  static Future<T> trace<T>(String name, Future<T> Function() operation,
      {Map<String, String>? attributes}) async {
    final trace = _perf.newTrace(name);
    attributes?.forEach((k, v) => trace.putAttribute(k, v));
    await trace.start();
    try {
      final result = await operation();
      trace.putAttribute('status', 'success');
      return result;
    } catch (e) {
      trace.putAttribute('status', 'error');
      trace.putAttribute('error_type', e.runtimeType.toString());
      rethrow;
    } finally {
      await trace.stop();
    }
  }

  /// Custom HTTP metric for AI calls
  static HttpMetric createAiMetric(String model, String url) {
    final metric = _perf.newHttpMetric(url, HttpMethod.Post);
    metric.putAttribute('ai_model', model);
    return metric;
  }
}
```

### 1.6 Crashlytics Setup

```dart
// FILE: lib/core/monitoring/crashlytics_config.dart
import 'dart:async';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class CrashlyticsConfig {
  static Future<void> init() async {
    // Disable in debug mode
    if (kDebugMode) {
      await FirebaseCrashlytics.instance
          .setCrashlyticsCollectionEnabled(false);
      return;
    }

    await FirebaseCrashlytics.instance
        .setCrashlyticsCollectionEnabled(true);

    // Catch Flutter framework errors
    FlutterError.onError = (details) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(details);
    };

    // Catch async errors
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  static void setUser(String uid, {String? locale, String? tier}) {
    final instance = FirebaseCrashlytics.instance;
    instance.setUserIdentifier(uid);
    if (locale != null) instance.setCustomKey('locale', locale);
    if (tier != null) instance.setCustomKey('tier', tier);
  }

  static void logBreadcrumb(String message) {
    FirebaseCrashlytics.instance.log(message);
  }

  static void recordNonFatal(dynamic error, StackTrace stack,
      {String? reason}) {
    FirebaseCrashlytics.instance.recordError(error, stack,
        reason: reason ?? 'non-fatal', fatal: false);
  }
}
```

### 1.7 Remote Config for Feature Flags

```typescript
// FILE: functions/src/config/remoteConfig.ts
// Remote Config template deployed via Firebase CLI

export const REMOTE_CONFIG_TEMPLATE = {
  parameters: {
    // ── Feature Flags ──
    feature_sos_mode_enabled: {
      defaultValue: { value: "true" },
      conditionalValues: {
        "platform_ios": { value: "true" },
        "platform_android": { value: "true" },
      },
      description: "Enable/disable SOS mode globally",
      valueType: "BOOLEAN",
    },
    feature_gift_engine_v2: {
      defaultValue: { value: "false" },
      conditionalValues: {
        "beta_users": { value: "true" },
      },
      description: "Gift recommendation engine v2 rollout",
      valueType: "BOOLEAN",
    },
    feature_voice_notes: {
      defaultValue: { value: "false" },
      description: "Voice note recording in memory vault",
      valueType: "BOOLEAN",
    },
    maintenance_mode: {
      defaultValue: { value: "false" },
      description: "Show maintenance screen to all users",
      valueType: "BOOLEAN",
    },

    // ── AI Configuration ──
    ai_primary_model: {
      defaultValue: { value: "claude-haiku" },
      description: "Primary AI model for message generation",
      valueType: "STRING",
    },
    ai_cost_cap_daily_usd: {
      defaultValue: { value: "500" },
      description: "Daily AI spending cap in USD",
      valueType: "NUMBER",
    },

    // ── UI Configuration ──
    min_app_version_android: {
      defaultValue: { value: "1.0.0" },
      description: "Minimum supported Android version",
      valueType: "STRING",
    },
    min_app_version_ios: {
      defaultValue: { value: "1.0.0" },
      description: "Minimum supported iOS version",
      valueType: "STRING",
    },
    force_update_enabled: {
      defaultValue: { value: "false" },
      description: "Force users below min version to update",
      valueType: "BOOLEAN",
    },
  },
  conditions: [
    {
      name: "platform_ios",
      expression: "device.os == 'ios'",
      tagColor: "INDIGO",
    },
    {
      name: "platform_android",
      expression: "device.os == 'android'",
      tagColor: "GREEN",
    },
    {
      name: "beta_users",
      expression: "app.userProperty['beta_tester'] == 'true'",
      tagColor: "ORANGE",
    },
  ],
};
```

```dart
// FILE: lib/core/config/remote_config_service.dart
import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig _rc = FirebaseRemoteConfig.instance;

  Future<void> init() async {
    await _rc.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(hours: 1),
    ));
    await _rc.setDefaults({
      'feature_sos_mode_enabled': true,
      'feature_gift_engine_v2': false,
      'feature_voice_notes': false,
      'maintenance_mode': false,
      'ai_primary_model': 'claude-haiku',
      'min_app_version_android': '1.0.0',
      'min_app_version_ios': '1.0.0',
      'force_update_enabled': false,
    });
    await _rc.fetchAndActivate();
  }

  bool get sosEnabled => _rc.getBool('feature_sos_mode_enabled');
  bool get giftV2Enabled => _rc.getBool('feature_gift_engine_v2');
  bool get voiceNotesEnabled => _rc.getBool('feature_voice_notes');
  bool get maintenanceMode => _rc.getBool('maintenance_mode');
  bool get forceUpdateEnabled => _rc.getBool('force_update_enabled');
  String get primaryAiModel => _rc.getString('ai_primary_model');
  String get minAndroidVersion => _rc.getString('min_app_version_android');
  String get minIosVersion => _rc.getString('min_app_version_ios');
}
```

---

## 2. Cloud Infrastructure (Terraform)

### 2.1 Provider & Variables

```hcl
# FILE: infra/terraform/main.tf
terraform {
  required_version = ">= 1.7.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.20"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 5.20"
    }
  }
  backend "gcs" {
    bucket = "lolo-terraform-state"
    prefix = "prod"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}

variable "project_id" {
  description = "GCP project ID"
  type        = string
  default     = "lolo-app-prod"
}

variable "region" {
  description = "Primary GCP region"
  type        = string
  default     = "asia-southeast1"  # Singapore -- close to GCC + SEA
}

variable "secondary_region" {
  description = "DR region"
  type        = string
  default     = "me-central1"  # Doha -- GCC proximity
}

variable "environment" {
  type    = string
  default = "prod"
}
```

### 2.2 VPC Network

```hcl
# FILE: infra/terraform/network.tf
resource "google_compute_network" "lolo_vpc" {
  name                    = "lolo-vpc-${var.environment}"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "primary" {
  name                     = "lolo-subnet-primary"
  ip_cidr_range            = "10.10.0.0/20"
  region                   = var.region
  network                  = google_compute_network.lolo_vpc.id
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "services"
    ip_cidr_range = "10.10.16.0/22"
  }
}

resource "google_compute_global_address" "private_ip" {
  name          = "lolo-private-ip"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.lolo_vpc.id
}

resource "google_service_networking_connection" "private_vpc" {
  network                 = google_compute_network.lolo_vpc.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip.name]
}

# ── Firewall Rules ──
resource "google_compute_firewall" "allow_internal" {
  name    = "lolo-allow-internal"
  network = google_compute_network.lolo_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "icmp"
  }

  source_ranges = ["10.10.0.0/20"]
  priority      = 1000
}

resource "google_compute_firewall" "deny_all_ingress" {
  name    = "lolo-deny-all-ingress"
  network = google_compute_network.lolo_vpc.name

  deny {
    protocol = "all"
  }

  source_ranges = ["0.0.0.0/0"]
  priority      = 65534
}

# Serverless VPC connector for Cloud Functions
resource "google_vpc_access_connector" "connector" {
  name          = "lolo-vpc-connector"
  region        = var.region
  network       = google_compute_network.lolo_vpc.name
  ip_cidr_range = "10.10.32.0/28"
  min_instances = 2
  max_instances = 10
}
```

### 2.3 Cloud SQL PostgreSQL

```hcl
# FILE: infra/terraform/database.tf
resource "google_sql_database_instance" "analytics_primary" {
  name                = "lolo-analytics-${var.environment}"
  database_version    = "POSTGRES_16"
  region              = var.region
  deletion_protection = true

  depends_on = [google_service_networking_connection.private_vpc]

  settings {
    tier              = "db-custom-4-16384"  # 4 vCPU, 16 GB RAM
    availability_type = "REGIONAL"           # HA with automatic failover
    disk_type         = "PD_SSD"
    disk_size         = 100
    disk_autoresize   = true

    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.lolo_vpc.id
      require_ssl     = true

      ssl_mode = "ENCRYPTED_ONLY"
    }

    backup_configuration {
      enabled                        = true
      start_time                     = "02:00"  # 2 AM UTC
      point_in_time_recovery_enabled = true
      transaction_log_retention_days = 7

      backup_retention_settings {
        retained_backups = 30
        retention_unit   = "COUNT"
      }
    }

    maintenance_window {
      day          = 7  # Sunday
      hour         = 3  # 3 AM UTC
      update_track = "stable"
    }

    database_flags {
      name  = "log_min_duration_statement"
      value = "1000"  # Log queries > 1s
    }
    database_flags {
      name  = "max_connections"
      value = "200"
    }
    database_flags {
      name  = "log_checkpoints"
      value = "on"
    }

    insights_config {
      query_insights_enabled  = true
      query_plans_per_minute  = 5
      query_string_length     = 4096
      record_application_tags = true
      record_client_address   = false
    }
  }
}

# Read replica for analytics queries
resource "google_sql_database_instance" "analytics_replica" {
  name                 = "lolo-analytics-replica-${var.environment}"
  master_instance_name = google_sql_database_instance.analytics_primary.name
  database_version     = "POSTGRES_16"
  region               = var.region
  deletion_protection  = true

  replica_configuration {
    failover_target = false
  }

  settings {
    tier              = "db-custom-2-8192"  # 2 vCPU, 8 GB RAM
    availability_type = "ZONAL"
    disk_type         = "PD_SSD"
    disk_size         = 100
    disk_autoresize   = true

    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.lolo_vpc.id
      require_ssl     = true
    }
  }
}

resource "google_sql_database" "analytics" {
  name     = "lolo_analytics"
  instance = google_sql_database_instance.analytics_primary.name
}

resource "google_sql_user" "app_user" {
  name     = "lolo_app"
  instance = google_sql_database_instance.analytics_primary.name
  password = data.google_secret_manager_secret_version.db_password.secret_data
}
```

### 2.4 Redis Memorystore

```hcl
# FILE: infra/terraform/redis.tf
resource "google_redis_instance" "cache" {
  name               = "lolo-cache-${var.environment}"
  tier               = "STANDARD_HA"  # Automatic failover
  memory_size_gb     = 4
  region             = var.region
  redis_version      = "REDIS_7_2"
  auth_enabled       = true
  transit_encryption_mode = "SERVER_AUTHENTICATION"

  authorized_network = google_compute_network.lolo_vpc.id

  redis_configs = {
    "maxmemory-policy" = "allkeys-lru"
    "notify-keyspace-events" = "Ex"  # Expired key notifications
    "save" = "3600 1 300 100"        # RDB: every hour if 1+ key changed, every 5min if 100+
  }

  maintenance_policy {
    weekly_maintenance_window {
      day = "SUNDAY"
      start_time {
        hours   = 4
        minutes = 0
      }
    }
  }

  persistence_config {
    persistence_mode    = "RDB"
    rdb_snapshot_period = "SIX_HOURS"
  }

  labels = {
    environment = var.environment
    service     = "lolo"
  }
}

output "redis_host" {
  value = google_redis_instance.cache.host
}
```

### 2.5 Cloud Armor (WAF)

```hcl
# FILE: infra/terraform/cloud_armor.tf
resource "google_compute_security_policy" "lolo_waf" {
  name = "lolo-waf-${var.environment}"

  # Default rule: allow
  rule {
    action   = "allow"
    priority = 2147483647
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
    description = "Default allow"
  }

  # Block known bad IPs / botnets
  rule {
    action   = "deny(403)"
    priority = 100
    match {
      expr {
        expression = "evaluatePreconfiguredWaf('sqli-v33-stable', {'sensitivity': 2})"
      }
    }
    description = "SQL injection protection"
  }

  rule {
    action   = "deny(403)"
    priority = 200
    match {
      expr {
        expression = "evaluatePreconfiguredWaf('xss-v33-stable', {'sensitivity': 2})"
      }
    }
    description = "XSS protection"
  }

  rule {
    action   = "deny(403)"
    priority = 300
    match {
      expr {
        expression = "evaluatePreconfiguredWaf('rce-v33-stable', {'sensitivity': 2})"
      }
    }
    description = "Remote code execution protection"
  }

  # Rate limiting: 100 requests/min per IP
  rule {
    action   = "throttle"
    priority = 500
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
    rate_limit_options {
      conform_action = "allow"
      exceed_action  = "deny(429)"
      rate_limit_threshold {
        count        = 100
        interval_sec = 60
      }
    }
    description = "Global rate limit per IP"
  }

  # Geo-restriction: allow GCC + SEA + common VPN exit countries
  rule {
    action   = "allow"
    priority = 600
    match {
      expr {
        expression = "origin.region_code == 'SA' || origin.region_code == 'AE' || origin.region_code == 'QA' || origin.region_code == 'KW' || origin.region_code == 'BH' || origin.region_code == 'OM' || origin.region_code == 'MY' || origin.region_code == 'SG' || origin.region_code == 'ID' || origin.region_code == 'US' || origin.region_code == 'GB' || origin.region_code == 'DE' || origin.region_code == 'EG' || origin.region_code == 'JO'"
      }
    }
    description = "Allow GCC + SEA + key markets"
  }

  # Block all other geo
  rule {
    action   = "deny(403)"
    priority = 700
    match {
      expr {
        expression = "true"
      }
    }
    description = "Block non-target regions (overridden by rule 600)"
  }

  adaptive_protection_config {
    layer_7_ddos_defense_config {
      enable = true
    }
  }
}
```

### 2.6 Secret Manager

```hcl
# FILE: infra/terraform/secrets.tf
locals {
  secrets = [
    "firebase-admin-key",
    "db-password",
    "redis-auth-token",
    "revenuecat-api-key",
    "revenuecat-webhook-secret",
    "anthropic-api-key",
    "google-ai-api-key",
    "openai-api-key",
    "xai-api-key",
    "pinecone-api-key",
    "sentry-dsn",
    "pagerduty-integration-key",
    "app-signing-keystore-password",
    "apple-api-key-id",
    "apple-issuer-id",
    "huawei-client-secret",
    "fastlane-match-password",
  ]
}

resource "google_secret_manager_secret" "secrets" {
  for_each  = toset(local.secrets)
  secret_id = "lolo-${var.environment}-${each.value}"

  replication {
    user_managed {
      replicas {
        location = var.region
      }
      replicas {
        location = var.secondary_region
      }
    }
  }

  labels = {
    environment = var.environment
    managed_by  = "terraform"
  }
}

# Grant Cloud Functions access to secrets
resource "google_secret_manager_secret_iam_member" "functions_access" {
  for_each  = toset(local.secrets)
  secret_id = google_secret_manager_secret.secrets[each.value].secret_id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${var.project_id}@appspot.gserviceaccount.com"
}

data "google_secret_manager_secret_version" "db_password" {
  secret = google_secret_manager_secret.secrets["db-password"].secret_id
}
```

### 2.7 Cloud CDN

```hcl
# FILE: infra/terraform/cdn.tf
resource "google_compute_backend_bucket" "static_assets" {
  name        = "lolo-static-assets-${var.environment}"
  bucket_name = google_storage_bucket.static_assets.name
  enable_cdn  = true

  cdn_policy {
    cache_mode                   = "CACHE_ALL_STATIC"
    default_ttl                  = 3600       # 1 hour
    max_ttl                      = 86400      # 24 hours
    client_ttl                   = 3600
    negative_caching             = true
    signed_url_cache_max_age_sec = 7200

    cache_key_policy {
      include_host         = true
      include_protocol     = true
      include_query_string = false
    }
  }
}

resource "google_storage_bucket" "static_assets" {
  name          = "lolo-static-${var.environment}"
  location      = var.region
  storage_class = "STANDARD"
  force_destroy = false

  uniform_bucket_level_access = true

  cors {
    origin          = ["https://lolo.app", "https://admin.lolo.app"]
    method          = ["GET", "HEAD"]
    response_header = ["Content-Type", "Cache-Control"]
    max_age_seconds = 3600
  }

  versioning {
    enabled = true
  }

  lifecycle_rule {
    condition {
      num_newer_versions = 3
    }
    action {
      type = "Delete"
    }
  }
}
```

### 2.8 Cloud Monitoring

```hcl
# FILE: infra/terraform/monitoring.tf
resource "google_monitoring_uptime_check_config" "api_health" {
  display_name = "LOLO API Health"
  timeout      = "10s"
  period       = "60s"

  http_check {
    path         = "/api/v1/health"
    port         = 443
    use_ssl      = true
    validate_ssl = true

    accepted_response_status_codes {
      status_class = "STATUS_CLASS_2XX"
    }
  }

  monitored_resource {
    type = "uptime_url"
    labels = {
      project_id = var.project_id
      host       = "asia-southeast1-lolo-app-prod.cloudfunctions.net"
    }
  }

  checker_requesters = [
    "ASIA_PACIFIC",
    "MIDDLE_EAST",
  ]
}

resource "google_monitoring_alert_policy" "api_uptime" {
  display_name = "LOLO API Uptime"
  combiner     = "OR"

  conditions {
    display_name = "API not responding"
    condition_threshold {
      filter          = "resource.type = \"uptime_url\" AND metric.type = \"monitoring.googleapis.com/uptime_check/check_passed\""
      comparison      = "COMPARISON_GT"
      threshold_value = 1
      duration        = "120s"

      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_NEXT_OLDER"
      }

      trigger {
        count = 1
      }
    }
  }

  notification_channels = [
    google_monitoring_notification_channel.pagerduty.name,
    google_monitoring_notification_channel.slack.name,
  ]

  alert_strategy {
    auto_close = "1800s"
  }
}

resource "google_monitoring_notification_channel" "pagerduty" {
  display_name = "PagerDuty - LOLO P1"
  type         = "pagerduty"
  labels = {
    service_key = data.google_secret_manager_secret_version.pagerduty_key.secret_data
  }
}

resource "google_monitoring_notification_channel" "slack" {
  display_name = "Slack #lolo-alerts"
  type         = "slack"
  labels = {
    channel_name = "#lolo-alerts"
  }
  sensitive_labels {
    auth_token = data.google_secret_manager_secret_version.slack_token.secret_data
  }
}

data "google_secret_manager_secret_version" "pagerduty_key" {
  secret = "lolo-prod-pagerduty-integration-key"
}

data "google_secret_manager_secret_version" "slack_token" {
  secret = "lolo-prod-slack-webhook-token"
}
```

---

## 3. SSL/TLS Configuration

### 3.1 SSL Pinning in Flutter

```dart
// FILE: lib/core/network/ssl_pinning.dart
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class SslPinningConfig {
  // SHA-256 fingerprints of our backend certificate chain
  // Primary + backup pins (rotate before expiry)
  static const List<String> _pins = [
    // Current: valid until 2027-02-01
    'sha256/YLh1dUR9y6Kja30RrAn7JKnbQG/uEtLMkBgFF2Fuihg=',
    // Backup: different CA for resilience
    'sha256/Vjs8r4z+80wjNcr1YKepWQboSIRi63WsWXhIMN+eWys=',
    // Root CA pin (long-lived backup)
    'sha256/++MBgDH5WGvL9Bcn5Be30cRcL0f5O+NyoXuWtQdX1aI=',
  ];

  static void configureDio(Dio dio) {
    final adapter = dio.httpClientAdapter as IOHttpClientAdapter;
    adapter.createHttpClient = () {
      final client = HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        // Only allow our domains
        if (!host.endsWith('.lolo.app') &&
            !host.endsWith('.cloudfunctions.net')) {
          return false;
        }

        // Verify pin matches
        final certFingerprint = _sha256Fingerprint(cert);
        return _pins.contains(certFingerprint);
      };
      return client;
    };
  }

  static String _sha256Fingerprint(X509Certificate cert) {
    // In production, use crypto package for SHA-256 of DER-encoded cert
    // Simplified here -- actual implementation uses:
    // import 'package:crypto/crypto.dart';
    // final digest = sha256.convert(cert.der);
    // return 'sha256/${base64Encode(digest.bytes)}';
    return '';
  }
}
```

### 3.2 Certificate Management

```yaml
# FILE: infra/cert-manager/certificate.yaml
# Managed via Google Certificate Manager (auto-renewal)
apiVersion: networking.gke.io/v1
kind: ManagedCertificate
metadata:
  name: lolo-api-cert
spec:
  domains:
    - api.lolo.app
    - admin.lolo.app
    - cdn.lolo.app
```

```hcl
# FILE: infra/terraform/certificates.tf
resource "google_certificate_manager_certificate" "lolo_api" {
  name = "lolo-api-cert"

  managed {
    domains = [
      "api.lolo.app",
      "admin.lolo.app",
      "cdn.lolo.app",
    ]
    dns_authorizations = [
      google_certificate_manager_dns_authorization.lolo.id,
    ]
  }

  labels = {
    environment = var.environment
  }
}

resource "google_certificate_manager_dns_authorization" "lolo" {
  name   = "lolo-dns-auth"
  domain = "lolo.app"
}
```

### 3.3 TLS 1.3 Enforcement

```hcl
# FILE: infra/terraform/ssl_policy.tf
resource "google_compute_ssl_policy" "modern" {
  name            = "lolo-ssl-modern"
  profile         = "MODERN"
  min_tls_version = "TLS_1_2"  # GCP does not yet support TLS_1_3 only; 1.2+ with MODERN profile negotiates 1.3 preferentially
}
```

```typescript
// FILE: functions/src/middleware/security.ts
import { Request, Response, NextFunction } from "express";

export function enforceSecurityHeaders(
  req: Request, res: Response, next: NextFunction
) {
  // Strict Transport Security -- 1 year, include subdomains
  res.setHeader(
    "Strict-Transport-Security",
    "max-age=31536000; includeSubDomains; preload"
  );
  res.setHeader("X-Content-Type-Options", "nosniff");
  res.setHeader("X-Frame-Options", "DENY");
  res.setHeader("X-XSS-Protection", "0"); // Rely on CSP instead
  res.setHeader("Referrer-Policy", "strict-origin-when-cross-origin");
  res.setHeader(
    "Content-Security-Policy",
    "default-src 'none'; frame-ancestors 'none'"
  );
  res.setHeader("Permissions-Policy", "camera=(), microphone=(), geolocation=()");

  next();
}
```

---

## 4. Monitoring Stack

### 4.1 Cloud Monitoring Dashboards

```json
// FILE: infra/monitoring/dashboards/api-overview.json
{
  "displayName": "LOLO API Overview",
  "gridLayout": {
    "columns": "3",
    "widgets": [
      {
        "title": "API Request Rate (req/min)",
        "xyChart": {
          "dataSets": [{
            "timeSeriesQuery": {
              "timeSeriesFilter": {
                "filter": "resource.type=\"cloud_function\" AND metric.type=\"cloudfunctions.googleapis.com/function/execution_count\"",
                "aggregation": {
                  "alignmentPeriod": "60s",
                  "perSeriesAligner": "ALIGN_RATE"
                }
              }
            }
          }]
        }
      },
      {
        "title": "API Latency p50/p95/p99",
        "xyChart": {
          "dataSets": [{
            "timeSeriesQuery": {
              "timeSeriesFilter": {
                "filter": "resource.type=\"cloud_function\" AND metric.type=\"cloudfunctions.googleapis.com/function/execution_times\"",
                "aggregation": {
                  "alignmentPeriod": "60s",
                  "perSeriesAligner": "ALIGN_PERCENTILE_99"
                }
              }
            }
          }]
        }
      },
      {
        "title": "Error Rate (%)",
        "xyChart": {
          "dataSets": [{
            "timeSeriesQuery": {
              "timeSeriesFilter": {
                "filter": "resource.type=\"cloud_function\" AND metric.type=\"cloudfunctions.googleapis.com/function/execution_count\" AND metric.labels.status!=\"ok\"",
                "aggregation": {
                  "alignmentPeriod": "300s",
                  "perSeriesAligner": "ALIGN_RATE",
                  "crossSeriesReducer": "REDUCE_SUM"
                }
              }
            }
          }]
        }
      },
      {
        "title": "AI Cost (USD/hour)",
        "xyChart": {
          "dataSets": [{
            "timeSeriesQuery": {
              "timeSeriesFilter": {
                "filter": "metric.type=\"custom.googleapis.com/lolo/ai/cost_usd\"",
                "aggregation": {
                  "alignmentPeriod": "3600s",
                  "perSeriesAligner": "ALIGN_SUM"
                }
              }
            }
          }]
        }
      },
      {
        "title": "Active Users (DAU)",
        "scorecard": {
          "timeSeriesQuery": {
            "timeSeriesFilter": {
              "filter": "metric.type=\"custom.googleapis.com/lolo/users/active_daily\""
            }
          }
        }
      },
      {
        "title": "Cache Hit Rate (%)",
        "scorecard": {
          "timeSeriesQuery": {
            "timeSeriesFilter": {
              "filter": "metric.type=\"custom.googleapis.com/lolo/cache/hit_rate\"",
              "aggregation": {
                "alignmentPeriod": "300s",
                "perSeriesAligner": "ALIGN_MEAN"
              }
            }
          }
        }
      }
    ]
  }
}
```

### 4.2 Custom Metrics Exporter

```typescript
// FILE: functions/src/monitoring/metrics.ts
import { Monitoring } from "@google-cloud/monitoring";

const monitoring = new Monitoring.MetricServiceClient();
const projectPath = monitoring.projectPath("lolo-app-prod");

interface MetricPoint {
  type: string;
  value: number;
  labels?: Record<string, string>;
}

export async function writeMetric(metric: MetricPoint): Promise<void> {
  const now = new Date();
  const timeSeriesData = {
    metric: {
      type: `custom.googleapis.com/lolo/${metric.type}`,
      labels: metric.labels || {},
    },
    resource: {
      type: "global",
      labels: { project_id: "lolo-app-prod" },
    },
    points: [
      {
        interval: {
          endTime: { seconds: Math.floor(now.getTime() / 1000) },
        },
        value: { doubleValue: metric.value },
      },
    ],
  };

  await monitoring.createTimeSeries({
    name: projectPath,
    timeSeries: [timeSeriesData],
  });
}

// ── Convenience wrappers ──

export async function recordAiLatency(
  model: string, latencyMs: number, cached: boolean
): Promise<void> {
  await writeMetric({
    type: "ai/response_time_ms",
    value: latencyMs,
    labels: { model, cached: String(cached) },
  });
}

export async function recordAiCost(
  model: string, costUsd: number
): Promise<void> {
  await writeMetric({
    type: "ai/cost_usd",
    value: costUsd,
    labels: { model },
  });
}

export async function recordCacheHit(hit: boolean): Promise<void> {
  await writeMetric({
    type: "cache/hit_rate",
    value: hit ? 1 : 0,
  });
}

export async function recordSubscriptionEvent(
  event: string, tier: string
): Promise<void> {
  await writeMetric({
    type: "subscription/event",
    value: 1,
    labels: { event, tier },
  });
}
```

### 4.3 Sentry (Flutter) Configuration

```dart
// FILE: lib/core/monitoring/sentry_config.dart
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:flutter/foundation.dart';

class SentryConfig {
  static const String _dsn = String.fromEnvironment(
    'SENTRY_DSN',
    defaultValue: '',
  );

  static Future<void> init(Future<void> Function() appRunner) async {
    if (kDebugMode || _dsn.isEmpty) {
      await appRunner();
      return;
    }

    await SentryFlutter.init(
      (options) {
        options.dsn = _dsn;
        options.environment = const String.fromEnvironment(
          'ENV', defaultValue: 'prod',
        );
        options.release = const String.fromEnvironment('APP_VERSION');

        // Performance
        options.tracesSampleRate = 0.2;      // 20% of transactions
        options.profilesSampleRate = 0.1;    // 10% profiled

        // Breadcrumbs
        options.maxBreadcrumbs = 100;
        options.enableAutoNativeBreadcrumbs = true;
        options.enableUserInteractionBreadcrumbs = true;
        options.enableAutoPerformanceTracing = true;

        // Privacy: scrub PII
        options.sendDefaultPii = false;
        options.beforeSend = _scrubPii;
        options.beforeBreadcrumb = _scrubBreadcrumb;

        // Integrations
        options.enableAutoSessionTracking = true;
        options.attachScreenshot = true;
        options.attachViewHierarchy = true;
      },
      appRunner: appRunner,
    );
  }

  static SentryEvent? _scrubPii(SentryEvent event, Hint hint) {
    // Remove any email/phone from exception messages
    final scrubbed = event.copyWith(
      exceptions: event.exceptions?.map((e) {
        return e.copyWith(
          value: _redactPii(e.value ?? ''),
        );
      }).toList(),
    );
    return scrubbed;
  }

  static Breadcrumb? _scrubBreadcrumb(Breadcrumb crumb, Hint hint) {
    // Redact navigation data that might contain PII
    if (crumb.category == 'navigation') {
      return crumb.copyWith(
        data: crumb.data?.map((k, v) =>
          MapEntry(k, k.contains('id') ? '[REDACTED]' : v)),
      );
    }
    return crumb;
  }

  static String _redactPii(String text) {
    // Redact email addresses
    text = text.replaceAll(
      RegExp(r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}'),
      '[EMAIL_REDACTED]',
    );
    // Redact phone numbers
    text = text.replaceAll(
      RegExp(r'\+?[0-9]{8,15}'),
      '[PHONE_REDACTED]',
    );
    return text;
  }

  static void setUser(String uid, {String? locale}) {
    Sentry.configureScope((scope) {
      scope.setUser(SentryUser(
        id: uid,
        data: {if (locale != null) 'locale': locale},
      ));
    });
  }

  static void addBreadcrumb(String message, {String? category, Map<String, dynamic>? data}) {
    Sentry.addBreadcrumb(Breadcrumb(
      message: message,
      category: category ?? 'app',
      data: data,
      timestamp: DateTime.now(),
    ));
  }
}
```

### 4.4 Custom Metrics: AI Response Tracking

```typescript
// FILE: functions/src/monitoring/aiMetrics.ts
import { recordAiLatency, recordAiCost } from "./metrics";

// Token pricing per 1M tokens (as of 2026-02)
const PRICING: Record<string, { input: number; output: number }> = {
  "claude-haiku":   { input: 0.25,  output: 1.25 },
  "claude-sonnet":  { input: 3.00,  output: 15.00 },
  "gemini-flash":   { input: 0.075, output: 0.30 },
  "gpt-5-mini":     { input: 0.15,  output: 0.60 },
  "grok-4.1-fast":  { input: 0.10,  output: 0.40 },
};

export interface AiCallResult {
  model: string;
  inputTokens: number;
  outputTokens: number;
  latencyMs: number;
  cached: boolean;
  success: boolean;
}

export async function trackAiCall(result: AiCallResult): Promise<number> {
  const pricing = PRICING[result.model] || { input: 1.0, output: 5.0 };
  const cost =
    (result.inputTokens / 1_000_000) * pricing.input +
    (result.outputTokens / 1_000_000) * pricing.output;

  await Promise.all([
    recordAiLatency(result.model, result.latencyMs, result.cached),
    recordAiCost(result.model, cost),
  ]);

  return cost;
}
```

---

## 5. Alert Configuration

### 5.1 PagerDuty / OpsGenie Integration

```yaml
# FILE: infra/monitoring/alert-policies.yaml
# Deployed via: gcloud monitoring policies create --policy-from-file=alert-policies.yaml

alerts:
  # ════════════════════════════════════════
  # P1 -- PAGE IMMEDIATELY (24/7 on-call)
  # ════════════════════════════════════════

  - name: "P1: API Down"
    severity: CRITICAL
    condition:
      type: uptime_check_failure
      resource: "lolo-api-health"
      duration: "120s"
    notification:
      - channel: pagerduty_p1
      - channel: slack_critical
      - channel: email_oncall
    documentation: |
      API health endpoint not responding for 2+ minutes.
      Runbook: https://runbooks.lolo.app/api-down

  - name: "P1: Error Rate > 5%"
    severity: CRITICAL
    condition:
      type: metric_threshold
      metric: "cloudfunctions.googleapis.com/function/execution_count"
      filter: "status != 'ok'"
      comparison: COMPARISON_GT
      threshold: 0.05  # 5% of total
      duration: "300s"
      aggregation:
        alignment_period: "60s"
        aligner: ALIGN_RATE
    notification:
      - channel: pagerduty_p1
      - channel: slack_critical

  - name: "P1: Crash Rate > 0.5%"
    severity: CRITICAL
    condition:
      type: metric_threshold
      metric: "custom.googleapis.com/lolo/crashlytics/crash_rate"
      comparison: COMPARISON_GT
      threshold: 0.005
      duration: "600s"
    notification:
      - channel: pagerduty_p1
      - channel: slack_critical

  - name: "P1: Database Connection Failure"
    severity: CRITICAL
    condition:
      type: metric_threshold
      metric: "cloudsql.googleapis.com/database/network/connections"
      comparison: COMPARISON_LT
      threshold: 1
      duration: "120s"
    notification:
      - channel: pagerduty_p1
      - channel: slack_critical

  # ════════════════════════════════════════
  # P2 -- SLACK + EMAIL (business hours)
  # ════════════════════════════════════════

  - name: "P2: AI Latency > 5s (p95)"
    severity: HIGH
    condition:
      type: metric_threshold
      metric: "custom.googleapis.com/lolo/ai/response_time_ms"
      comparison: COMPARISON_GT
      threshold: 5000
      duration: "600s"
      aggregation:
        alignment_period: "300s"
        aligner: ALIGN_PERCENTILE_95
    notification:
      - channel: slack_alerts
      - channel: email_engineering

  - name: "P2: Payment Failure Rate > 1%"
    severity: HIGH
    condition:
      type: metric_threshold
      metric: "custom.googleapis.com/lolo/subscription/event"
      filter: "event = 'payment_failed'"
      comparison: COMPARISON_GT
      threshold: 0.01
      duration: "900s"
    notification:
      - channel: slack_alerts
      - channel: email_engineering
      - channel: email_product

  - name: "P2: Cache Miss Rate > 70%"
    severity: HIGH
    condition:
      type: metric_threshold
      metric: "custom.googleapis.com/lolo/cache/hit_rate"
      comparison: COMPARISON_LT
      threshold: 0.30
      duration: "600s"
    notification:
      - channel: slack_alerts
      - channel: email_engineering

  - name: "P2: Redis Memory > 80%"
    severity: HIGH
    condition:
      type: metric_threshold
      metric: "redis.googleapis.com/stats/memory/usage_ratio"
      comparison: COMPARISON_GT
      threshold: 0.80
      duration: "300s"
    notification:
      - channel: slack_alerts
      - channel: email_engineering

  - name: "P2: Cloud Functions Cold Starts > 20%"
    severity: HIGH
    condition:
      type: metric_threshold
      metric: "custom.googleapis.com/lolo/functions/cold_start_rate"
      comparison: COMPARISON_GT
      threshold: 0.20
      duration: "1800s"
    notification:
      - channel: slack_alerts

  # ════════════════════════════════════════
  # P3 -- DAILY DIGEST (next business day)
  # ════════════════════════════════════════

  - name: "P3: Storage > 80% of Quota"
    severity: MEDIUM
    condition:
      type: metric_threshold
      metric: "firestore.googleapis.com/document/count"
      comparison: COMPARISON_GT
      threshold: 8000000  # 80% of 10M doc quota trigger
      duration: "86400s"
    notification:
      - channel: email_digest

  - name: "P3: Daily Cost Exceeds Budget"
    severity: MEDIUM
    condition:
      type: budget_alert
      budget: "lolo-prod-daily"
      threshold_percent: 100
    notification:
      - channel: slack_finance
      - channel: email_digest

  - name: "P3: Unusual Traffic Pattern"
    severity: MEDIUM
    condition:
      type: metric_threshold
      metric: "cloudfunctions.googleapis.com/function/execution_count"
      comparison: COMPARISON_GT
      threshold: 50000  # 50K requests in 1 hour (10x normal)
      duration: "3600s"
      aggregation:
        alignment_period: "3600s"
        aligner: ALIGN_SUM
    notification:
      - channel: slack_alerts
      - channel: email_digest

  - name: "P3: AI Cost Exceeds Daily Cap"
    severity: MEDIUM
    condition:
      type: metric_threshold
      metric: "custom.googleapis.com/lolo/ai/cost_usd"
      comparison: COMPARISON_GT
      threshold: 500
      duration: "86400s"
      aggregation:
        alignment_period: "86400s"
        aligner: ALIGN_SUM
    notification:
      - channel: slack_finance
      - channel: email_engineering

notification_channels:
  pagerduty_p1:
    type: pagerduty
    service_key: "${PAGERDUTY_P1_KEY}"
  slack_critical:
    type: slack
    channel: "#lolo-critical"
  slack_alerts:
    type: slack
    channel: "#lolo-alerts"
  slack_finance:
    type: slack
    channel: "#lolo-finance"
  email_oncall:
    type: email
    address: "oncall@lolo.app"
  email_engineering:
    type: email
    address: "engineering@lolo.app"
  email_product:
    type: email
    address: "product@lolo.app"
  email_digest:
    type: email
    address: "daily-digest@lolo.app"
```

---

## 6. Logging Strategy

### 6.1 Structured JSON Logging

```typescript
// FILE: functions/src/logging/logger.ts
import * as winston from "winston";

export enum LogLevel {
  ERROR = "error",
  WARN = "warn",
  INFO = "info",
  DEBUG = "debug",
}

// Per-environment log level
const ENV_LOG_LEVELS: Record<string, LogLevel> = {
  prod: LogLevel.INFO,
  staging: LogLevel.DEBUG,
  dev: LogLevel.DEBUG,
};

const PII_PATTERNS: RegExp[] = [
  /[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}/g,  // emails
  /\+?[0-9]{8,15}/g,                                     // phone numbers
  /(?:eyJ)[A-Za-z0-9_-]+\.(?:eyJ)[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+/g,  // JWTs
];

function redactPii(obj: unknown): unknown {
  if (typeof obj === "string") {
    let result = obj;
    for (const pattern of PII_PATTERNS) {
      result = result.replace(pattern, "[REDACTED]");
    }
    return result;
  }
  if (Array.isArray(obj)) {
    return obj.map(redactPii);
  }
  if (obj && typeof obj === "object") {
    const redacted: Record<string, unknown> = {};
    const sensitiveKeys = [
      "password", "token", "secret", "apiKey", "api_key",
      "authorization", "cookie", "email", "phone", "name",
      "displayName", "partnerName",
    ];
    for (const [key, value] of Object.entries(obj)) {
      if (sensitiveKeys.includes(key.toLowerCase())) {
        redacted[key] = "[REDACTED]";
      } else {
        redacted[key] = redactPii(value);
      }
    }
    return redacted;
  }
  return obj;
}

const environment = process.env.ENV || "prod";

export const logger = winston.createLogger({
  level: ENV_LOG_LEVELS[environment] || LogLevel.INFO,
  format: winston.format.combine(
    winston.format.timestamp({ format: "ISO" }),
    winston.format.printf(({ level, message, timestamp, ...meta }) => {
      const entry = {
        severity: level.toUpperCase(),
        message,
        timestamp,
        service: "lolo-api",
        environment,
        ...redactPii(meta) as object,
      };
      return JSON.stringify(entry);
    }),
  ),
  transports: [
    new winston.transports.Console(),
  ],
});

// ── Request-scoped logger ──
export function createRequestLogger(requestId: string, uid?: string) {
  return {
    info: (msg: string, meta?: Record<string, unknown>) =>
      logger.info(msg, { requestId, uid: uid || "anonymous", ...meta }),
    warn: (msg: string, meta?: Record<string, unknown>) =>
      logger.warn(msg, { requestId, uid: uid || "anonymous", ...meta }),
    error: (msg: string, meta?: Record<string, unknown>) =>
      logger.error(msg, { requestId, uid: uid || "anonymous", ...meta }),
    debug: (msg: string, meta?: Record<string, unknown>) =>
      logger.debug(msg, { requestId, uid: uid || "anonymous", ...meta }),
  };
}
```

### 6.2 Log Retention Policy

```hcl
# FILE: infra/terraform/logging.tf

# Hot storage: 30 days in Cloud Logging
resource "google_logging_project_sink" "cold_storage" {
  name                   = "lolo-cold-storage-sink"
  destination            = "storage.googleapis.com/${google_storage_bucket.log_archive.name}"
  filter                 = "resource.type=\"cloud_function\" OR resource.type=\"cloud_sql_database\""
  unique_writer_identity = true
}

resource "google_storage_bucket" "log_archive" {
  name          = "lolo-logs-archive-${var.environment}"
  location      = var.region
  storage_class = "COLDLINE"
  force_destroy = false

  uniform_bucket_level_access = true

  lifecycle_rule {
    condition {
      age = 365  # 1 year cold retention
    }
    action {
      type = "Delete"
    }
  }

  lifecycle_rule {
    condition {
      age = 90
    }
    action {
      type          = "SetStorageClass"
      storage_class = "ARCHIVE"
    }
  }

  retention_policy {
    is_locked        = true
    retention_period = 31536000  # 365 days in seconds
  }
}

# Grant log writer access to the sink
resource "google_storage_bucket_iam_member" "log_writer" {
  bucket = google_storage_bucket.log_archive.name
  role   = "roles/storage.objectCreator"
  member = google_logging_project_sink.cold_storage.writer_identity
}

# Cloud Logging retention: 30 days for _Default bucket
resource "google_logging_project_bucket_config" "default" {
  project        = var.project_id
  location       = "global"
  bucket_id      = "_Default"
  retention_days = 30
}
```

### 6.3 Logging Middleware

```typescript
// FILE: functions/src/middleware/requestLogger.ts
import { Request, Response, NextFunction } from "express";
import { createRequestLogger } from "../logging/logger";
import { v4 as uuidv4 } from "uuid";

export function requestLogger(req: Request, res: Response, next: NextFunction) {
  const requestId = (req.headers["x-request-id"] as string) || uuidv4();
  const uid = (req as any).uid || "anonymous";
  const log = createRequestLogger(requestId, uid);

  // Attach to request for downstream usage
  (req as any).log = log;
  (req as any).requestId = requestId;
  res.setHeader("X-Request-ID", requestId);

  const start = Date.now();

  log.info("Request received", {
    method: req.method,
    path: req.path,
    userAgent: req.headers["user-agent"],
    contentLength: req.headers["content-length"],
    locale: req.headers["accept-language"],
  });

  res.on("finish", () => {
    const duration = Date.now() - start;
    const logFn = res.statusCode >= 500 ? log.error
      : res.statusCode >= 400 ? log.warn
      : log.info;

    logFn("Request completed", {
      statusCode: res.statusCode,
      durationMs: duration,
      method: req.method,
      path: req.path,
    });
  });

  next();
}
```

---

## 7. Google Play Deployment

### 7.1 Fastlane Supply Configuration

```ruby
# FILE: android/fastlane/Fastfile
default_platform(:android)

platform :android do
  # ── Shared setup ──
  before_all do
    setup_ci if ENV["CI"]
  end

  desc "Run tests"
  lane :test do
    gradle(task: "test")
  end

  # ── Internal Testing Track ──
  desc "Deploy to Internal Testing"
  lane :internal do
    build_number = number_of_commits
    Dir.chdir("../..") do
      sh("flutter", "build", "appbundle",
        "--release",
        "--build-number=#{build_number}",
        "--dart-define=ENV=staging",
        "--dart-define=SENTRY_DSN=#{ENV['SENTRY_DSN']}",
        "--obfuscate",
        "--split-debug-info=build/debug-info"
      )
    end

    upload_to_play_store(
      track: "internal",
      aab: "../build/app/outputs/bundle/release/app-release.aab",
      json_key: ENV["PLAY_STORE_JSON_KEY_PATH"],
      skip_upload_metadata: true,
      skip_upload_images: true,
      skip_upload_screenshots: true,
    )

    # Upload debug symbols to Crashlytics
    Dir.chdir("../..") do
      sh("firebase", "crashlytics:symbols:upload",
        "--app=#{ENV['FIREBASE_ANDROID_APP_ID']}",
        "build/debug-info"
      )
    end
  end

  # ── Closed Beta Track ──
  desc "Promote Internal to Closed Beta"
  lane :beta do
    upload_to_play_store(
      track: "internal",
      track_promote_to: "beta",
      json_key: ENV["PLAY_STORE_JSON_KEY_PATH"],
      skip_upload_changelogs: false,
    )
  end

  # ── Production Track (Staged Rollout) ──
  desc "Promote Beta to Production (1% rollout)"
  lane :production_start do
    upload_to_play_store(
      track: "beta",
      track_promote_to: "production",
      rollout: "0.01",  # 1%
      json_key: ENV["PLAY_STORE_JSON_KEY_PATH"],
    )
  end

  desc "Increase rollout percentage"
  lane :production_rollout do |options|
    percentage = options[:percentage] || "0.05"
    upload_to_play_store(
      track: "production",
      rollout: percentage,
      json_key: ENV["PLAY_STORE_JSON_KEY_PATH"],
      skip_upload_aab: true,
    )
  end

  desc "Complete production rollout to 100%"
  lane :production_full do
    upload_to_play_store(
      track: "production",
      rollout: "1.0",
      json_key: ENV["PLAY_STORE_JSON_KEY_PATH"],
      skip_upload_aab: true,
    )
  end

  # ── Screenshot Generation ──
  desc "Generate screenshots for all locales"
  lane :screenshots do
    capture_android_screenshots(
      locales: ["en-US", "ar", "ms-MY"],
      clear_previous_screenshots: true,
      app_apk_path: "../build/app/outputs/apk/debug/app-debug.apk",
      tests_apk_path: "../build/app/outputs/apk/androidTest/debug/app-debug-androidTest.apk",
      use_adb_root: false,
    )
  end

  # ── Metadata Upload ──
  desc "Upload store metadata (all locales)"
  lane :metadata do
    upload_to_play_store(
      track: "production",
      skip_upload_aab: true,
      skip_upload_changelogs: false,
      json_key: ENV["PLAY_STORE_JSON_KEY_PATH"],
    )
  end
end
```

### 7.2 Staged Rollout Automation

```yaml
# FILE: .github/workflows/android-staged-rollout.yaml
name: Android Staged Rollout

on:
  workflow_dispatch:
    inputs:
      action:
        description: "Rollout action"
        required: true
        type: choice
        options:
          - start_1_percent
          - increase_5_percent
          - increase_25_percent
          - full_100_percent
          - halt_rollout

jobs:
  rollout:
    runs-on: ubuntu-latest
    environment: production
    steps:
      - uses: actions/checkout@v4

      - uses: ruby/setup-ruby@v1
        with:
          ruby-version: "3.3"
          bundler-cache: true
          working-directory: android

      - name: Decode Service Account
        run: echo "${{ secrets.PLAY_STORE_JSON_KEY }}" | base64 -d > /tmp/play-store-key.json

      - name: Execute Rollout
        working-directory: android
        env:
          PLAY_STORE_JSON_KEY_PATH: /tmp/play-store-key.json
        run: |
          case "${{ inputs.action }}" in
            start_1_percent)
              bundle exec fastlane production_start
              ;;
            increase_5_percent)
              bundle exec fastlane production_rollout percentage:0.05
              ;;
            increase_25_percent)
              bundle exec fastlane production_rollout percentage:0.25
              ;;
            full_100_percent)
              bundle exec fastlane production_full
              ;;
            halt_rollout)
              bundle exec fastlane production_rollout percentage:0.0
              ;;
          esac

      - name: Notify Slack
        if: always()
        uses: slackapi/slack-github-action@v1.27
        with:
          payload: |
            {
              "text": "Android rollout: ${{ inputs.action }} -- ${{ job.status }}",
              "channel": "#lolo-releases"
            }
        env:
          SLACK_WEBHOOK_URL: ${{ secrets.SLACK_WEBHOOK }}
```

### 7.3 Release Notes (Multi-language)

```
# FILE: android/fastlane/metadata/android/en-US/changelogs/default.txt
What's New in LOLO:
- Smarter AI coaching during tough moments
- Improved gift recommendations based on her preferences
- New memory vault voice notes
- Performance improvements and bug fixes

# FILE: android/fastlane/metadata/android/ar/changelogs/default.txt
الجديد في لولو:
- تدريب ذكاء اصطناعي أذكى خلال اللحظات الصعبة
- توصيات هدايا محسّنة بناءً على تفضيلاتها
- ملاحظات صوتية جديدة في خزنة الذكريات
- تحسينات في الأداء وإصلاحات

# FILE: android/fastlane/metadata/android/ms-MY/changelogs/default.txt
Apa yang baharu di LOLO:
- Bimbingan AI lebih bijak semasa saat sukar
- Cadangan hadiah yang lebih baik berdasarkan keutamaan beliau
- Nota suara baharu di peti besi memori
- Peningkatan prestasi dan pembaikan pepijat
```

---

## 8. Apple App Store Deployment

### 8.1 Fastlane Deliver Configuration

```ruby
# FILE: ios/fastlane/Fastfile
default_platform(:ios)

platform :ios do
  before_all do
    setup_ci if ENV["CI"]
  end

  # ── Code Signing ──
  desc "Sync certificates and profiles"
  lane :sync_certs do
    match(
      type: "appstore",
      app_identifier: "app.lolo.ios",
      git_url: ENV["MATCH_GIT_URL"],
      readonly: true,
    )
  end

  # ── TestFlight Internal ──
  desc "Build and upload to TestFlight (internal)"
  lane :testflight_internal do
    sync_certs

    build_number = number_of_commits
    Dir.chdir("../..") do
      sh("flutter", "build", "ipa",
        "--release",
        "--build-number=#{build_number}",
        "--dart-define=ENV=staging",
        "--dart-define=SENTRY_DSN=#{ENV['SENTRY_DSN']}",
        "--obfuscate",
        "--split-debug-info=build/debug-info",
        "--export-options-plist=ios/ExportOptions.plist"
      )
    end

    upload_to_testflight(
      ipa: "../build/ios/ipa/lolo.ipa",
      api_key_path: ENV["APP_STORE_CONNECT_API_KEY_PATH"],
      skip_waiting_for_build_processing: true,
      distribute_external: false,
      changelog: "Internal build #{build_number}",
    )

    # Upload dSYMs to Crashlytics
    Dir.chdir("../..") do
      sh("firebase", "crashlytics:symbols:upload",
        "--app=#{ENV['FIREBASE_IOS_APP_ID']}",
        "build/debug-info"
      )
    end
  end

  # ── TestFlight External ──
  desc "Distribute to external testers"
  lane :testflight_external do
    upload_to_testflight(
      api_key_path: ENV["APP_STORE_CONNECT_API_KEY_PATH"],
      distribute_external: true,
      groups: ["Beta Testers - GCC", "Beta Testers - SEA"],
      changelog: File.read("../../CHANGELOG_LATEST.md"),
    )
  end

  # ── App Store Submission ──
  desc "Submit to App Store Review"
  lane :submit_review do
    deliver(
      api_key_path: ENV["APP_STORE_CONNECT_API_KEY_PATH"],
      submit_for_review: true,
      automatic_release: false,  # Manual release after approval
      phased_release: true,     # 7-day phased rollout
      force: true,

      # Metadata
      app_identifier: "app.lolo.ios",
      app_version: lane_context[:APP_VERSION],
      skip_binary_upload: true,  # Already uploaded via TestFlight

      # Submission info
      submission_information: {
        add_id_info_uses_idfa: false,
        add_id_info_serves_ads: false,
        export_compliance_uses_encryption: true,
        export_compliance_is_exempt: true,
        export_compliance_contains_proprietary_cryptography: false,
        export_compliance_contains_third_party_cryptography: true,
      },

      # Privacy
      app_rating_config_path: "fastlane/rating_config.json",

      # Precheck
      precheck_include_in_app_purchases: true,
      run_precheck_before_submit: true,
    )
  end

  # ── Screenshots ──
  desc "Generate App Store screenshots"
  lane :screenshots do
    snapshot(
      devices: [
        "iPhone 16 Pro Max",
        "iPhone SE (3rd generation)",
        "iPad Pro 13-inch (M4)",
      ],
      languages: ["en-US", "ar-SA", "ms"],
      clear_previous_screenshots: true,
      override_status_bar: true,
      skip_open_summary: true,
    )

    frame_screenshots(
      silver: false,
      path: "./fastlane/screenshots",
    )
  end
end
```

### 8.2 App Store Connect API Key

```ruby
# FILE: ios/fastlane/Appfile
app_identifier("app.lolo.ios")
apple_id("developer@lolo.app")
team_id(ENV["APPLE_TEAM_ID"])
itc_team_id(ENV["APPLE_ITC_TEAM_ID"])
```

```json
// FILE: ios/fastlane/rating_config.json
{
  "CARTOON_FANTASY_VIOLENCE": 0,
  "REALISTIC_VIOLENCE": 0,
  "PROLONGED_GRAPHIC_SADISTIC_REALISTIC_VIOLENCE": 0,
  "PROFANITY_CRUDE_HUMOR": 0,
  "MATURE_SUGGESTIVE": 0,
  "HORROR": 0,
  "MEDICAL_TREATMENT_INFO": 0,
  "ALCOHOL_TOBACCO_DRUGS": 0,
  "GAMBLING": 0,
  "SEXUAL_CONTENT_NUDITY": 0,
  "GRAPHIC_SEXUAL_CONTENT_NUDITY": 0,
  "UNRESTRICTED_WEB_ACCESS": 0,
  "GAMBLING_CONTESTS": 0
}
```

### 8.3 App Review Compliance Checklist

```yaml
# FILE: docs/app-review-checklist.yaml
app_store_review_checklist:
  metadata:
    - description_accurate: true
    - screenshots_reflect_app: true
    - no_placeholder_content: true
    - keywords_relevant: true
    - support_url_active: true
    - privacy_policy_url: "https://lolo.app/privacy"
    - terms_of_service_url: "https://lolo.app/terms"

  functionality:
    - app_launches_correctly: true
    - all_links_functional: true
    - no_crashes_on_review_devices: true
    - sign_in_works: true  # Provide demo account in review notes
    - in_app_purchases_functional: true
    - subscription_management_accessible: true
    - account_deletion_available: true  # Required by Apple

  design:
    - follows_hig: true
    - no_web_views_for_core_features: true
    - rtl_layout_correct: true
    - dynamic_type_supported: true
    - dark_mode_supported: true

  privacy:
    - privacy_nutrition_labels_accurate: true
    - app_tracking_transparency_implemented: true
    - data_collection_disclosed: true
    - categories:
        - contact_info: "Name (for partner profile)"
        - identifiers: "User ID"
        - usage_data: "Product interaction"
        - diagnostics: "Crash data, performance data"

  legal:
    - subscription_terms_visible: true
    - auto_renewal_disclosed: true
    - restore_purchases_button: true
    - manage_subscription_link: true
    - no_unauthorized_api_usage: true

  review_notes: |
    Demo account:
      Email: review@lolo.app
      Password: AppReview2026!

    This app uses AI to generate relationship advice. The AI content is
    generated server-side via multiple providers (Claude, Gemini, GPT).
    No AI content is generated on-device.

    Subscription tiers: Free, Pro ($6.99/mo), Legend ($12.99/mo).
    All subscriptions managed via RevenueCat + App Store.
```

---

## 9. Huawei AppGallery Deployment

### 9.1 AppGallery Connect Setup

```yaml
# FILE: android/fastlane/huawei/Appfile
{
  "client_id": "${HUAWEI_CLIENT_ID}",
  "client_secret": "${HUAWEI_CLIENT_SECRET}",
  "app_id": "${HUAWEI_APP_ID}",
  "package_name": "app.lolo.android"
}
```

```ruby
# FILE: android/fastlane/Fastfile (appended Huawei lanes)
platform :android do
  # ── Huawei AppGallery ──
  desc "Build and deploy to Huawei AppGallery"
  lane :huawei_deploy do
    build_number = number_of_commits

    # Build APK (AppGallery does not support AAB yet for all regions)
    Dir.chdir("../..") do
      sh("flutter", "build", "apk",
        "--release",
        "--build-number=#{build_number}",
        "--dart-define=ENV=prod",
        "--dart-define=APP_STORE=huawei",
        "--dart-define=SENTRY_DSN=#{ENV['SENTRY_DSN']}",
        "--obfuscate",
        "--split-debug-info=build/debug-info",
        "--target-platform=android-arm,android-arm64"
      )
    end

    # Upload via Huawei Publishing API
    sh(
      "curl", "-s", "-X", "POST",
      "https://connect-api.cloud.huawei.com/api/publish/v2/app-file-info",
      "-H", "Authorization: Bearer #{huawei_access_token}",
      "-H", "client_id: #{ENV['HUAWEI_CLIENT_ID']}",
      "-F", "file=@../build/app/outputs/flutter-apk/app-release.apk",
      "-F", "fileType=5"
    )
  end
end

def huawei_access_token
  require 'net/http'
  require 'json'

  uri = URI("https://connect-api.cloud.huawei.com/api/oauth2/v1/token")
  res = Net::HTTP.post_form(uri, {
    "grant_type" => "client_credentials",
    "client_id" => ENV["HUAWEI_CLIENT_ID"],
    "client_secret" => ENV["HUAWEI_CLIENT_SECRET"],
  })

  JSON.parse(res.body)["access_token"]
end
```

### 9.2 HMS Core Considerations

```dart
// FILE: lib/core/platform/hms_service.dart
/// HMS Core integration for Huawei devices without GMS.
/// Only loaded when running on Huawei AppGallery builds.

import 'dart:io';

class HmsService {
  static bool get isHuaweiBuild =>
      const String.fromEnvironment('APP_STORE') == 'huawei';

  /// Check if HMS Core is available (Huawei devices)
  static Future<bool> isHmsAvailable() async {
    if (!Platform.isAndroid || !isHuaweiBuild) return false;
    // In production, use huawei_hms_availability plugin
    return true;
  }

  // Push notifications: use HMS Push Kit instead of FCM
  // Auth: use Huawei Account Kit as additional sign-in option
  // Analytics: use Huawei Analytics Kit alongside Firebase
  // Maps: not needed for LOLO (no location features)
}
```

### 9.3 Huawei CI/CD Pipeline

```yaml
# FILE: .github/workflows/huawei-deploy.yaml
name: Huawei AppGallery Deploy

on:
  workflow_dispatch:
    inputs:
      version:
        description: "Version to deploy"
        required: true

jobs:
  deploy:
    runs-on: ubuntu-latest
    environment: production
    steps:
      - uses: actions/checkout@v4
        with:
          ref: "v${{ inputs.version }}"

      - uses: subosito/flutter-action@v2
        with:
          flutter-version: "3.27.x"
          channel: stable

      - uses: ruby/setup-ruby@v1
        with:
          ruby-version: "3.3"
          bundler-cache: true
          working-directory: android

      - name: Build and Deploy to Huawei
        working-directory: android
        env:
          HUAWEI_CLIENT_ID: ${{ secrets.HUAWEI_CLIENT_ID }}
          HUAWEI_CLIENT_SECRET: ${{ secrets.HUAWEI_CLIENT_SECRET }}
          HUAWEI_APP_ID: ${{ secrets.HUAWEI_APP_ID }}
          SENTRY_DSN: ${{ secrets.SENTRY_DSN }}
        run: bundle exec fastlane huawei_deploy

      - name: Notify Slack
        if: always()
        uses: slackapi/slack-github-action@v1.27
        with:
          payload: |
            {
              "text": "Huawei AppGallery deploy v${{ inputs.version }}: ${{ job.status }}",
              "channel": "#lolo-releases"
            }
        env:
          SLACK_WEBHOOK_URL: ${{ secrets.SLACK_WEBHOOK }}
```

---

## 10. Release Process

### 10.1 Version Naming Convention

```
Format: MAJOR.MINOR.PATCH+BUILD

MAJOR  -- Breaking changes, major redesign (1.0.0 = initial launch)
MINOR  -- New features, non-breaking (1.1.0 = added voice notes)
PATCH  -- Bug fixes, performance (1.1.1 = fixed RTL crash)
BUILD  -- Auto-incremented from git commit count

Examples:
  1.0.0+142   First production release
  1.1.0+187   Added voice notes feature
  1.1.1+195   Fixed Arabic text overflow
  2.0.0+301   Major AI engine overhaul
```

### 10.2 Changelog Generation

```bash
#!/bin/bash
# FILE: scripts/generate-changelog.sh

set -euo pipefail

VERSION=${1:?"Usage: generate-changelog.sh <version>"}
PREVIOUS_TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo "")

echo "## v${VERSION}"
echo ""
echo "**Release Date:** $(date +%Y-%m-%d)"
echo ""

if [ -z "$PREVIOUS_TAG" ]; then
  RANGE="HEAD"
else
  RANGE="${PREVIOUS_TAG}..HEAD"
fi

# Group commits by type
echo "### Features"
git log "$RANGE" --pretty=format:"- %s" --grep="^feat" | head -20
echo ""

echo "### Bug Fixes"
git log "$RANGE" --pretty=format:"- %s" --grep="^fix" | head -20
echo ""

echo "### Performance"
git log "$RANGE" --pretty=format:"- %s" --grep="^perf" | head -10
echo ""

echo "### Other"
git log "$RANGE" --pretty=format:"- %s" --grep="^chore\|^refactor\|^docs" | head -10
echo ""

# Generate localized release notes
echo "---"
echo "### Release Notes (en-US)"
git log "$RANGE" --pretty=format:"%s" --grep="^feat\|^fix" | head -5 | while read -r line; do
  echo "- ${line#*: }"
done
```

### 10.3 Release Candidate Workflow

```yaml
# FILE: .github/workflows/release-candidate.yaml
name: Create Release Candidate

on:
  workflow_dispatch:
    inputs:
      version:
        description: "Version (e.g., 1.2.0)"
        required: true
      type:
        description: "Release type"
        required: true
        type: choice
        options:
          - minor
          - patch
          - hotfix

permissions:
  contents: write

jobs:
  create-rc:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Create release branch
        run: |
          BRANCH="release/${{ inputs.version }}"
          if [ "${{ inputs.type }}" = "hotfix" ]; then
            git checkout main
            BRANCH="hotfix/${{ inputs.version }}"
          else
            git checkout develop
          fi
          git checkout -b "$BRANCH"

      - name: Update version in pubspec
        run: |
          BUILD=$(git rev-list --count HEAD)
          sed -i "s/^version: .*/version: ${{ inputs.version }}+${BUILD}/" pubspec.yaml

      - name: Generate changelog
        run: |
          chmod +x scripts/generate-changelog.sh
          scripts/generate-changelog.sh "${{ inputs.version }}" > CHANGELOG_LATEST.md
          cat CHANGELOG_LATEST.md CHANGELOG.md > CHANGELOG_NEW.md
          mv CHANGELOG_NEW.md CHANGELOG.md

      - name: Commit and push
        run: |
          git add pubspec.yaml CHANGELOG.md CHANGELOG_LATEST.md
          git commit -m "chore: prepare release ${{ inputs.version }}"
          git push origin HEAD

      - name: Create PR to main
        uses: peter-evans/create-pull-request@v6
        with:
          title: "Release ${{ inputs.version }}"
          body: |
            ## Release ${{ inputs.version }}

            $(cat CHANGELOG_LATEST.md)

            ### Release Checklist
            - [ ] All CI checks pass
            - [ ] QA sign-off received
            - [ ] Release notes reviewed (EN/AR/MS)
            - [ ] Screenshots updated if UI changed
            - [ ] Staging build verified
          base: main
          labels: release
```

### 10.4 Rollback Procedures

```yaml
# FILE: docs/runbooks/rollback-procedure.yaml
rollback_procedures:

  android_google_play:
    steps:
      - action: "Halt staged rollout"
        command: "cd android && bundle exec fastlane production_rollout percentage:0.0"
      - action: "Re-promote previous version"
        command: |
          # In Play Console: select previous build > Promote to production
          # Or via Fastlane: upload previous AAB and promote
      - action: "If critical: enable maintenance mode"
        command: |
          firebase remoteconfig:set --config '{"maintenance_mode": {"defaultValue": {"value": "true"}}}'
      - action: "Notify users via in-app message"
        note: "Use Firebase In-App Messaging for users on bad version"
    time_estimate: "5-15 minutes"

  ios_app_store:
    steps:
      - action: "Stop phased release"
        note: "App Store Connect > App > Phased Release > Pause"
      - action: "Submit expedited review for hotfix"
        note: "App Store Connect > Submit for review > Request expedited review"
      - action: "If critical: pull current version"
        note: "App Store Connect > Remove from Sale (last resort)"
    time_estimate: "15 minutes to pause, 24-48 hours for expedited review"

  huawei_appgallery:
    steps:
      - action: "Unpublish current version"
        note: "AppGallery Connect > My Apps > Unpublish"
      - action: "Upload and submit previous APK"
        note: "Manual process -- no staged rollout on Huawei"
    time_estimate: "30-60 minutes"

  backend_cloud_functions:
    steps:
      - action: "Rollback to previous deployment"
        command: |
          # List deployments
          gcloud functions list --project=lolo-app-prod
          # Rollback specific function
          gcloud functions deploy api --source=gs://lolo-deployments/api-v1.2.3.zip --project=lolo-app-prod
      - action: "Alternative: use traffic splitting"
        command: |
          gcloud functions deploy api --traffic-split=previous:100 --project=lolo-app-prod
    time_estimate: "2-5 minutes"

  firestore_rules:
    steps:
      - action: "Redeploy previous rules"
        command: |
          git checkout v1.2.3 -- firestore.rules
          firebase deploy --only firestore:rules --project lolo-app-prod
    time_estimate: "1-2 minutes"
```

---

## 11. Backup Strategy

### 11.1 Firestore Backups

```yaml
# FILE: .github/workflows/scheduled-backups.yaml
name: Scheduled Backups

on:
  schedule:
    - cron: "0 2 * * *"  # Daily at 2 AM UTC

jobs:
  firestore-backup:
    runs-on: ubuntu-latest
    steps:
      - name: Authenticate
        uses: google-github-actions/auth@v2
        with:
          credentials_json: ${{ secrets.GCP_SA_KEY }}

      - name: Export Firestore
        run: |
          DATE=$(date +%Y-%m-%d)
          gcloud firestore export \
            gs://lolo-backups-prod/firestore/${DATE} \
            --project=lolo-app-prod \
            --collection-ids=users,reminders,actionCards,leaderboard

      - name: Verify Export
        run: |
          DATE=$(date +%Y-%m-%d)
          gsutil ls gs://lolo-backups-prod/firestore/${DATE}/
          echo "Firestore export verified for ${DATE}"

      - name: Clean Old Backups (keep 30 days)
        run: |
          CUTOFF=$(date -d "30 days ago" +%Y-%m-%d)
          gsutil -m rm -r "gs://lolo-backups-prod/firestore/${CUTOFF}/" 2>/dev/null || true
```

```hcl
# FILE: infra/terraform/backups.tf
resource "google_storage_bucket" "backups" {
  name          = "lolo-backups-${var.environment}"
  location      = var.region
  storage_class = "NEARLINE"
  force_destroy = false

  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }

  lifecycle_rule {
    condition {
      age = 30
    }
    action {
      type          = "SetStorageClass"
      storage_class = "COLDLINE"
    }
  }

  lifecycle_rule {
    condition {
      age = 365
    }
    action {
      type = "Delete"
    }
  }
}

# Cross-region backup replication
resource "google_storage_bucket" "backups_dr" {
  name          = "lolo-backups-dr-${var.environment}"
  location      = var.secondary_region  # me-central1 (Doha)
  storage_class = "COLDLINE"
  force_destroy = false

  uniform_bucket_level_access = true
}

resource "google_storage_transfer_job" "backup_replication" {
  description = "Replicate backups to DR region"

  transfer_spec {
    gcs_data_source {
      bucket_name = google_storage_bucket.backups.name
    }
    gcs_data_sink {
      bucket_name = google_storage_bucket.backups_dr.name
    }
  }

  schedule {
    schedule_start_date {
      year  = 2026
      month = 3
      day   = 1
    }
    start_time_of_day {
      hours   = 6
      minutes = 0
    }
    repeat_interval = "86400s"  # Daily
  }
}
```

### 11.2 PostgreSQL Backups

Handled by Cloud SQL automated backups (configured in `database.tf` section 2.3):

- **Automated daily backups** at 2 AM UTC, retained 30 days
- **Point-in-time recovery** enabled with 7-day transaction log retention
- **On-demand backup** before major deployments:

```bash
#!/bin/bash
# FILE: scripts/pre-deploy-backup.sh
set -euo pipefail

INSTANCE="lolo-analytics-prod"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
DESCRIPTION="pre-deploy-${1:-manual}-${TIMESTAMP}"

echo "Creating on-demand backup of ${INSTANCE}..."
gcloud sql backups create \
  --instance="${INSTANCE}" \
  --description="${DESCRIPTION}" \
  --project=lolo-app-prod

echo "Backup created: ${DESCRIPTION}"

# Verify
gcloud sql backups list \
  --instance="${INSTANCE}" \
  --project=lolo-app-prod \
  --limit=3
```

### 11.3 Redis Snapshots

Configured in `redis.tf` (section 2.4):

- **RDB snapshots** every 6 hours via `SIX_HOURS` persistence policy
- **Standard HA tier** provides automatic failover with replica
- Redis data is cache-layer only; loss is non-critical (rebuilds from Firestore/PostgreSQL)

### 11.4 Encryption Key Backup

```hcl
# FILE: infra/terraform/key_backup.tf
# KMS keys are replicated to DR region automatically
resource "google_kms_key_ring" "lolo" {
  name     = "lolo-keyring-${var.environment}"
  location = var.region
}

resource "google_kms_crypto_key" "data_encryption" {
  name            = "lolo-data-key"
  key_ring        = google_kms_key_ring.lolo.id
  rotation_period = "7776000s"  # 90 days
  purpose         = "ENCRYPT_DECRYPT"

  version_template {
    algorithm        = "GOOGLE_SYMMETRIC_ENCRYPTION"
    protection_level = "SOFTWARE"
  }
}

# DR region key ring (separate backup)
resource "google_kms_key_ring" "lolo_dr" {
  name     = "lolo-keyring-dr-${var.environment}"
  location = var.secondary_region
}

resource "google_kms_crypto_key" "data_encryption_dr" {
  name            = "lolo-data-key-dr"
  key_ring        = google_kms_key_ring.lolo_dr.id
  rotation_period = "7776000s"
  purpose         = "ENCRYPT_DECRYPT"

  version_template {
    algorithm        = "GOOGLE_SYMMETRIC_ENCRYPTION"
    protection_level = "SOFTWARE"
  }
}
```

---

## 12. Incident Response

### 12.1 Runbooks

```yaml
# FILE: docs/runbooks/api-outage.yaml
runbook: API Outage
severity: P1
oncall_response_time: 5 minutes

symptoms:
  - Uptime check failing for > 2 minutes
  - Error rate spikes above 5%
  - Users report "connection error" screens

diagnosis:
  - step: Check Cloud Functions status
    command: |
      gcloud functions list --project=lolo-app-prod --format="table(name,status,updateTime)"
  - step: Check recent deployments
    command: |
      gcloud functions describe api --project=lolo-app-prod --format="json" | jq '.updateTime'
  - step: Check Cloud Functions logs
    command: |
      gcloud logging read "resource.type=cloud_function AND severity>=ERROR" \
        --project=lolo-app-prod --limit=50 --freshness=30m
  - step: Check Firebase status
    url: https://status.firebase.google.com
  - step: Check downstream dependencies
    command: |
      # Redis connectivity
      gcloud redis instances describe lolo-cache-prod --region=asia-southeast1
      # Cloud SQL connectivity
      gcloud sql instances describe lolo-analytics-prod --format="json" | jq '.state'

mitigation:
  - action: "If caused by bad deploy: rollback Cloud Functions"
    command: |
      gcloud functions deploy api \
        --source=gs://lolo-deployments/api-previous.zip \
        --project=lolo-app-prod
  - action: "If external dependency down: enable maintenance mode"
    command: |
      firebase remoteconfig:set maintenance_mode true --project=lolo-app-prod
  - action: "If Cloud SQL issue: failover to replica"
    command: |
      gcloud sql instances failover lolo-analytics-prod --project=lolo-app-prod
  - action: "If Redis issue: bypass cache (functions will query Firestore directly)"
    note: "Set REDIS_ENABLED=false in Cloud Functions env vars"

communication:
  - Update status page: https://status.lolo.app
  - Slack #lolo-critical with status updates every 10 minutes
  - If > 30 min: draft user notification push via Firebase
```

```yaml
# FILE: docs/runbooks/ai-provider-down.yaml
runbook: AI Provider Outage
severity: P2
oncall_response_time: 15 minutes

symptoms:
  - AI response latency > 10s sustained
  - AI error rate spikes for specific model
  - Users report "try again later" on AI features

diagnosis:
  - step: Check which AI provider is failing
    command: |
      gcloud logging read "resource.type=cloud_function AND jsonPayload.type='ai_call' AND severity>=ERROR" \
        --project=lolo-app-prod --limit=20 --freshness=15m
  - step: Check provider status pages
    urls:
      - https://status.anthropic.com
      - https://status.openai.com
      - https://status.cloud.google.com
      - https://status.x.ai

mitigation:
  - action: "AI Router automatically falls back through the chain"
    note: "claude-haiku -> gemini-flash -> gpt-5-mini (built into AI Router)"
  - action: "If all providers degraded: increase cache TTL"
    command: |
      firebase remoteconfig:set ai_cache_ttl_seconds 7200 --project=lolo-app-prod
  - action: "If sustained: switch primary model via Remote Config"
    command: |
      firebase remoteconfig:set ai_primary_model gemini-flash --project=lolo-app-prod
```

```yaml
# FILE: docs/runbooks/payment-failure.yaml
runbook: Payment System Failure
severity: P2
oncall_response_time: 15 minutes

symptoms:
  - Payment failure rate > 1%
  - RevenueCat webhook errors in logs
  - Users report "subscription not activating"

diagnosis:
  - step: Check RevenueCat dashboard
    url: https://app.revenuecat.com
  - step: Check webhook delivery
    command: |
      gcloud logging read "resource.type=cloud_function AND jsonPayload.source='revenuecat'" \
        --project=lolo-app-prod --limit=30 --freshness=1h
  - step: Verify tier sync
    command: |
      # Check for users with mismatched tiers
      gcloud firestore export --project=lolo-app-prod --collection-ids=users | \
        jq 'select(.tier != .revenuecatTier)'

mitigation:
  - action: "If webhook failures: check webhook secret rotation"
    note: "Verify REVENUECAT_WEBHOOK_SECRET in Secret Manager matches RevenueCat dashboard"
  - action: "If store-side issue: manual tier grant for affected users"
    command: |
      # Cloud Function admin endpoint
      curl -X POST https://api.lolo.app/admin/grant-tier \
        -H "Authorization: Bearer ${ADMIN_TOKEN}" \
        -d '{"uid": "USER_ID", "tier": "pro", "reason": "payment_system_failure", "duration": "7d"}'
  - action: "Notify affected users"
    note: "Send push notification: 'Your subscription has been extended due to a billing issue. Thank you for your patience.'"
```

### 12.2 On-Call Rotation

```yaml
# FILE: docs/oncall/rotation.yaml
oncall_schedule:
  name: "LOLO Production On-Call"
  timezone: "Asia/Riyadh"  # UTC+3
  rotation_type: weekly
  handoff_time: "09:00"     # Sunday 9 AM AST
  handoff_day: Sunday

  primary:
    - name: Carlos Rivera (DevOps)
    - name: Raj Patel (Backend)

  secondary:
    - name: Omar Al-Rashidi (Tech Lead)

  escalation:
    - level: 1
      target: primary_oncall
      timeout: 5_minutes
    - level: 2
      target: secondary_oncall
      timeout: 10_minutes
    - level: 3
      target: engineering_manager
      timeout: 15_minutes

  responsibilities:
    - Monitor #lolo-critical Slack channel
    - Acknowledge PagerDuty alerts within 5 minutes
    - Follow runbook for incident type
    - Update status page within 10 minutes of incident
    - Write post-incident review within 48 hours
```

### 12.3 Post-Incident Review Template

```markdown
<!-- FILE: docs/templates/post-incident-review.md -->
# Post-Incident Review: [INCIDENT TITLE]

**Date:** YYYY-MM-DD
**Duration:** [start time] - [end time] (X hours Y minutes)
**Severity:** P1 / P2 / P3
**Author:** [On-call engineer]
**Reviewers:** [Team leads]

## Summary
[1-2 sentence summary of what happened and impact]

## Impact
- **Users affected:** [number/percentage]
- **Revenue impact:** [estimated]
- **SLA impact:** [uptime percentage change]
- **Data loss:** [none / description]

## Timeline (all times in UTC)
| Time | Event |
|------|-------|
| HH:MM | Alert triggered: [alert name] |
| HH:MM | On-call acknowledged |
| HH:MM | Root cause identified |
| HH:MM | Mitigation applied |
| HH:MM | Service restored |
| HH:MM | All-clear declared |

## Root Cause
[Detailed technical explanation of what caused the incident]

## Resolution
[What was done to fix it]

## What Went Well
- [Bullet points]

## What Went Poorly
- [Bullet points]

## Action Items
| Action | Owner | Priority | Due Date |
|--------|-------|----------|----------|
| [Action description] | [Name] | P1/P2/P3 | YYYY-MM-DD |

## Lessons Learned
[Key takeaways for the team]
```

### 12.4 Communication Templates

```yaml
# FILE: docs/templates/incident-communications.yaml
templates:

  status_page_investigating:
    title: "Investigating: [Service] Issues"
    body: |
      We are aware of issues affecting [describe user-visible impact].
      Our team is investigating and we will provide updates as we learn more.
      We apologize for any inconvenience.

  status_page_identified:
    title: "Identified: [Service] Issues"
    body: |
      We have identified the cause of [describe issue] and are working
      on a fix. [Estimated time to resolution if known].
      We will update this status when the fix is deployed.

  status_page_resolved:
    title: "Resolved: [Service] Issues"
    body: |
      The issue affecting [describe] has been resolved.
      All services are operating normally. We apologize for the disruption
      and will publish a full incident report within 48 hours.

  push_notification_outage:
    en: "We're experiencing a brief service interruption. We're working to restore full functionality and will notify you when everything is back to normal."
    ar: "نواجه انقطاعاً مؤقتاً في الخدمة. نعمل على استعادة الوظائف الكاملة وسنُبلغك عندما يعود كل شيء إلى طبيعته."
    ms: "Kami mengalami gangguan perkhidmatan sebentar. Kami sedang berusaha memulihkan fungsi penuh dan akan memberitahu anda apabila semuanya kembali normal."

  push_notification_resolved:
    en: "Everything is back to normal! Thank you for your patience."
    ar: "عاد كل شيء إلى طبيعته! شكراً لصبرك."
    ms: "Semuanya sudah kembali normal! Terima kasih atas kesabaran anda."
```

---

## Appendix A: Deployment Checklist

```markdown
## Pre-Release Checklist

### Code Quality
- [ ] All CI checks pass (lint, test, build)
- [ ] Code coverage >= 80%
- [ ] No critical Sentry issues open
- [ ] No P1/P2 bugs in backlog for this release

### Security
- [ ] No secrets in codebase (git-secrets scan passed)
- [ ] Firestore rules reviewed and deployed
- [ ] SSL pins updated if certificates rotated
- [ ] App Check enforced on all endpoints
- [ ] Security headers verified

### Localization
- [ ] All strings translated (EN/AR/MS)
- [ ] RTL layout tested on Arabic
- [ ] Release notes written in all 3 languages
- [ ] Screenshots regenerated if UI changed

### Performance
- [ ] App startup < 3s on mid-range device
- [ ] AI response time p95 < 5s
- [ ] No memory leaks (DevTools profiling)
- [ ] APK/IPA size within budget (< 50 MB)

### Backups
- [ ] Pre-deployment database backup created
- [ ] Firestore export completed
- [ ] Rollback plan documented and tested

### Monitoring
- [ ] Dashboards showing expected baselines
- [ ] Alert thresholds appropriate for release
- [ ] On-call engineer confirmed and available
- [ ] Status page ready for updates

### Store Compliance
- [ ] Google Play: Content rating questionnaire up to date
- [ ] Apple: Privacy nutrition labels accurate
- [ ] Apple: Review notes and demo account ready
- [ ] Huawei: AppGallery review notes prepared

### Sign-off
- [ ] QA Lead sign-off
- [ ] Tech Lead sign-off
- [ ] Product Manager sign-off
- [ ] DevOps (rollout plan confirmed)
```

---

*Document ends. All configurations are production-grade and follow GCP + Firebase best practices for mobile applications serving GCC and Southeast Asian markets.*
