# LOLO -- Deployment Runbook & Rollback Procedures

**Document ID:** LOLO-DEVOPS-RUNBOOK-P5
**Author:** Carlos Rivera, DevOps Engineer
**Date:** 2026-02-15
**Version:** 1.0
**Status:** Phase 5 Launch Deliverable
**Classification:** Internal -- Confidential
**Dependencies:** CI/CD Pipeline (S1-DEVOPS), Production Hardening (P4-DEVOPS), Firebase Schema (S1-03A), Architecture Document v1.0

---

## Table of Contents

1. [Pre-Deployment Checklist](#part-1-pre-deployment-checklist)
2. [Deployment Procedure](#part-2-deployment-procedure)
3. [Rollback Procedures](#part-3-rollback-procedures)
4. [Post-Deployment Monitoring](#part-4-post-deployment-monitoring)

---

## PART 1: PRE-DEPLOYMENT CHECKLIST

### 1.1 Infrastructure Verification

> **Owner:** Carlos Rivera (DevOps)
> **Estimated Time:** 45 minutes
> **Must complete before:** T-4 hours from deployment window

#### 1.1.1 Firebase Production Project Status

```bash
# Set project to production
firebase use prod  # alias for lolo-app-prod

# Verify active project
firebase projects:list
```

- [ ] Firebase project `lolo-app-prod` is active and billing enabled
- [ ] Blaze plan confirmed (pay-as-you-go)
- [ ] Budget alerts configured at $500/day, $1,000/day, $2,000/day thresholds
- [ ] Firebase Auth providers enabled: Email, Google, Apple, Phone
- [ ] App Check enforcement active for all services
- [ ] Firebase Performance Monitoring collection enabled

```bash
# Verify App Check status
gcloud firebase appcheck services list --project=lolo-app-prod

# Verify Auth providers
firebase auth:export /dev/null --project=lolo-app-prod 2>&1 | head -5
```

#### 1.1.2 Cloud SQL Health and Replication

```bash
# Check Cloud SQL instance status
gcloud sql instances describe lolo-postgres-prod \
  --project=lolo-app-prod \
  --format="table(name,state,databaseVersion,region,settings.tier)"

# Verify replication status (read replica)
gcloud sql instances describe lolo-postgres-prod-replica \
  --project=lolo-app-prod \
  --format="table(name,state,replicaConfiguration.failoverTarget)"

# Check disk usage (alert if >70%)
gcloud sql instances describe lolo-postgres-prod \
  --format="value(settings.dataDiskSizeGb)"

# Verify automated backups are running
gcloud sql backups list --instance=lolo-postgres-prod \
  --project=lolo-app-prod --limit=5
```

- [ ] Primary instance state: `RUNNABLE`
- [ ] Read replica state: `RUNNABLE`, replication lag < 1 second
- [ ] Disk usage below 70% capacity
- [ ] Automated backups running successfully (last 5 verified)
- [ ] Point-in-time recovery enabled
- [ ] SSL enforcement active (`requireSsl: true`)

#### 1.1.3 Redis Cluster Health

```bash
# Check Memorystore Redis instance
gcloud redis instances describe lolo-redis-prod \
  --region=asia-southeast1 \
  --project=lolo-app-prod \
  --format="table(name,state,memorySizeGb,redisVersion,tier)"

# Verify connectivity from VPC
gcloud redis instances describe lolo-redis-prod \
  --region=asia-southeast1 \
  --format="value(host,port)"
```

- [ ] Redis instance state: `READY`
- [ ] Memory usage below 80% (`used_memory` vs `maxmemory`)
- [ ] Redis version: 7.x
- [ ] High availability tier: `STANDARD_HA`
- [ ] VPC connectivity confirmed from Cloud Functions subnet
- [ ] Persistence (RDB snapshots) enabled

#### 1.1.4 Cloud Functions Deployment Verification

```bash
# List all deployed functions and their status
gcloud functions list --project=lolo-app-prod \
  --format="table(name,status,runtime,httpsTrigger.url)" \
  --gen2

# Verify minimum instances for critical functions
gcloud functions describe api --project=lolo-app-prod --gen2 \
  --region=asia-southeast1 \
  --format="value(serviceConfig.minInstanceCount,serviceConfig.maxInstanceCount)"

gcloud functions describe aiRouter --project=lolo-app-prod --gen2 \
  --region=asia-southeast1 \
  --format="value(serviceConfig.minInstanceCount,serviceConfig.maxInstanceCount)"

gcloud functions describe sosHandler --project=lolo-app-prod --gen2 \
  --region=asia-southeast1 \
  --format="value(serviceConfig.minInstanceCount,serviceConfig.maxInstanceCount)"
```

- [ ] `api` function: ACTIVE, minInstances=3, maxInstances=200
- [ ] `aiRouter` function: ACTIVE, minInstances=3, maxInstances=100
- [ ] `sosHandler` function: ACTIVE, minInstances=2, maxInstances=50
- [ ] `batchJobs` function: ACTIVE, minInstances=0, maxInstances=10
- [ ] `webhooks` function: ACTIVE, minInstances=1, maxInstances=50
- [ ] `notifications` function: ACTIVE, minInstances=0, maxInstances=30
- [ ] All functions on Node.js 20 runtime
- [ ] All functions deployed to `asia-southeast1`

#### 1.1.5 SSL Certificate Validity

```bash
# Check managed SSL certificates
gcloud compute ssl-certificates list --project=lolo-app-prod \
  --format="table(name,type,managed.status,managed.domains,expireTime)"

# Verify certificate expiration (must be > 30 days out)
gcloud compute ssl-certificates describe lolo-ssl-prod \
  --project=lolo-app-prod \
  --format="value(expireTime)"

# Verify custom domain SSL for Firebase Hosting
firebase hosting:channel:list --project=lolo-app-prod
```

- [ ] SSL certificate status: `ACTIVE`
- [ ] Certificate covers: `api.lolo.app`, `admin.lolo.app`, `*.lolo.app`
- [ ] Expiration date > 30 days from deployment
- [ ] TLS 1.3 enforced (TLS 1.0/1.1 disabled)
- [ ] HSTS headers configured with `max-age=31536000`
- [ ] Firebase Hosting custom domain SSL valid

#### 1.1.6 Secret Manager Keys Rotation

```bash
# List all secrets and their versions
gcloud secrets list --project=lolo-app-prod \
  --format="table(name,replication.automatic)"

# Verify each secret has recent version (rotated within 90 days)
for secret in ANTHROPIC_API_KEY OPENAI_API_KEY GEMINI_API_KEY \
  XAI_API_KEY REVENUECAT_API_KEY STRIPE_WEBHOOK_SECRET \
  PINECONE_API_KEY REDIS_AUTH_TOKEN POSTGRES_PASSWORD; do
  echo "--- $secret ---"
  gcloud secrets versions list $secret --project=lolo-app-prod \
    --limit=1 --format="value(createTime,state)"
done
```

- [ ] `ANTHROPIC_API_KEY` -- rotated, state: ENABLED
- [ ] `OPENAI_API_KEY` -- rotated, state: ENABLED
- [ ] `GEMINI_API_KEY` -- rotated, state: ENABLED
- [ ] `XAI_API_KEY` -- rotated, state: ENABLED
- [ ] `REVENUECAT_API_KEY` -- rotated, state: ENABLED
- [ ] `STRIPE_WEBHOOK_SECRET` -- rotated, state: ENABLED
- [ ] `PINECONE_API_KEY` -- rotated, state: ENABLED
- [ ] `REDIS_AUTH_TOKEN` -- rotated, state: ENABLED
- [ ] `POSTGRES_PASSWORD` -- rotated, state: ENABLED
- [ ] All secrets rotated within last 90 days
- [ ] Previous secret versions disabled (not destroyed -- keep for rollback)

#### 1.1.7 Cloud Armor Rules Active

```bash
# Verify Cloud Armor security policy
gcloud compute security-policies describe lolo-waf-policy \
  --project=lolo-app-prod \
  --format="table(name,rules.action,rules.priority,rules.description)"

# List all rules
gcloud compute security-policies rules list lolo-waf-policy \
  --project=lolo-app-prod
```

- [ ] Rate limiting rule active: 60 req/min per IP
- [ ] SQL injection protection rule active
- [ ] XSS protection rule active
- [ ] Geo-blocking rules configured (if applicable)
- [ ] Bot detection rules enabled
- [ ] DDoS protection at default tier active
- [ ] Policy attached to backend services

#### 1.1.8 CDN Cache Warmed

```bash
# Verify CDN is configured on Cloud Storage buckets
gcloud compute backend-buckets describe lolo-static-assets \
  --project=lolo-app-prod \
  --format="value(enableCdn,cdnPolicy.cacheMode)"

# Warm critical asset caches
curl -s -o /dev/null -w "%{http_code}" https://cdn.lolo.app/assets/zodiac-icons/aries.webp
curl -s -o /dev/null -w "%{http_code}" https://cdn.lolo.app/assets/onboarding/slide1.webp
curl -s -o /dev/null -w "%{http_code}" https://cdn.lolo.app/assets/lottie/loading.json

# Verify cache hit rate
gcloud logging read \
  'resource.type="http_load_balancer" AND httpRequest.cacheHit=true' \
  --project=lolo-app-prod --limit=10 --freshness=1h
```

- [ ] CDN enabled on static asset backend bucket
- [ ] Cache mode: `CACHE_ALL_STATIC`
- [ ] Zodiac icons (12 signs, 3 sizes each) cached
- [ ] Onboarding assets cached
- [ ] Lottie animation files cached
- [ ] Cache-Control headers set: `public, max-age=86400` for static assets
- [ ] Cache hit rate > 80% on warmed assets

---

### 1.2 Application Verification

> **Owner:** Omar Al-Rashidi (Tech Lead) + Carlos Rivera (DevOps)
> **Estimated Time:** 60 minutes
> **Must complete before:** T-3 hours from deployment window

#### 1.2.1 Flutter Release Build

```bash
# Android release build (AAB for Play Store)
flutter build appbundle --release \
  --dart-define=FLAVOR=production \
  --dart-define=FIREBASE_PROJECT=lolo-app-prod \
  --obfuscate \
  --split-debug-info=build/debug-info/android \
  --target-platform android-arm,android-arm64,android-x64

# Verify AAB was created
ls -la build/app/outputs/bundle/release/app-release.aab

# iOS release build (IPA for App Store)
flutter build ipa --release \
  --dart-define=FLAVOR=production \
  --dart-define=FIREBASE_PROJECT=lolo-app-prod \
  --obfuscate \
  --split-debug-info=build/debug-info/ios \
  --export-options-plist=ios/ExportOptions.plist

# Verify IPA was created
ls -la build/ios/ipa/LOLO.ipa
```

- [ ] Android AAB builds without errors (exit code 0)
- [ ] iOS IPA builds without errors (exit code 0)
- [ ] Debug symbols uploaded to Crashlytics
- [ ] Obfuscation mapping file archived for both platforms
- [ ] Both builds use production Firebase config (`GoogleService-Info.plist` / `google-services.json`)

#### 1.2.2 Test Suite Passing

```bash
# Run full test suite
flutter test --coverage --reporter=expanded

# Unit tests
flutter test test/unit/ --reporter=expanded

# Widget tests
flutter test test/widget/ --reporter=expanded

# Integration tests (requires emulator/device)
flutter test integration_test/ --reporter=expanded

# Golden tests
flutter test test/golden/ --update-goldens  # Only if intentional visual changes
flutter test test/golden/                   # Verify goldens match
```

- [ ] Unit tests: all passing (target: 200+ tests)
- [ ] Widget tests: all passing (target: 80+ tests)
- [ ] Integration tests: all passing (target: 30+ tests)
- [ ] Golden tests: all passing, no unintended visual diffs
- [ ] Code coverage >= 70% overall
- [ ] Zero test failures on CI (GitHub Actions + Codemagic)

#### 1.2.3 Lint and Static Analysis

```bash
# Flutter analyze
flutter analyze --no-pub

# Custom lint rules (from analysis_options.yaml)
dart analyze --fatal-infos

# Check for any TODO/FIXME in production code
grep -rn "TODO\|FIXME\|HACK\|XXX" lib/ --include="*.dart" | head -20
```

- [ ] `flutter analyze`: zero errors, zero warnings
- [ ] `dart analyze`: zero fatal infos
- [ ] No critical TODO/FIXME items remaining in `lib/`
- [ ] No `print()` statements in production code (use logger instead)
- [ ] No hardcoded API keys or secrets in source

#### 1.2.4 ProGuard / R8 Rules Verified (Android)

```bash
# Verify ProGuard rules file exists and is configured
cat android/app/proguard-rules.pro

# Test release build with R8 (already done in AAB build, verify no crashes)
# Check for missing class warnings
cat build/app/outputs/mapping/release/missing_rules.txt 2>/dev/null || echo "No missing rules"
```

- [ ] `proguard-rules.pro` includes Firebase keep rules
- [ ] RevenueCat classes preserved
- [ ] Dio/Retrofit model classes preserved
- [ ] No `ClassNotFoundException` in release build smoke test
- [ ] R8 mapping file saved: `build/app/outputs/mapping/release/mapping.txt`
- [ ] Mapping file uploaded to Play Console for deobfuscation

#### 1.2.5 Bitcode Configuration (iOS)

- [ ] Bitcode setting verified in Xcode project (Note: Bitcode deprecated in Xcode 14+; confirm `ENABLE_BITCODE=NO`)
- [ ] All CocoaPods dependencies compatible with deployment target (iOS 15.0+)
- [ ] `Podfile.lock` committed and up to date
- [ ] Archive builds successfully in Xcode
- [ ] No unsupported architecture warnings

#### 1.2.6 App Size Verification

```bash
# Android: Check AAB size
ls -la build/app/outputs/bundle/release/app-release.aab
# Target: AAB < 30MB (download size < 50MB after expansion)

# Use bundletool to estimate download size
java -jar bundletool.jar get-size total \
  --apks=build/app/outputs/bundle/release/app-release.apks

# iOS: Check IPA size
ls -la build/ios/ipa/LOLO.ipa
# Target: IPA < 60MB (App Store < 50MB download after thinning)

# Analyze app size breakdown
flutter build appbundle --analyze-size --target-platform android-arm64
flutter build ipa --analyze-size
```

- [ ] Android AAB: < 30 MB (estimated download < 50 MB)
- [ ] iOS IPA: < 60 MB (estimated App Store download < 50 MB after thinning)
- [ ] No oversized assets (images > 500 KB flagged)
- [ ] Lottie files optimized (< 100 KB each)
- [ ] Unused assets removed

#### 1.2.7 Analytics Events Verification

```bash
# Enable Firebase Analytics debug mode for verification
adb shell setprop debug.firebase.analytics.app com.lolo.app  # Android
# iOS: Add -FIRDebugEnabled launch argument in scheme

# Verify events in Firebase DebugView console
# https://console.firebase.google.com/project/lolo-app-prod/analytics/debugview
```

- [ ] `sign_up` event fires with `method` parameter
- [ ] `login` event fires with `method` parameter
- [ ] `partner_added` event fires with `zodiac_sign` parameter
- [ ] `ai_message_sent` event fires with `model`, `category` parameters
- [ ] `sos_activated` event fires with `situation_type` parameter
- [ ] `gift_recommended` event fires with `occasion`, `budget` parameters
- [ ] `subscription_started` event fires with `plan`, `price` parameters
- [ ] `action_card_completed` event fires with `card_type` parameter
- [ ] `memory_created` event fires with `type` parameter
- [ ] All 3 locales (en, ar, ms) tested for event correctness

---

### 1.3 Store Readiness

> **Owner:** Marketing Lead + Carlos Rivera (DevOps)
> **Estimated Time:** 30 minutes (verification only)
> **Must complete before:** T-2 hours from deployment window

#### 1.3.1 Google Play Console

```bash
# Upload AAB to internal testing track via fastlane
cd android
fastlane supply --aab ../build/app/outputs/bundle/release/app-release.aab \
  --track internal \
  --package_name com.lolo.app \
  --json_key play-store-credentials.json

# Verify upload
fastlane supply init --package_name com.lolo.app --json_key play-store-credentials.json
```

- [ ] App listing complete (title, short description, full description)
- [ ] All 3 languages verified: English (en-US), Arabic (ar), Malay (ms-MY)
- [ ] Screenshots uploaded: Phone (6 screenshots min), Tablet (optional), Wear OS (n/a)
- [ ] Feature graphic (1024x500) uploaded
- [ ] Hi-res icon (512x512) uploaded
- [ ] Content rating questionnaire submitted (IARC)
- [ ] Privacy policy URL set: `https://lolo.app/privacy`
- [ ] Data safety section complete
- [ ] Target API level: 34 (Android 14)
- [ ] App signing by Google Play configured (upload key enrolled)
- [ ] Pre-launch report reviewed (no critical issues)
- [ ] Testers list for internal/closed tracks populated

#### 1.3.2 App Store Connect

```bash
# Upload IPA via fastlane
cd ios
fastlane deliver --ipa ../build/ios/ipa/LOLO.ipa \
  --app_identifier com.lolo.app \
  --skip_screenshots false \
  --submit_for_review false

# Or via Transporter
xcrun altool --upload-app -f ../build/ios/ipa/LOLO.ipa \
  -t ios \
  --apiKey $APP_STORE_API_KEY \
  --apiIssuer $APP_STORE_ISSUER_ID
```

- [ ] App metadata complete for all 3 locales (en, ar, ms)
- [ ] Screenshots uploaded: iPhone 6.7", 6.5", 5.5" (required sizes)
- [ ] iPad screenshots uploaded (if Universal app)
- [ ] App Preview video uploaded (optional but recommended)
- [ ] Privacy policy URL set
- [ ] App Review information provided (demo account credentials)
- [ ] Age rating set (likely 4+ or 12+ depending on content)
- [ ] In-app purchase products configured and approved
- [ ] App Category: Lifestyle (primary), Social Networking (secondary)
- [ ] Phased release option selected
- [ ] Encryption compliance (HTTPS-only = standard exemption applies)

#### 1.3.3 Huawei AppGallery

```bash
# Build APK for Huawei (HMS variant)
flutter build apk --release \
  --dart-define=FLAVOR=huawei \
  --dart-define=FIREBASE_PROJECT=lolo-app-prod \
  --dart-define=HMS_ENABLED=true \
  --obfuscate \
  --split-debug-info=build/debug-info/huawei

# Upload via AppGallery Connect API
curl -X POST "https://connect-api.cloud.huawei.com/api/publish/v2/upload-url" \
  -H "Authorization: Bearer $HUAWEI_TOKEN" \
  -H "client_id: $HUAWEI_CLIENT_ID"
```

- [ ] Huawei AppGallery listing complete (3 languages)
- [ ] HMS Core integration verified (push notifications via HMS)
- [ ] APK signed with Huawei keystore
- [ ] Screenshots and app icon uploaded
- [ ] Privacy policy and data processing disclosure
- [ ] Content rating submitted
- [ ] Huawei IAP products configured (mirrors RevenueCat products)

#### 1.3.4 Language Variants Cross-Check

- [ ] English (en): All store listings proofread, screenshots show English UI
- [ ] Arabic (ar): RTL layout verified in screenshots, Arabic descriptions reviewed by native speaker
- [ ] Malay (ms): Bahasa Malaysia descriptions reviewed, screenshots show Malay UI
- [ ] App name consistent across all stores and languages: "LOLO"

---

## PART 2: DEPLOYMENT PROCEDURE

### 2.1 Deployment Window

| Parameter | Value |
|---|---|
| **Primary window** | Tuesday 02:00-06:00 UTC (10:00-14:00 SGT) |
| **Fallback window** | Wednesday 02:00-06:00 UTC |
| **Freeze period** | None (initial launch) |
| **War room** | Slack `#lolo-deployment` + Google Meet bridge |
| **Decision maker** | Carlos Rivera (DevOps) + Omar Al-Rashidi (Tech Lead) |

### 2.2 Backend Deployment

> **Owner:** Carlos Rivera (DevOps) + Raj Patel (Backend)
> **Estimated Time:** 2-3 hours including monitoring dwell times
> **Rollback authority:** Carlos Rivera

#### Step 1: Deploy Cloud Functions to Staging

```bash
# Tag the release
git tag -a v1.0.0 -m "LOLO v1.0.0 production release"
git push origin v1.0.0

# Switch to staging environment
firebase use staging  # lolo-app-staging

# Deploy all functions to staging
firebase deploy --only functions --project=lolo-app-staging

# Verify deployment
gcloud functions list --project=lolo-app-staging --gen2 \
  --format="table(name,status,updateTime)"
```

**Staging Smoke Tests:**

```bash
# Run automated smoke tests against staging
cd functions
npm run test:smoke -- --env=staging

# Manual verification endpoints
STAGING_URL="https://asia-southeast1-lolo-app-staging.cloudfunctions.net"

# Health check
curl -s "$STAGING_URL/api/health" | jq '.status'
# Expected: "ok"

# Auth flow test (with test token)
curl -s "$STAGING_URL/api/v1/user/profile" \
  -H "Authorization: Bearer $STAGING_TEST_TOKEN" | jq '.uid'

# AI router test
curl -s -X POST "$STAGING_URL/api/v1/ai/message" \
  -H "Authorization: Bearer $STAGING_TEST_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"prompt":"test greeting","category":"general","locale":"en"}' | jq '.status'
```

- [ ] All functions deployed to staging successfully
- [ ] Health endpoint returns `{"status":"ok"}`
- [ ] Auth flow works with test token
- [ ] AI router responds within 5 seconds
- [ ] Webhook endpoint accessible
- [ ] All smoke tests pass

**GATE:** All staging smoke tests must pass before proceeding.

#### Step 2: Firestore Index Verification

```bash
# Deploy indexes to production
firebase deploy --only firestore:indexes --project=lolo-app-prod

# Check index build status
firebase firestore:indexes --project=lolo-app-prod

# Verify all 16 composite indexes are READY
gcloud firestore indexes composite list --project=lolo-app-prod \
  --format="table(name,state,fields)" 2>/dev/null || \
  firebase firestore:indexes --project=lolo-app-prod
```

**Required Indexes (all must show state: READY):**

| # | Collection | Fields | Status |
|---|---|---|---|
| 1 | `users` | `locale ASC, createdAt DESC` | [ ] READY |
| 2 | `users/{uid}/memories` | `type ASC, createdAt DESC` | [ ] READY |
| 3 | `users/{uid}/memories` | `partnerZodiac ASC, createdAt DESC` | [ ] READY |
| 4 | `users/{uid}/conversations` | `category ASC, createdAt DESC` | [ ] READY |
| 5 | `reminders` | `uid ASC, scheduledAt ASC, status ASC` | [ ] READY |
| 6 | `reminders` | `uid ASC, type ASC, status ASC` | [ ] READY |
| 7 | `actionCards` | `category ASC, difficulty ASC, active ASC` | [ ] READY |
| 8 | `actionCards` | `zodiacSign ASC, category ASC` | [ ] READY |
| 9 | `leaderboard` | `period ASC, score DESC` | [ ] READY |
| 10 | `leaderboard` | `uid ASC, period ASC` | [ ] READY |
| 11 | `analytics` | `eventType ASC, timestamp DESC` | [ ] READY |
| 12 | `analytics` | `uid ASC, eventType ASC, timestamp DESC` | [ ] READY |
| 13 | `subscriptions` | `uid ASC, status ASC` | [ ] READY |
| 14 | `subscriptions` | `provider ASC, status ASC, expiresAt ASC` | [ ] READY |
| 15 | `gifts` | `uid ASC, occasion ASC, createdAt DESC` | [ ] READY |
| 16 | `gifts` | `zodiacSign ASC, budget ASC` | [ ] READY |

**GATE:** All 16 indexes must be in READY state. Index creation can take 10-30 minutes. Do NOT proceed until all are ready.

#### Step 3: Deploy Security Rules

```bash
# Deploy Firestore rules
firebase deploy --only firestore:rules --project=lolo-app-prod

# Deploy Storage rules
firebase deploy --only storage --project=lolo-app-prod

# Verify rules are active
firebase firestore:rules:list --project=lolo-app-prod
```

- [ ] Firestore rules deployed (using `firestore.prod.rules`)
- [ ] Storage rules deployed (using `storage.prod.rules`)
- [ ] Rules verification: test read as unauthenticated user (should DENY)
- [ ] Rules verification: test write to admin-only collection (should DENY)

#### Step 4: Verify Scheduled Functions

```bash
# List Cloud Scheduler jobs
gcloud scheduler jobs list --project=lolo-app-prod \
  --location=asia-southeast1 \
  --format="table(name,schedule,state,lastAttemptTime,status.latestExecution)"
```

- [ ] `daily-reminder-check` -- Schedule: `0 8 * * *` (8 AM daily), State: ENABLED
- [ ] `weekly-relationship-digest` -- Schedule: `0 9 * * 0` (Sunday 9 AM), State: ENABLED
- [ ] `daily-ai-cost-report` -- Schedule: `0 0 * * *` (midnight), State: ENABLED
- [ ] `hourly-cache-cleanup` -- Schedule: `0 * * * *` (hourly), State: ENABLED
- [ ] `monthly-subscription-sync` -- Schedule: `0 2 1 * *` (1st of month), State: ENABLED
- [ ] All jobs timezone set to UTC

#### Step 5: Production Deployment with Traffic Splitting

**Phase 5a: 10% Traffic (30 minutes dwell)**

```bash
# Deploy functions to production
firebase use prod
firebase deploy --only functions --project=lolo-app-prod

# Set traffic split: 10% new, 90% previous
gcloud functions deploy api --project=lolo-app-prod --gen2 \
  --region=asia-southeast1 \
  --update-traffic-config='{"splits":[{"revisionName":"api-v1-0-0","percent":10},{"revisionName":"api-previous","percent":90}]}'

gcloud functions deploy aiRouter --project=lolo-app-prod --gen2 \
  --region=asia-southeast1 \
  --update-traffic-config='{"splits":[{"revisionName":"aiRouter-v1-0-0","percent":10},{"revisionName":"aiRouter-previous","percent":90}]}'
```

```bash
# Monitor error rate for 30 minutes
watch -n 30 'gcloud logging read \
  "resource.type=\"cloud_function\" AND severity>=ERROR AND timestamp>=\"$(date -u -d '\''-30 minutes'\'' +%Y-%m-%dT%H:%M:%SZ)\"" \
  --project=lolo-app-prod --limit=10 --format="table(timestamp,textPayload)"'
```

- [ ] Error rate at 10% traffic: < 2%
- [ ] p95 latency at 10% traffic: < 5 seconds
- [ ] No 5xx errors from new revision
- [ ] AI router responding correctly

**DECISION POINT:**
- Error rate < 2% AND p95 < 5s --> Proceed to 50%
- Error rate 2-5% OR p95 5-10s --> Investigate, hold at 10% for 30 more minutes
- Error rate > 5% OR p95 > 10s --> **ROLLBACK** (see Part 3)

**Phase 5b: 50% Traffic (30 minutes dwell)**

```bash
# Increase to 50%
gcloud functions deploy api --project=lolo-app-prod --gen2 \
  --region=asia-southeast1 \
  --update-traffic-config='{"splits":[{"revisionName":"api-v1-0-0","percent":50},{"revisionName":"api-previous","percent":50}]}'

gcloud functions deploy aiRouter --project=lolo-app-prod --gen2 \
  --region=asia-southeast1 \
  --update-traffic-config='{"splits":[{"revisionName":"aiRouter-v1-0-0","percent":50},{"revisionName":"aiRouter-previous","percent":50}]}'
```

- [ ] Error rate at 50% traffic: < 2%
- [ ] p95 latency at 50% traffic: < 5 seconds
- [ ] Memory usage within limits
- [ ] No cold start spikes beyond baseline

**Phase 5c: 100% Traffic**

```bash
# Full rollout
gcloud functions deploy api --project=lolo-app-prod --gen2 \
  --region=asia-southeast1 \
  --update-traffic-config='{"splits":[{"revisionName":"api-v1-0-0","percent":100}]}'

gcloud functions deploy aiRouter --project=lolo-app-prod --gen2 \
  --region=asia-southeast1 \
  --update-traffic-config='{"splits":[{"revisionName":"aiRouter-v1-0-0","percent":100}]}'

# Repeat for all functions
for fn in sosHandler batchJobs webhooks notifications; do
  gcloud functions deploy $fn --project=lolo-app-prod --gen2 \
    --region=asia-southeast1 \
    --update-traffic-config="{\"splits\":[{\"revisionName\":\"${fn}-v1-0-0\",\"percent\":100}]}"
done
```

- [ ] All functions at 100% traffic on new revision
- [ ] Error rate stable < 1%
- [ ] p95 latency stable < 3 seconds
- [ ] Monitoring dashboards green

#### Step 6: Post-Backend-Deploy Verification

```bash
# Production health check
PROD_URL="https://asia-southeast1-lolo-app-prod.cloudfunctions.net"

curl -s "$PROD_URL/api/health" | jq '.'

# Verify all API endpoints respond
curl -s -o /dev/null -w "%{http_code}" "$PROD_URL/api/v1/status"
# Expected: 200

# Verify Remote Config is serving
firebase remoteconfig:get --project=lolo-app-prod | jq '.parameters.maintenance_mode'
# Expected: {"defaultValue":{"value":"false"}}
```

- [ ] Health endpoint: 200 OK
- [ ] API status endpoint: 200 OK
- [ ] Remote Config serving correct values
- [ ] Maintenance mode: OFF
- [ ] All feature flags at expected values

---

### 2.3 Mobile App Deployment

> **Owner:** Carlos Rivera (DevOps) + Omar Al-Rashidi (Tech Lead)
> **Estimated Time:** Variable (store review times)

#### 2.3.1 Android Deployment Pipeline

**Phase A: Internal Testing**

```bash
# Upload to internal testing track
cd android
fastlane android internal

# Or via command line
fastlane supply --aab ../build/app/outputs/bundle/release/app-release.aab \
  --track internal \
  --package_name com.lolo.app \
  --json_key play-store-credentials.json \
  --release_status draft
```

- [ ] APK available on internal testing track
- [ ] Internal team (5 people) installs and verifies core flows
- [ ] Verify: onboarding, partner setup, AI messaging, SOS mode
- [ ] Verify: payment flow (sandbox), push notifications
- [ ] Verify: all 3 languages switch correctly
- [ ] Minimum dwell time: 4 hours

**Phase B: Closed Beta (50 testers)**

```bash
# Promote to closed beta
fastlane supply --aab ../build/app/outputs/bundle/release/app-release.aab \
  --track beta \
  --package_name com.lolo.app \
  --json_key play-store-credentials.json \
  --rollout 1.0
```

- [ ] 50 beta testers invited via Play Console email list
- [ ] Testers represent all 3 locale groups (en, ar, ms)
- [ ] Feedback collection form active (Google Forms link in beta listing)
- [ ] Minimum dwell time: 48 hours
- [ ] Crash-free rate threshold: > 99%
- [ ] ANR rate threshold: < 0.5%

**Phase C: Production Staged Rollout**

```bash
# Stage 1: 1% rollout
fastlane supply --aab ../build/app/outputs/bundle/release/app-release.aab \
  --track production \
  --package_name com.lolo.app \
  --json_key play-store-credentials.json \
  --rollout 0.01

# Monitor for 24 hours, then increase
# Stage 2: 5% rollout
fastlane supply --track production \
  --package_name com.lolo.app \
  --json_key play-store-credentials.json \
  --rollout 0.05

# Stage 3: 25% rollout
fastlane supply --track production \
  --package_name com.lolo.app \
  --json_key play-store-credentials.json \
  --rollout 0.25

# Stage 4: 100% rollout
fastlane supply --track production \
  --package_name com.lolo.app \
  --json_key play-store-credentials.json \
  --rollout 1.0
```

| Stage | % | Duration | Go Criteria | Halt Criteria |
|---|---|---|---|---|
| 1% | 0.01 | 24 hours | Crash-free > 99.5%, no critical bugs | Crash-free < 99%, critical bug |
| 5% | 0.05 | 24 hours | Crash-free > 99.5%, no regressions | Crash-free < 99%, regression |
| 25% | 0.25 | 48 hours | Crash-free > 99.5%, ratings > 3.5 | Crash-free < 99%, ratings < 3.0 |
| 100% | 1.0 | -- | Stable at 25% for 48 hours | Any P0 bug |

#### 2.3.2 iOS Deployment Pipeline

**Phase A: TestFlight Internal**

```bash
# Upload to TestFlight
cd ios
fastlane ios beta

# Or via Xcode/Transporter
xcrun altool --upload-app -f ../build/ios/ipa/LOLO.ipa \
  -t ios \
  --apiKey $APP_STORE_API_KEY \
  --apiIssuer $APP_STORE_ISSUER_ID
```

- [ ] Build uploaded to App Store Connect
- [ ] Build processing complete (usually 15-30 minutes)
- [ ] Internal testers (25 max) automatically notified
- [ ] Core flows verified on iPhone and iPad
- [ ] Minimum dwell time: 4 hours

**Phase B: TestFlight External (100 testers)**

- [ ] External testing group created: "LOLO Beta Testers"
- [ ] Beta App Review submitted (usually 24-48 hours)
- [ ] Review approved, 100 external testers invited
- [ ] Feedback collected via TestFlight native feedback
- [ ] Minimum dwell time: 72 hours
- [ ] Crash-free rate > 99.5%

**Phase C: App Store Submission**

```bash
# Submit for App Review
cd ios
fastlane deliver --submit_for_review true \
  --automatic_release false \
  --phased_release true \
  --app_identifier com.lolo.app
```

- [ ] App submitted for review
- [ ] Review approved (typical: 24-48 hours)
- [ ] Phased release enabled

**Phase D: App Store Phased Release**

| Day | % of Users | Cumulative |
|---|---|---|
| Day 1 | 1% | 1% |
| Day 2 | 2% | 3% |
| Day 3 | 5% | 8% |
| Day 4 | 10% | 18% |
| Day 5 | 20% | 38% |
| Day 6 | 50% | 88% |
| Day 7 | 100% | 100% |

```bash
# Monitor via App Store Connect API
# Pause phased release if issues detected
fastlane deliver --phased_release_state PAUSE
# Resume phased release
fastlane deliver --phased_release_state RESUME
# Immediately release to all users
fastlane deliver --phased_release_state COMPLETE
```

- [ ] Daily monitoring of crash reports during each phase
- [ ] Pause trigger: crash-free rate < 99% or critical bug reported
- [ ] Resume only after fix verified

#### 2.3.3 Huawei AppGallery Deployment

```bash
# Build Huawei variant APK
flutter build apk --release \
  --dart-define=FLAVOR=huawei \
  --dart-define=HMS_ENABLED=true \
  --target-platform android-arm64

# Upload via AppGallery Connect CLI
java -jar AppGalleryConnectCLI.jar upload \
  --appId $HUAWEI_APP_ID \
  --filePath build/app/outputs/flutter-apk/app-release.apk \
  --token $HUAWEI_CONNECT_TOKEN
```

- [ ] APK uploaded to AppGallery Connect
- [ ] Internal testing verified (HMS Push, Huawei IAP)
- [ ] Submitted for review (typical: 3-5 business days)
- [ ] Review approved, published
- [ ] HMS Core services verified post-publish

#### 2.3.4 Monitoring at Each Stage

```bash
# Android crash monitoring
# Firebase Console > Crashlytics > Android
# Key metrics dashboard URL:
# https://console.firebase.google.com/project/lolo-app-prod/crashlytics

# iOS crash monitoring
# Firebase Console > Crashlytics > iOS
# App Store Connect > App Analytics

# Aggregate monitoring script
#!/bin/bash
echo "=== LOLO Deployment Health Check ==="
echo "Timestamp: $(date -u +%Y-%m-%dT%H:%M:%SZ)"

# Check Cloud Functions error rate
gcloud logging read \
  'resource.type="cloud_function" AND severity>=ERROR' \
  --project=lolo-app-prod \
  --freshness=1h \
  --format="value(timestamp)" | wc -l

echo "Errors in last hour: $error_count"

# Check latency
gcloud monitoring time-series list \
  --project=lolo-app-prod \
  --filter='metric.type="cloudfunctions.googleapis.com/function/execution_times" AND resource.labels.function_name="api"' \
  --interval-start-time="$(date -u -d '-1 hour' +%Y-%m-%dT%H:%M:%SZ)" \
  --format="value(points[0].value.distributionValue.mean)"
```

---

### 2.4 Database Migration

> **Owner:** Raj Patel (Backend) + Carlos Rivera (DevOps)
> **Estimated Time:** 30-60 minutes
> **Must complete before:** Backend deployment Step 5

#### 2.4.1 Firestore Schema Verification

```bash
# Verify collections exist with correct structure
# Run validation script
node scripts/validate-firestore-schema.js --project=lolo-app-prod

# Expected collections:
# - users (with subcollections: partner, memories, conversations)
# - reminders
# - actionCards
# - leaderboard
# - analytics
# - subscriptions
# - gifts
# - systemConfig
```

- [ ] All collections enumerated and accessible
- [ ] Document field types match schema definition
- [ ] Subcollection structure verified (users/{uid}/partner, memories, conversations)
- [ ] System seed data loaded (action cards, zodiac base data)

#### 2.4.2 PostgreSQL Migration Scripts

```bash
# Connect to production Cloud SQL (via Cloud SQL Proxy)
cloud_sql_proxy -instances=lolo-app-prod:asia-southeast1:lolo-postgres-prod=tcp:5432 &

# Run migrations
cd functions/migrations

# Check current migration version
psql -h 127.0.0.1 -U lolo_admin -d lolo_prod \
  -c "SELECT version, applied_at FROM schema_migrations ORDER BY version DESC LIMIT 5;"

# Apply pending migrations (dry run first)
npm run migrate -- --env=prod --dry-run

# Apply for real
npm run migrate -- --env=prod

# Verify migration success
psql -h 127.0.0.1 -U lolo_admin -d lolo_prod \
  -c "SELECT version, applied_at FROM schema_migrations ORDER BY version DESC LIMIT 1;"
```

- [ ] All migrations applied successfully
- [ ] No schema drift between expected and actual
- [ ] Foreign key constraints intact
- [ ] Indexes created on analytics tables
- [ ] Connection pool settings verified (max_connections appropriate for function concurrency)

#### 2.4.3 Redis Cache Warming

```bash
# Warm critical caches after deployment
node scripts/warm-redis-cache.js --env=prod

# Verify cache contents
redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_AUTH \
  --tls --cacert /path/to/ca.pem \
  INFO keyspace

# Expected: db0 with keys for zodiac profiles, action card templates, rate limit counters
```

- [ ] Zodiac base profiles cached (12 entries)
- [ ] Action card templates cached
- [ ] Rate limit counters initialized
- [ ] Cache TTLs set correctly (profile: 600s, AI: 3600s, default: 300s)

#### 2.4.4 Data Validation

```bash
# Run data validation suite
node scripts/validate-production-data.js --project=lolo-app-prod

# Checks performed:
# 1. All 12 zodiac signs have base profiles
# 2. Action card templates loaded (minimum 50 cards)
# 3. SystemConfig document has required keys
# 4. No orphaned subcollection documents
# 5. Subscription products match RevenueCat catalog
```

- [ ] 12 zodiac base profiles present and valid
- [ ] Action card templates loaded (>= 50 cards across categories)
- [ ] SystemConfig has all required keys
- [ ] RevenueCat products match Firestore subscription records
- [ ] No data integrity issues flagged

---

## PART 3: ROLLBACK PROCEDURES

### 3.1 Rollback Decision Matrix

| Severity | Symptoms | Action | Timeline |
|---|---|---|---|
| **P0 - Critical** | App crash on launch, data loss, payment failures | Immediate rollback | < 15 minutes |
| **P1 - High** | Core feature broken (AI, SOS), > 5% error rate | Rollback within 30 min | < 30 minutes |
| **P2 - Medium** | Non-core feature broken, degraded perf, < 5% error rate | Hotfix or feature flag | < 2 hours |
| **P3 - Low** | Visual glitch, minor UX issue, edge case | Next release fix | Next sprint |

### 3.2 Backend Rollback

#### 3.2.1 Cloud Functions: Revert to Previous Version

```bash
# Option A: Revert traffic to previous revision (fastest - < 2 minutes)
gcloud functions deploy api --project=lolo-app-prod --gen2 \
  --region=asia-southeast1 \
  --update-traffic-config='{"splits":[{"revisionName":"api-previous","percent":100}]}'

gcloud functions deploy aiRouter --project=lolo-app-prod --gen2 \
  --region=asia-southeast1 \
  --update-traffic-config='{"splits":[{"revisionName":"aiRouter-previous","percent":100}]}'

gcloud functions deploy sosHandler --project=lolo-app-prod --gen2 \
  --region=asia-southeast1 \
  --update-traffic-config='{"splits":[{"revisionName":"sosHandler-previous","percent":100}]}'

# Revert all remaining functions
for fn in batchJobs webhooks notifications; do
  gcloud functions deploy $fn --project=lolo-app-prod --gen2 \
    --region=asia-southeast1 \
    --update-traffic-config="{\"splits\":[{\"revisionName\":\"${fn}-previous\",\"percent\":100}]}"
done
```

```bash
# Option B: Redeploy from previous git tag (if revision routing unavailable)
git checkout v0.9.9  # previous stable tag

cd functions
npm ci
npm run build

firebase deploy --only functions --project=lolo-app-prod --force

# Verify rollback
gcloud functions list --project=lolo-app-prod --gen2 \
  --format="table(name,status,updateTime)"
```

```bash
# Option C: Deploy specific function from previous source archive
gcloud functions deploy api \
  --project=lolo-app-prod \
  --gen2 \
  --region=asia-southeast1 \
  --source=gs://lolo-deployment-artifacts/functions/v0.9.9.zip \
  --runtime=nodejs20 \
  --trigger-http \
  --memory=512MiB \
  --min-instances=3 \
  --max-instances=200
```

**Post-Rollback Verification:**

```bash
# Verify functions are running previous version
PROD_URL="https://asia-southeast1-lolo-app-prod.cloudfunctions.net"
curl -s "$PROD_URL/api/health" | jq '.version'
# Should show previous version

# Monitor error rate for 15 minutes post-rollback
watch -n 10 'gcloud logging read \
  "resource.type=\"cloud_function\" AND severity>=ERROR" \
  --project=lolo-app-prod --freshness=15m --format="value(timestamp)" | wc -l'
```

- [ ] All functions reverted to previous version
- [ ] Health check returns previous version string
- [ ] Error rate returned to baseline (< 1%)
- [ ] No new errors in logs for 15 minutes

#### 3.2.2 Firestore Rules: Revert via Firebase CLI

```bash
# List previous rulesets
firebase firestore:rules:list --project=lolo-app-prod

# Identify the previous ruleset release name
# Format: projects/lolo-app-prod/databases/(default)/rulesets/{ruleset-id}

# Revert to specific ruleset
firebase firestore:rules:release \
  --project=lolo-app-prod \
  --ruleset="projects/lolo-app-prod/databases/(default)/rulesets/<previous-ruleset-id>"

# Or redeploy from git
git checkout v0.9.9 -- firestore.prod.rules
firebase deploy --only firestore:rules --project=lolo-app-prod
```

- [ ] Previous rules deployed
- [ ] Verified: authenticated user can read own data
- [ ] Verified: unauthenticated user denied access
- [ ] No permission errors in client app logs

#### 3.2.3 Database: Point-in-Time Recovery

**PostgreSQL PITR:**

```bash
# Create a recovery instance from backup
gcloud sql instances clone lolo-postgres-prod lolo-postgres-prod-recovery \
  --project=lolo-app-prod \
  --point-in-time="2026-02-15T01:00:00Z"  # Timestamp BEFORE the bad deployment

# Verify recovered data
cloud_sql_proxy -instances=lolo-app-prod:asia-southeast1:lolo-postgres-prod-recovery=tcp:5433 &

psql -h 127.0.0.1 -p 5433 -U lolo_admin -d lolo_prod \
  -c "SELECT COUNT(*) FROM users; SELECT MAX(created_at) FROM analytics_events;"

# If data is correct, promote recovery instance
# WARNING: This replaces the primary. Only do this for confirmed data corruption.
gcloud sql instances patch lolo-postgres-prod \
  --project=lolo-app-prod \
  --activation-policy=NEVER

gcloud sql instances patch lolo-postgres-prod-recovery \
  --project=lolo-app-prod \
  --activation-policy=ALWAYS

# Update connection strings in Secret Manager
gcloud secrets versions add POSTGRES_HOST --data-file=- <<< "lolo-postgres-prod-recovery"
```

**Firestore PITR:**

```bash
# Firestore PITR (available within 7-day window)
gcloud firestore databases restore \
  --source-database='(default)' \
  --destination-database='lolo-recovery' \
  --snapshot-time='2026-02-15T01:00:00Z' \
  --project=lolo-app-prod

# Verify restored data, then export/import if needed
gcloud firestore export gs://lolo-backups/recovery-export \
  --database='lolo-recovery' \
  --project=lolo-app-prod

gcloud firestore import gs://lolo-backups/recovery-export \
  --database='(default)' \
  --project=lolo-app-prod
```

- [ ] Recovery instance created and data verified
- [ ] Data integrity confirmed (row counts, latest timestamps)
- [ ] Application reconnected to recovered database
- [ ] Replication re-established to read replica

#### 3.2.4 Redis: Flush and Rebuild

```bash
# Option A: Flush all caches (safe -- caches rebuild automatically)
redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_AUTH \
  --tls --cacert /path/to/ca.pem \
  FLUSHALL ASYNC

# Warm caches from persistence
node scripts/warm-redis-cache.js --env=prod

# Option B: Restore from RDB snapshot (if persistence data is corrupted)
gcloud redis instances failover lolo-redis-prod \
  --region=asia-southeast1 \
  --project=lolo-app-prod \
  --data-protection-mode=limited-data-loss
```

- [ ] Cache flushed or restored from snapshot
- [ ] Critical caches rewarmed (zodiac profiles, action cards)
- [ ] Rate limit counters reset
- [ ] Application reconnected and cache hits resuming

---

### 3.3 Mobile App Rollback

#### 3.3.1 Android: Halt Staged Rollout

```bash
# Halt the current staged rollout immediately
fastlane supply --track production \
  --package_name com.lolo.app \
  --json_key play-store-credentials.json \
  --rollout 0  # Halts rollout, no new users get this version

# Deactivate the release (revert to previous version)
# Via Play Console UI: Release > Production > Manage > Halt rollout
# API alternative:
curl -X PATCH \
  "https://androidpublisher.googleapis.com/androidpublisher/v3/applications/com.lolo.app/edits/$EDIT_ID/tracks/production" \
  -H "Authorization: Bearer $PLAY_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"releases":[{"status":"halted","versionCodes":["'$VERSION_CODE'"]}]}'
```

- [ ] Staged rollout halted
- [ ] Users who already updated remain on new version (cannot force downgrade on Android)
- [ ] Previous version still available for users who have not updated
- [ ] If critical: publish hotfix build as new version with higher version code

**Emergency Hotfix Flow (Android):**

```bash
# 1. Create hotfix branch
git checkout -b hotfix/1.0.1 v1.0.0

# 2. Apply fix, bump version
# In pubspec.yaml: version: 1.0.1+2

# 3. Build and upload
flutter build appbundle --release --dart-define=FLAVOR=production
fastlane supply --aab build/app/outputs/bundle/release/app-release.aab \
  --track production \
  --package_name com.lolo.app \
  --json_key play-store-credentials.json \
  --rollout 1.0
```

#### 3.3.2 iOS: Remove from Sale / Expedited Review

```bash
# Option A: Pause phased release
fastlane deliver --phased_release_state PAUSE

# Option B: Remove from App Store (nuclear option)
# Via App Store Connect UI: App Information > Availability > Remove from Sale
# Users who have it installed keep it, new downloads stopped

# Option C: Expedited review for hotfix
# Submit hotfix build via Transporter/fastlane
# Request expedited review via App Store Connect > Contact Us
fastlane deliver --ipa build/ios/ipa/LOLO.ipa \
  --submit_for_review true \
  --automatic_release true \
  --app_identifier com.lolo.app
# Then request expedited review in App Store Connect
```

- [ ] Phased release paused (if issue is non-critical)
- [ ] Removed from sale (if critical data/security issue)
- [ ] Hotfix submitted with expedited review request
- [ ] Typical expedited review: 24 hours (not guaranteed)

#### 3.3.3 Huawei: Unpublish and Resubmit

```bash
# Unpublish from AppGallery
# Via AppGallery Connect console: App Information > Unpublish

# Resubmit fixed version
flutter build apk --release --dart-define=FLAVOR=huawei --dart-define=HMS_ENABLED=true
java -jar AppGalleryConnectCLI.jar upload \
  --appId $HUAWEI_APP_ID \
  --filePath build/app/outputs/flutter-apk/app-release.apk \
  --token $HUAWEI_CONNECT_TOKEN
```

- [ ] Current version unpublished
- [ ] Hotfix version built and uploaded
- [ ] Submitted for review (3-5 business days typical)

#### 3.3.4 Emergency: Force Update via Remote Config

For critical issues where users on the broken version must update immediately:

```bash
# Set force update flag via Firebase Remote Config
firebase remoteconfig:set --project=lolo-app-prod \
  --parameter-key="force_update_enabled" \
  --parameter-value="true"

firebase remoteconfig:set --project=lolo-app-prod \
  --parameter-key="min_app_version_android" \
  --parameter-value="1.0.1"

firebase remoteconfig:set --project=lolo-app-prod \
  --parameter-key="min_app_version_ios" \
  --parameter-value="1.0.1"

# Publish Remote Config changes
firebase remoteconfig:rollout --project=lolo-app-prod

# Alternatively, set maintenance mode to block all usage
firebase remoteconfig:set --project=lolo-app-prod \
  --parameter-key="maintenance_mode" \
  --parameter-value="true"

firebase remoteconfig:rollout --project=lolo-app-prod
```

- [ ] Force update flag set for affected platform(s)
- [ ] Minimum version bumped to hotfix version
- [ ] Users see "Update Required" dialog on next app open
- [ ] Hotfix version available in stores before enabling force update
- [ ] Maintenance mode used as interim blocker if hotfix not yet available

---

### 3.4 Feature Rollback (via Remote Config)

> **Purpose:** Disable problematic features without requiring a full app update.
> **Response time:** < 5 minutes from decision to effect

#### 3.4.1 Feature Flags for Each Module

```bash
# Disable SOS Mode
firebase remoteconfig:set --project=lolo-app-prod \
  --parameter-key="feature_sos_mode_enabled" \
  --parameter-value="false"

# Disable Gift Engine v2 (revert to v1)
firebase remoteconfig:set --project=lolo-app-prod \
  --parameter-key="feature_gift_engine_v2" \
  --parameter-value="false"

# Disable Voice Notes
firebase remoteconfig:set --project=lolo-app-prod \
  --parameter-key="feature_voice_notes" \
  --parameter-value="false"

# Apply all changes
firebase remoteconfig:rollout --project=lolo-app-prod
```

| Feature Flag | Default | Effect When Disabled |
|---|---|---|
| `feature_sos_mode_enabled` | `true` | SOS button hidden, SOS cloud function rejects requests |
| `feature_gift_engine_v2` | `false` | Falls back to v1 gift recommendations |
| `feature_voice_notes` | `false` | Voice record button hidden in memory vault |
| `maintenance_mode` | `false` | Shows full-screen maintenance message, blocks all features |
| `feature_zodiac_compatibility` | `true` | Hides compatibility score display |
| `feature_action_cards` | `true` | Hides action cards tab, stops card generation |
| `feature_gamification` | `true` | Hides leaderboard and XP display |
| `feature_ai_chat` | `true` | Disables AI chat, shows "temporarily unavailable" |

#### 3.4.2 A/B Test Kill Switches

```bash
# List active A/B tests
firebase abtesting:list --project=lolo-app-prod

# Stop a specific experiment immediately
firebase abtesting:stop --project=lolo-app-prod \
  --experiment-id="onboarding_flow_v2"

# Roll back all users to control variant
firebase abtesting:rollback --project=lolo-app-prod \
  --experiment-id="onboarding_flow_v2" \
  --variant="control"
```

- [ ] Identify which A/B test is causing issues
- [ ] Stop experiment (all users get control variant)
- [ ] Verify user experience returns to baseline
- [ ] Document findings for post-mortem

#### 3.4.3 Maintenance Mode Activation

```bash
# Activate maintenance mode (blocks all app functionality)
firebase remoteconfig:set --project=lolo-app-prod \
  --parameter-key="maintenance_mode" \
  --parameter-value="true"
firebase remoteconfig:rollout --project=lolo-app-prod

# Verify maintenance mode is active
firebase remoteconfig:get --project=lolo-app-prod | \
  jq '.parameters.maintenance_mode'

# IMPORTANT: Also update the maintenance message
firebase remoteconfig:set --project=lolo-app-prod \
  --parameter-key="maintenance_message" \
  --parameter-value="We're performing scheduled maintenance. We'll be back shortly!"

firebase remoteconfig:rollout --project=lolo-app-prod
```

**Maintenance Mode Behavior:**
- App shows full-screen maintenance UI with message
- All API calls return 503 Service Unavailable
- Background jobs continue (batch processing, subscription sync)
- Push notifications suppressed during maintenance
- Estimated downtime shown to users (if configured)

**Deactivate Maintenance Mode:**

```bash
firebase remoteconfig:set --project=lolo-app-prod \
  --parameter-key="maintenance_mode" \
  --parameter-value="false"
firebase remoteconfig:rollout --project=lolo-app-prod
```

---

## PART 4: POST-DEPLOYMENT MONITORING

### 4.1 First 24 Hours

> **Owner:** Carlos Rivera (DevOps) -- primary on-call
> **Escalation:** Omar Al-Rashidi (Tech Lead) -- secondary on-call

#### 4.1.1 Real-Time Monitoring Dashboard

**Dashboard URL:** `https://console.cloud.google.com/monitoring/dashboards/custom/lolo-prod`

```bash
# Create monitoring dashboard via gcloud
gcloud monitoring dashboards create \
  --project=lolo-app-prod \
  --config-from-file=infra/monitoring/launch-dashboard.json
```

**Dashboard Widgets:**

| Widget | Metric | Alert Threshold |
|---|---|---|
| Crash-Free Rate | Crashlytics crash-free sessions | < 99.5% |
| API Error Rate | Cloud Functions 5xx / total | > 2% |
| AI Response Time (p95) | Custom metric: ai_response_ms | > 5,000ms |
| Payment Success Rate | RevenueCat webhook success | < 95% |
| Active Users (real-time) | Firebase Analytics real-time | Baseline TBD |
| Cloud Functions Invocations | cloudfunctions invocation_count | Spike > 5x baseline |
| Memory Usage | Cloud Functions memory utilization | > 80% |
| Firestore Read/Write Ops | firestore document reads/writes | > budget threshold |
| Redis Hit Rate | Custom metric: cache_hit_ratio | < 70% |
| AI API Costs (running) | Custom metric: ai_cost_usd | > $500/day |

#### 4.1.2 Key Metrics -- First 24 Hours Targets

| Metric | Target | Critical | Source |
|---|---|---|---|
| Crash-free rate (Android) | > 99.5% | < 99.0% | Firebase Crashlytics |
| Crash-free rate (iOS) | > 99.5% | < 99.0% | Firebase Crashlytics |
| API error rate | < 1% | > 2% | Cloud Monitoring |
| AI response time (p50) | < 2s | > 5s | Custom metric |
| AI response time (p95) | < 5s | > 10s | Custom metric |
| Payment success rate | > 98% | < 95% | RevenueCat dashboard |
| App startup time (p50) | < 3s | > 5s | Firebase Performance |
| ANR rate (Android) | < 0.2% | > 0.5% | Play Console Vitals |
| Memory usage (app) | < 200MB | > 350MB | Firebase Performance |
| Daily AI API cost | < $200 | > $500 | Cloud Billing |

#### 4.1.3 Alert Configuration

```bash
# Create alert policies
gcloud monitoring policies create \
  --project=lolo-app-prod \
  --notification-channels="projects/lolo-app-prod/notificationChannels/slack-lolo-alerts,projects/lolo-app-prod/notificationChannels/pagerduty-lolo" \
  --display-name="API Error Rate > 2%" \
  --condition-display-name="5xx rate exceeds 2%" \
  --condition-filter='resource.type="cloud_function" AND metric.type="cloudfunctions.googleapis.com/function/execution_count" AND metric.labels.status!="ok"' \
  --condition-threshold-value=0.02 \
  --condition-threshold-comparison=COMPARISON_GT \
  --duration=300s

# Alert channels
# 1. Slack #lolo-alerts (all alerts)
# 2. PagerDuty (P0/P1 only)
# 3. Email: carlos@lolo.app, omar@lolo.app
# 4. SMS: DevOps on-call phone (P0 only)
```

**Alert Routing:**

| Alert | Channel | Auto-Action |
|---|---|---|
| Crash-free < 99% | PagerDuty + Slack + SMS | Page on-call |
| API errors > 5% | PagerDuty + Slack | Page on-call |
| API errors > 2% | Slack | Notify team |
| AI cost > $500/day | Slack + Email | Notify lead |
| AI cost > $1000/day | PagerDuty + Slack | Auto-throttle AI requests |
| Memory > 80% | Slack | Notify DevOps |
| Budget alert ($2000/day) | Email + Slack | Notify finance + DevOps |
| SSL cert < 14 days | Email | Auto-renew ticket |

#### 4.1.4 On-Call Schedule (First Week)

| Time Slot (UTC) | Primary | Secondary | Escalation |
|---|---|---|---|
| Mon 00:00-08:00 | Carlos Rivera | Omar Al-Rashidi | CTO |
| Mon 08:00-16:00 | Carlos Rivera | Raj Patel | Omar Al-Rashidi |
| Mon 16:00-00:00 | Omar Al-Rashidi | Carlos Rivera | CTO |
| Tue-Fri | Rotating 8h shifts | Same pattern | Same pattern |
| Sat-Sun | Carlos Rivera (12h) | Omar Al-Rashidi (12h) | CTO |

**Escalation Procedure:**

1. **0 min:** Alert fires, on-call primary acknowledged
2. **5 min:** If no acknowledgment, escalate to secondary
3. **10 min:** If not acknowledged, page CTO
4. **15 min:** If P0, assemble war room (Slack + Google Meet)
5. **30 min:** If not resolved, initiate rollback per decision matrix (Section 3.1)

#### 4.1.5 First 24 Hours Checklist

**Hour 0-1 (Deployment Complete):**
- [ ] All monitoring dashboards accessible and populated
- [ ] Alert channels verified (send test alert)
- [ ] On-call primary confirmed available
- [ ] Slack war room channel active
- [ ] Backend health check: all green
- [ ] First user sign-ups visible in analytics

**Hour 1-4:**
- [ ] No crash spikes in Crashlytics
- [ ] API error rate stable < 1%
- [ ] AI responses generating correctly in all 3 languages
- [ ] Push notifications delivering
- [ ] Payment flow tested with real transaction (refund immediately)

**Hour 4-12:**
- [ ] Check scheduled functions executed correctly (daily jobs)
- [ ] Review any app store pre-launch reports
- [ ] Monitor user feedback channels
- [ ] Verify CDN cache hit rates
- [ ] Check Cloud SQL connection pool health

**Hour 12-24:**
- [ ] Handoff to next on-call shift documented
- [ ] Cumulative error summary posted to Slack
- [ ] Any non-critical issues logged as tickets
- [ ] Cost report for first day reviewed
- [ ] Decision: proceed with rollout expansion or hold

---

### 4.2 First Week

> **Owner:** Carlos Rivera (DevOps) with daily standup input from full team

#### 4.2.1 Daily Health Check Routine

**Run every day at 09:00 SGT (01:00 UTC):**

```bash
#!/bin/bash
# FILE: scripts/daily-health-check.sh

echo "========================================="
echo "LOLO Daily Health Check - $(date -u +%Y-%m-%d)"
echo "========================================="

PROJECT="lolo-app-prod"
REGION="asia-southeast1"

# 1. Cloud Functions health
echo -e "\n--- Cloud Functions Status ---"
gcloud functions list --project=$PROJECT --gen2 \
  --format="table(name,state,updateTime)" --region=$REGION

# 2. Error count (last 24h)
echo -e "\n--- Errors (Last 24h) ---"
ERROR_COUNT=$(gcloud logging read \
  "resource.type=\"cloud_function\" AND severity>=ERROR" \
  --project=$PROJECT --freshness=24h --format="value(timestamp)" | wc -l)
echo "Total errors: $ERROR_COUNT"

# 3. Cloud SQL status
echo -e "\n--- Cloud SQL Status ---"
gcloud sql instances describe lolo-postgres-prod --project=$PROJECT \
  --format="table(state,settings.dataDiskSizeGb,settings.dataDiskType)"

# 4. Redis status
echo -e "\n--- Redis Status ---"
gcloud redis instances describe lolo-redis-prod --region=$REGION \
  --project=$PROJECT --format="table(state,memorySizeGb)"

# 5. Billing summary
echo -e "\n--- Estimated Cost (Last 24h) ---"
gcloud billing budgets list --billing-account=$BILLING_ACCOUNT \
  --format="table(displayName,amount.specifiedAmount.currencyCode,amount.specifiedAmount.units)"

echo -e "\n========================================="
echo "Health check complete."
```

- [ ] Run daily health check script
- [ ] Review Crashlytics for new crash clusters
- [ ] Check Play Console vitals (ANR rate, crash rate, startup time)
- [ ] Check App Store Connect crash reports
- [ ] Review user-reported issues in support queue
- [ ] Verify scheduled jobs ran successfully overnight
- [ ] Check AI API cost accumulation

#### 4.2.2 Performance Baseline Establishment

**By end of Week 1, establish baselines for:**

| Metric | Measurement Method | Baseline Target |
|---|---|---|
| API latency (p50, p95, p99) | Cloud Monitoring | p50 < 200ms, p95 < 1s, p99 < 3s |
| App cold start time | Firebase Performance | Android < 3s, iOS < 2.5s |
| Firestore read latency | Firebase Performance traces | p95 < 500ms |
| AI response generation | Custom metric | p50 < 2s, p95 < 5s |
| Cache hit ratio | Redis INFO stats | > 80% |
| Daily active users | Firebase Analytics | Establish initial baseline |
| Session duration | Firebase Analytics | Establish initial baseline |
| Screens per session | Firebase Analytics | Establish initial baseline |

```bash
# Export baseline metrics
gcloud monitoring time-series list \
  --project=lolo-app-prod \
  --filter='metric.type="cloudfunctions.googleapis.com/function/execution_times"' \
  --interval-start-time="$(date -u -d '-7 days' +%Y-%m-%dT%H:%M:%SZ)" \
  --format=json > baselines/week1-function-latency.json
```

#### 4.2.3 Cost Monitoring

```bash
# Daily cost breakdown
gcloud billing accounts describe $BILLING_ACCOUNT \
  --format="value(displayName)"

# Set up cost export to BigQuery for detailed analysis
gcloud billing export create \
  --billing-account=$BILLING_ACCOUNT \
  --dataset=lolo_billing \
  --table=gcp_costs
```

**Key Cost Centers to Monitor:**

| Service | Daily Budget | Alert At | Kill Switch |
|---|---|---|---|
| Cloud Functions | $100 | $150 | Scale down maxInstances |
| Anthropic API (Claude) | $200 | $300 | Switch to cheaper model |
| OpenAI API (GPT) | $50 | $75 | Reduce to fallback-only |
| Google AI (Gemini) | $50 | $75 | Reduce to fallback-only |
| xAI (Grok) | $50 | $75 | Reduce to fallback-only |
| Firestore | $50 | $75 | Review query patterns |
| Cloud SQL | $30 | $45 | Static cost (provisioned) |
| Redis | $20 | $30 | Static cost (provisioned) |
| Cloud Storage + CDN | $20 | $30 | Review cache policies |
| **Total Daily** | **$570** | **$900** | **Maintenance mode** |

#### 4.2.4 User Feedback Monitoring

- [ ] Google Play Console: monitor reviews daily (respond to 1-star within 24h)
- [ ] App Store Connect: monitor reviews daily
- [ ] In-app feedback widget: review submissions every 12 hours
- [ ] Slack `#lolo-user-feedback` channel: auto-post from all sources
- [ ] Social media mentions: monitor Twitter/X, Reddit (keyword: "LOLO app")
- [ ] Email support: support@lolo.app (monitored by support team)

**Review Response Templates:**

```
# 1-Star Response Template
Hi [User], thank you for trying LOLO. We're sorry about your experience
with [issue]. Our team is actively working on a fix. Could you email us
at support@lolo.app with more details? We'd love to make this right.

# Feature Request Response Template
Thanks for the suggestion, [User]! We've added [feature] to our roadmap.
Stay tuned for updates in upcoming releases!
```

---

### 4.3 Ongoing Operations

#### 4.3.1 Weekly Infrastructure Review

**Every Monday 10:00 SGT:**

- [ ] Review Cloud Monitoring dashboards for anomalies
- [ ] Check Cloud SQL disk usage trend (alert if projected to exceed 80% within 30 days)
- [ ] Review Redis memory utilization trend
- [ ] Check SSL certificate expiration dates
- [ ] Review Cloud Armor blocked request logs
- [ ] Audit IAM permissions (any unexpected changes)
- [ ] Review Firebase usage vs quotas
- [ ] Update capacity planning spreadsheet

#### 4.3.2 Monthly Security Scan

```bash
# Run dependency vulnerability scan
cd functions && npm audit
cd ../.. && flutter pub outdated

# Check for exposed secrets
gitleaks detect --source=. --verbose

# Review Cloud Audit Logs
gcloud logging read \
  'logName="projects/lolo-app-prod/logs/cloudaudit.googleapis.com%2Factivity"' \
  --project=lolo-app-prod --freshness=30d \
  --format="table(timestamp,protoPayload.methodName,protoPayload.authenticationInfo.principalEmail)" \
  --limit=100

# Verify Secret Manager rotation
for secret in $(gcloud secrets list --project=lolo-app-prod --format="value(name)"); do
  AGE=$(gcloud secrets versions list $secret --project=lolo-app-prod \
    --limit=1 --format="value(createTime)")
  echo "$secret: Last rotated $AGE"
done
```

Monthly Security Checklist:
- [ ] npm audit: zero critical/high vulnerabilities
- [ ] Flutter pub outdated: no security-critical packages outdated
- [ ] No leaked secrets in repository
- [ ] IAM audit: no unauthorized role grants
- [ ] Secret Manager: all secrets rotated within 90 days
- [ ] Firebase Auth: review suspicious sign-up patterns
- [ ] Cloud Armor: review and update WAF rules
- [ ] SSL certificates: > 30 days until expiration

#### 4.3.3 Quarterly Disaster Recovery Drill

**Drill Procedure (run in staging environment):**

1. **Simulate Cloud Functions failure:**
   - Delete a non-critical function in staging
   - Practice redeployment from git tag
   - Measure time to recovery (target: < 15 minutes)

2. **Simulate database corruption:**
   - Insert invalid data in staging Firestore
   - Practice PITR recovery
   - Verify data integrity post-recovery (target: < 30 minutes)

3. **Simulate Redis outage:**
   - Flush staging Redis
   - Verify app degrades gracefully (cache misses, not failures)
   - Measure cache warm-up time (target: < 5 minutes)

4. **Simulate complete rollback:**
   - Deploy intentionally broken code to staging
   - Practice full rollback procedure (functions + rules + database)
   - Measure end-to-end rollback time (target: < 30 minutes)

- [ ] DR drill completed and documented
- [ ] Recovery times within targets
- [ ] Runbook updated with lessons learned
- [ ] Team debriefed on findings

#### 4.3.4 Cost Optimization Review (Quarterly)

```bash
# Export billing data for analysis
bq query --use_legacy_sql=false \
  "SELECT service.description, SUM(cost) as total_cost
   FROM \`lolo-app-prod.lolo_billing.gcp_costs\`
   WHERE DATE(usage_start_time) >= DATE_SUB(CURRENT_DATE(), INTERVAL 90 DAY)
   GROUP BY service.description
   ORDER BY total_cost DESC"
```

Optimization Areas:
- [ ] Cloud Functions: right-size memory allocation based on actual usage
- [ ] Cloud Functions: adjust minInstances based on traffic patterns
- [ ] AI API: review model selection efficiency (cost per quality)
- [ ] Firestore: review query patterns, optimize indexes
- [ ] Cloud SQL: evaluate instance tier vs actual load
- [ ] Redis: evaluate memory tier vs actual usage
- [ ] Cloud Storage: lifecycle policies for old backups
- [ ] CDN: cache hit ratio optimization

#### 4.3.5 Capacity Planning

**Monthly Capacity Review:**

```bash
# User growth projection
# Query analytics for daily active users trend
bq query --use_legacy_sql=false \
  "SELECT DATE(event_timestamp) as date, COUNT(DISTINCT user_id) as dau
   FROM \`lolo-app-prod.analytics.events\`
   WHERE DATE(event_timestamp) >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY)
   GROUP BY date ORDER BY date"
```

| Resource | Current Capacity | Scale Trigger | Scaling Action |
|---|---|---|---|
| Cloud Functions (api) | maxInstances=200 | Avg utilization > 60% | Increase to 400 |
| Cloud Functions (aiRouter) | maxInstances=100 | Avg utilization > 60% | Increase to 200 |
| Cloud SQL | db-custom-2-8192 | CPU > 70% sustained | Upgrade to db-custom-4-16384 |
| Cloud SQL storage | 100 GB | Usage > 70% | Enable auto-increase |
| Redis | 5 GB Standard HA | Memory > 80% | Upgrade to 10 GB |
| Firestore | Auto-scaling | Daily reads > 5M | Review query optimization |
| AI API budget | $570/day | Consistent > $500/day | Review model mix, implement caching |

**Growth Milestones and Infrastructure Actions:**

| Users | Action Required |
|---|---|
| 1,000 DAU | Establish baselines, no changes |
| 10,000 DAU | Add read replica region (me-central1 for GCC users) |
| 50,000 DAU | Upgrade Cloud SQL tier, increase Redis memory |
| 100,000 DAU | Multi-region Cloud Functions, CDN expansion |
| 500,000 DAU | Dedicated AI inference endpoints, Firestore sharding review |

---

## APPENDIX A: Quick Reference Commands

### Emergency Contacts

| Role | Name | Phone | Slack |
|---|---|---|---|
| DevOps Lead | Carlos Rivera | +XX-XXXX-XXXX | @carlos |
| Tech Lead | Omar Al-Rashidi | +XX-XXXX-XXXX | @omar |
| Backend Dev | Raj Patel | +XX-XXXX-XXXX | @raj |
| CTO | (TBD) | +XX-XXXX-XXXX | @cto |

### One-Liner Emergency Commands

```bash
# EMERGENCY: Enable maintenance mode
firebase remoteconfig:set --project=lolo-app-prod --parameter-key="maintenance_mode" --parameter-value="true" && firebase remoteconfig:rollout --project=lolo-app-prod

# EMERGENCY: Disable maintenance mode
firebase remoteconfig:set --project=lolo-app-prod --parameter-key="maintenance_mode" --parameter-value="false" && firebase remoteconfig:rollout --project=lolo-app-prod

# EMERGENCY: Rollback all Cloud Functions to previous revision
for fn in api aiRouter sosHandler batchJobs webhooks notifications; do gcloud functions deploy $fn --project=lolo-app-prod --gen2 --region=asia-southeast1 --update-traffic-config="{\"splits\":[{\"revisionName\":\"${fn}-previous\",\"percent\":100}]}"; done

# EMERGENCY: Force update all users
firebase remoteconfig:set --project=lolo-app-prod --parameter-key="force_update_enabled" --parameter-value="true" && firebase remoteconfig:rollout --project=lolo-app-prod

# EMERGENCY: Kill AI feature (stop costs)
firebase remoteconfig:set --project=lolo-app-prod --parameter-key="feature_ai_chat" --parameter-value="false" && firebase remoteconfig:rollout --project=lolo-app-prod

# EMERGENCY: Halt Android rollout
fastlane supply --track production --package_name com.lolo.app --json_key play-store-credentials.json --rollout 0

# EMERGENCY: Pause iOS phased release
fastlane deliver --phased_release_state PAUSE
```

---

## APPENDIX B: Deployment Checklist Summary

### Pre-Deployment Sign-Off

| Check | Owner | Status | Sign-Off |
|---|---|---|---|
| Infrastructure verified | Carlos Rivera | [ ] | _______ |
| Application builds clean | Omar Al-Rashidi | [ ] | _______ |
| All tests passing | QA Lead | [ ] | _______ |
| Store listings ready | Marketing Lead | [ ] | _______ |
| Security review complete | Carlos Rivera | [ ] | _______ |
| Rollback plan reviewed | Carlos Rivera | [ ] | _______ |
| On-call schedule confirmed | Carlos Rivera | [ ] | _______ |
| Stakeholders notified | Product Manager | [ ] | _______ |

### Go / No-Go Decision

| Criteria | Required | Actual |
|---|---|---|
| All infrastructure checks pass | Yes | [ ] |
| Zero critical test failures | Yes | [ ] |
| Store listings approved | Yes | [ ] |
| On-call coverage confirmed | Yes | [ ] |
| Rollback tested in staging | Yes | [ ] |
| All team members available | Preferred | [ ] |

**GO Decision:** _______ (Signature) Date: _______

**NO-GO Reason:** ______________________________________________________

---

*Document prepared by Carlos Rivera, DevOps Engineer. This runbook is a living document. Update after every deployment and post-incident review.*

*Last updated: 2026-02-15 | Next review: After v1.0.0 launch*
