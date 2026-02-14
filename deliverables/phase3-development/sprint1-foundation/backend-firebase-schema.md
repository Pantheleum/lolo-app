# LOLO -- Firebase Setup & Database Schema (Part A)

**Task ID:** S1-03A
**Prepared by:** Raj Patel, Backend Developer
**Date:** February 15, 2026
**Version:** 1.0
**Classification:** Internal -- Confidential
**Sprint:** Sprint 1 -- Foundation (Weeks 9-10)
**Dependencies:** Architecture Document v1.0, API Contracts v1.0, DevOps CI/CD Pipeline v1.0

---

## Table of Contents

1. [Firebase Project Configuration](#1-firebase-project-configuration)
2. [Firestore Database Schema](#2-firestore-database-schema)
3. [Firestore Security Rules](#3-firestore-security-rules)
4. [Redis Cache Schema](#4-redis-cache-schema)
5. [PostgreSQL Schema (Analytics + Billing)](#5-postgresql-schema)
6. [Environment Configuration](#6-environment-configuration)

---

## 1. Firebase Project Configuration

### 1.1 `.firebaserc`

```json
{
  "projects": {
    "default": "lolo-app-dev",
    "dev": "lolo-app-dev",
    "staging": "lolo-app-staging",
    "prod": "lolo-app-prod"
  },
  "targets": {
    "lolo-app-prod": {
      "hosting": {
        "admin": ["lolo-admin-prod"]
      }
    },
    "lolo-app-staging": {
      "hosting": {
        "admin": ["lolo-admin-staging"]
      }
    }
  }
}
```

### 1.2 `firebase.json`

```json
{
  "firestore": {
    "rules": "firestore.rules",
    "indexes": "firestore.indexes.json"
  },
  "functions": [
    {
      "source": "functions",
      "codebase": "default",
      "runtime": "nodejs20",
      "ignore": ["node_modules", ".git", "firebase-debug.log", "firebase-debug.*.log", "*.local"],
      "predeploy": ["npm --prefix \"$RESOURCE_DIR\" run lint", "npm --prefix \"$RESOURCE_DIR\" run build"]
    }
  ],
  "storage": {
    "rules": "storage.rules"
  },
  "hosting": {
    "public": "public",
    "ignore": ["firebase.json", "**/.*", "**/node_modules/**"],
    "rewrites": [
      { "source": "/api/v1/**", "function": "api" }
    ]
  },
  "emulators": {
    "auth": {
      "port": 9099,
      "host": "0.0.0.0"
    },
    "functions": {
      "port": 5001,
      "host": "0.0.0.0"
    },
    "firestore": {
      "port": 8080,
      "host": "0.0.0.0"
    },
    "storage": {
      "port": 9199,
      "host": "0.0.0.0"
    },
    "ui": {
      "enabled": true,
      "port": 4000,
      "host": "0.0.0.0"
    },
    "pubsub": {
      "port": 8085,
      "host": "0.0.0.0"
    },
    "singleProjectMode": true,
    "hub": {
      "port": 4400
    },
    "logging": {
      "port": 4500
    }
  }
}
```

### 1.3 `firestore.indexes.json`

```json
{
  "indexes": [
    {
      "collectionGroup": "reminders",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "completed", "order": "ASCENDING" },
        { "fieldPath": "date", "order": "ASCENDING" }
      ]
    },
    {
      "collectionGroup": "reminders",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "category", "order": "ASCENDING" },
        { "fieldPath": "date", "order": "ASCENDING" }
      ]
    },
    {
      "collectionGroup": "reminders",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "completed", "order": "ASCENDING" },
        { "fieldPath": "category", "order": "ASCENDING" },
        { "fieldPath": "date", "order": "ASCENDING" }
      ]
    },
    {
      "collectionGroup": "messages",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "favorited", "order": "ASCENDING" },
        { "fieldPath": "createdAt", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "messages",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "mode", "order": "ASCENDING" },
        { "fieldPath": "createdAt", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "messages",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "tone", "order": "ASCENDING" },
        { "fieldPath": "createdAt", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "gifts",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "category", "order": "ASCENDING" },
        { "fieldPath": "createdAt", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "gifts",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "partnerProfileId", "order": "ASCENDING" },
        { "fieldPath": "createdAt", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "gifts",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "feedback", "order": "ASCENDING" },
        { "fieldPath": "createdAt", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "sosSessions",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "severity", "order": "ASCENDING" },
        { "fieldPath": "createdAt", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "actionCards",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "status", "order": "ASCENDING" },
        { "fieldPath": "createdAt", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "actionCards",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "type", "order": "ASCENDING" },
        { "fieldPath": "status", "order": "ASCENDING" },
        { "fieldPath": "createdAt", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "memories",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "category", "order": "ASCENDING" },
        { "fieldPath": "createdAt", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "memories",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "sheSaid", "order": "ASCENDING" },
        { "fieldPath": "createdAt", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "notifications",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "read", "order": "ASCENDING" },
        { "fieldPath": "createdAt", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "notifications",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "type", "order": "ASCENDING" },
        { "fieldPath": "createdAt", "order": "DESCENDING" }
      ]
    }
  ],
  "fieldOverrides": [
    {
      "collectionGroup": "reminders",
      "fieldPath": "date",
      "indexes": [
        { "order": "ASCENDING", "queryScope": "COLLECTION" },
        { "order": "DESCENDING", "queryScope": "COLLECTION" }
      ]
    },
    {
      "collectionGroup": "messages",
      "fieldPath": "createdAt",
      "indexes": [
        { "order": "DESCENDING", "queryScope": "COLLECTION" }
      ]
    },
    {
      "collectionGroup": "actionCards",
      "fieldPath": "createdAt",
      "indexes": [
        { "order": "DESCENDING", "queryScope": "COLLECTION" }
      ]
    }
  ]
}
```

---

## 2. Firestore Database Schema

### 2.1 `users` (Top-Level Collection)

**Path:** `users/{uid}`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `uid` | `string` | Yes | Firebase Auth UID (same as doc ID) |
| `email` | `string` | Yes | User email address |
| `displayName` | `string` | Yes | Display name (2-50 chars) |
| `language` | `string` | Yes | Locale: `en`, `ar`, or `ms` |
| `tier` | `string` | Yes | Subscription tier: `free`, `pro`, or `legend` |
| `profilePhotoUrl` | `string` | No | Cloud Storage URL for avatar |
| `onboardingComplete` | `boolean` | Yes | Whether onboarding flow is finished |
| `fcmToken` | `string` | No | Firebase Cloud Messaging device token |
| `settings` | `map` | Yes | Nested settings object (see below) |
| `createdAt` | `timestamp` | Yes | Account creation timestamp |
| `lastActiveAt` | `timestamp` | Yes | Last app open timestamp |
| `deletionScheduledAt` | `timestamp` | No | Set when account deletion is requested |

**`settings` nested map:**

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `theme` | `string` | Yes | `light`, `dark`, or `system` |
| `quietHoursStart` | `string` | No | HH:mm format, e.g. `"22:00"` |
| `quietHoursEnd` | `string` | No | HH:mm format, e.g. `"07:00"` |
| `notificationPreferences` | `map` | Yes | `{ reminders: bool, actionCards: bool, streaks: bool, sos: bool }` |
| `biometricEnabled` | `boolean` | Yes | App lock via biometrics |

---

### 2.2 `users/{uid}/partnerProfiles/{profileId}`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `name` | `string` | Yes | Partner's display name |
| `birthday` | `timestamp` | No | Partner's birthday |
| `zodiacSign` | `string` | No | One of 12 zodiac signs (lowercase) |
| `loveLanguage` | `string` | No | `words`, `acts`, `gifts`, `time`, `touch` |
| `communicationStyle` | `string` | No | `direct`, `indirect`, `passive`, `assertive` |
| `relationshipStatus` | `string` | Yes | `dating`, `engaged`, `married`, `complicated`, `new` |
| `keyDates` | `array<map>` | No | `[{ label: string, date: timestamp }]` |
| `preferences` | `map` | No | `{ favorites: string[], dislikes: string[], hobbies: string[] }` |
| `culturalContext` | `map` | No | `{ religion: string, conservatism: string, holidays: string[] }` |
| `completionPercent` | `number` | Yes | 0-100 profile completeness score |
| `createdAt` | `timestamp` | Yes | Profile creation timestamp |
| `updatedAt` | `timestamp` | Yes | Last profile update timestamp |

---

### 2.3 `users/{uid}/reminders/{reminderId}`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `title` | `string` | Yes | Reminder title (max 100 chars) |
| `date` | `timestamp` | Yes | Reminder target date/time |
| `recurrence` | `string` | Yes | `none`, `daily`, `weekly`, `monthly`, `yearly` |
| `category` | `string` | Yes | `birthday`, `anniversary`, `promise`, `custom` |
| `notes` | `string` | No | Additional notes (max 500 chars) |
| `completed` | `boolean` | Yes | Whether reminder has been acted on |
| `snoozedUntil` | `timestamp` | No | Snooze until this time |
| `escalationSent` | `map` | Yes | `{ "7d": bool, "3d": bool, "1d": bool, "same": bool }` |
| `giftSuggest` | `boolean` | Yes | Whether to show gift suggestions |
| `partnerProfileId` | `string` | No | Link to associated partner profile |
| `createdAt` | `timestamp` | Yes | Creation timestamp |
| `updatedAt` | `timestamp` | Yes | Last update timestamp |

---

### 2.4 `users/{uid}/messages/{messageId}`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `mode` | `string` | Yes | `apology`, `romance`, `flirt`, `comfort`, `gratitude`, `custom` |
| `tone` | `string` | Yes | `sweet`, `formal`, `playful`, `poetic`, `casual` |
| `humor` | `string` | Yes | `none`, `light`, `sarcastic`, `witty` |
| `length` | `string` | Yes | `short`, `medium`, `long` |
| `language` | `string` | Yes | `en`, `ar`, `ms` |
| `generatedText` | `string` | Yes | The AI-generated message content |
| `modelUsed` | `string` | Yes | AI model ID (e.g. `claude-sonnet`, `grok-4.1`) |
| `rating` | `number` | No | User rating 1-5 |
| `favorited` | `boolean` | Yes | Whether user favorited this message |
| `partnerProfileId` | `string` | No | Partner context used for generation |
| `createdAt` | `timestamp` | Yes | Generation timestamp |

---

### 2.5 `users/{uid}/gifts/{giftId}`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `name` | `string` | Yes | Gift name/title |
| `category` | `string` | Yes | Category (e.g. `jewelry`, `tech`, `experience`, `handmade`) |
| `priceRange` | `map` | Yes | `{ min: number, max: number, currency: string }` |
| `reasoning` | `string` | Yes | AI explanation of why this gift fits |
| `partnerProfileId` | `string` | Yes | Link to partner profile used |
| `feedback` | `string` | No | `liked`, `disliked`, or `null` |
| `source` | `string` | No | Source URL or retailer name |
| `imageUrl` | `string` | No | Gift image URL |
| `createdAt` | `timestamp` | Yes | Recommendation timestamp |

---

### 2.6 `users/{uid}/sosSessions/{sessionId}`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `scenario` | `string` | Yes | User-described situation |
| `severity` | `string` | Yes | `low`, `medium`, `high`, `critical` |
| `coachingMessages` | `array<map>` | Yes | `[{ role: "ai"\|"user", text: string, timestamp: timestamp }]` |
| `resolution` | `string` | No | How the session concluded |
| `followUpActions` | `array<string>` | No | Suggested follow-up actions |
| `duration` | `number` | Yes | Session duration in seconds |
| `modelUsed` | `string` | Yes | AI model that handled the session |
| `partnerProfileId` | `string` | No | Partner context used |
| `createdAt` | `timestamp` | Yes | Session start timestamp |
| `endedAt` | `timestamp` | No | Session end timestamp |

---

### 2.7 `users/{uid}/gamification` (Single Document)

**Path:** `users/{uid}/gamification/stats`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `level` | `number` | Yes | Current user level (1+) |
| `xp` | `number` | Yes | Total XP earned |
| `currentStreak` | `number` | Yes | Current daily streak |
| `longestStreak` | `number` | Yes | All-time longest streak |
| `lastActiveDate` | `string` | Yes | `YYYY-MM-DD` format for streak calc |
| `badges` | `array<map>` | Yes | `[{ id: string, name: string, earnedAt: timestamp }]` |
| `weeklyStats` | `map` | Yes | `{ cardsCompleted: number, messagesGenerated: number, xpEarned: number }` |
| `monthlyStats` | `map` | Yes | `{ cardsCompleted: number, messagesGenerated: number, xpEarned: number, giftsGiven: number }` |

---

### 2.8 `users/{uid}/actionCards/{cardId}`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `type` | `string` | Yes | `SAY`, `DO`, `BUY`, `GO` |
| `title` | `string` | Yes | Card headline (max 80 chars) |
| `body` | `string` | Yes | Card detailed content |
| `context` | `string` | No | Why this card was generated |
| `difficulty` | `string` | Yes | `easy`, `medium`, `hard` |
| `status` | `string` | Yes | `pending`, `completed`, `skipped`, `saved` |
| `xpEarned` | `number` | Yes | XP awarded on completion (0 if pending) |
| `partnerProfileId` | `string` | No | Partner this card relates to |
| `templateId` | `string` | No | Ref to `metadata/actionCardTemplates` |
| `createdAt` | `timestamp` | Yes | Card generation timestamp |
| `completedAt` | `timestamp` | No | When user completed the card |

---

### 2.9 `users/{uid}/memories/{memoryId}`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `title` | `string` | Yes | Memory title (max 100 chars) |
| `content` | `string` | Yes | Memory text content |
| `category` | `string` | Yes | `story`, `joke`, `wish`, `milestone` |
| `date` | `timestamp` | No | Date associated with the memory |
| `tags` | `array<string>` | No | User-defined tags |
| `photoUrl` | `string` | No | Cloud Storage URL for attached photo |
| `sheSaid` | `boolean` | Yes | Whether this is something she said |
| `partnerProfileId` | `string` | No | Associated partner profile |
| `createdAt` | `timestamp` | Yes | Creation timestamp |
| `updatedAt` | `timestamp` | Yes | Last edit timestamp |

---

### 2.10 `users/{uid}/notifications/{notifId}`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `type` | `string` | Yes | `reminder`, `streak`, `actionCard`, `sos`, `system`, `promo` |
| `title` | `string` | Yes | Notification title |
| `body` | `string` | Yes | Notification body text |
| `read` | `boolean` | Yes | Whether user has read it |
| `data` | `map` | No | Payload: `{ route: string, entityId: string, entityType: string }` |
| `createdAt` | `timestamp` | Yes | Delivery timestamp |

---

### 2.11 Metadata Collections (Read-Only)

#### `metadata/zodiacProfiles`

Single document containing a map of all 12 signs.

| Field | Type | Description |
|-------|------|-------------|
| `signs` | `map<string, map>` | Keyed by lowercase sign name |
| `signs.{sign}.element` | `string` | `fire`, `earth`, `air`, `water` |
| `signs.{sign}.modality` | `string` | `cardinal`, `fixed`, `mutable` |
| `signs.{sign}.loveTraits` | `array<string>` | Key relationship traits |
| `signs.{sign}.communicationStyle` | `string` | How they prefer to communicate |
| `signs.{sign}.giftPreferences` | `array<string>` | Gift category affinities |
| `signs.{sign}.conflictStyle` | `string` | How they handle arguments |
| `signs.{sign}.romanticNeeds` | `array<string>` | What they need in romance |
| `updatedAt` | `timestamp` | Last content update |

#### `metadata/subscriptionPlans`

| Field | Type | Description |
|-------|------|-------------|
| `plans` | `map<string, map>` | Keyed by tier: `free`, `pro`, `legend` |
| `plans.{tier}.name` | `string` | Display name |
| `plans.{tier}.pricing` | `map` | `{ USD: number, SAR: number, MYR: number }` |
| `plans.{tier}.limits` | `map` | `{ aiMessages: number, sosSessions: number, actionCards: number, memories: number }` |
| `plans.{tier}.features` | `array<string>` | Feature list for paywall UI |
| `plans.{tier}.trialDays` | `number` | Free trial duration |
| `plans.{tier}.storeProductIds` | `map` | `{ ios: string, android: string }` |
| `updatedAt` | `timestamp` | Last pricing update |

#### `metadata/actionCardTemplates`

| Field | Type | Description |
|-------|------|-------------|
| `templates` | `array<map>` | Card template objects |
| `templates[].id` | `string` | Template ID |
| `templates[].type` | `string` | `SAY`, `DO`, `BUY`, `GO` |
| `templates[].titleTemplate` | `string` | Title with `{{placeholders}}` |
| `templates[].bodyTemplate` | `string` | Body with `{{placeholders}}` |
| `templates[].difficulty` | `string` | Default difficulty |
| `templates[].xpReward` | `number` | XP on completion |
| `templates[].tags` | `array<string>` | Content tags |
| `templates[].locale` | `array<string>` | Supported locales |
| `updatedAt` | `timestamp` | Last template update |

#### `metadata/giftCategories`

| Field | Type | Description |
|-------|------|-------------|
| `categories` | `array<map>` | Category definitions |
| `categories[].id` | `string` | Category ID |
| `categories[].name` | `map` | `{ en: string, ar: string, ms: string }` |
| `categories[].icon` | `string` | Icon identifier |
| `categories[].subcategories` | `array<string>` | Subcategory IDs |
| `categories[].priceRanges` | `array<map>` | `[{ label: string, min: number, max: number }]` |
| `updatedAt` | `timestamp` | Last update |

---

## 3. Firestore Security Rules

### `firestore.rules`

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    // ============================
    // HELPER FUNCTIONS
    // ============================

    function isAuthenticated() {
      return request.auth != null;
    }

    function isOwner(uid) {
      return isAuthenticated() && request.auth.uid == uid;
    }

    function isNotRateLimited() {
      return !('rateLimited' in request.auth.token) || request.auth.token.rateLimited != true;
    }

    function hasRequiredFields(fields) {
      return request.resource.data.keys().hasAll(fields);
    }

    function isValidString(field, minLen, maxLen) {
      return request.resource.data[field] is string
        && request.resource.data[field].size() >= minLen
        && request.resource.data[field].size() <= maxLen;
    }

    function isValidEnum(field, values) {
      return request.resource.data[field] is string
        && request.resource.data[field] in values;
    }

    function isValidTimestamp(field) {
      return request.resource.data[field] is timestamp;
    }

    // ============================
    // USER DOCUMENT
    // ============================

    match /users/{uid} {
      allow read: if isOwner(uid);
      allow create: if isOwner(uid)
        && hasRequiredFields(['uid', 'email', 'displayName', 'language', 'tier', 'onboardingComplete', 'settings', 'createdAt', 'lastActiveAt'])
        && isValidEnum('language', ['en', 'ar', 'ms'])
        && isValidEnum('tier', ['free', 'pro', 'legend'])
        && isValidString('displayName', 2, 50)
        && request.resource.data.uid == uid;
      allow update: if isOwner(uid)
        && isNotRateLimited()
        && (!request.resource.data.diff(resource.data).affectedKeys().hasAny(['uid', 'email', 'createdAt']))
        && (request.resource.data.language == resource.data.language || isValidEnum('language', ['en', 'ar', 'ms']))
        && (request.resource.data.tier == resource.data.tier || isValidEnum('tier', ['free', 'pro', 'legend']));
      allow delete: if false; // deletion handled by Cloud Functions

      // ============================
      // PARTNER PROFILES
      // ============================

      match /partnerProfiles/{profileId} {
        allow read: if isOwner(uid);
        allow create: if isOwner(uid)
          && isNotRateLimited()
          && hasRequiredFields(['name', 'relationshipStatus', 'completionPercent', 'createdAt', 'updatedAt'])
          && isValidString('name', 1, 50)
          && isValidEnum('relationshipStatus', ['dating', 'engaged', 'married', 'complicated', 'new']);
        allow update: if isOwner(uid)
          && isNotRateLimited()
          && isValidString('name', 1, 50);
        allow delete: if isOwner(uid);
      }

      // ============================
      // REMINDERS
      // ============================

      match /reminders/{reminderId} {
        allow read: if isOwner(uid);
        allow create: if isOwner(uid)
          && isNotRateLimited()
          && hasRequiredFields(['title', 'date', 'recurrence', 'category', 'completed', 'escalationSent', 'giftSuggest', 'createdAt', 'updatedAt'])
          && isValidString('title', 1, 100)
          && isValidEnum('recurrence', ['none', 'daily', 'weekly', 'monthly', 'yearly'])
          && isValidEnum('category', ['birthday', 'anniversary', 'promise', 'custom']);
        allow update: if isOwner(uid) && isNotRateLimited();
        allow delete: if isOwner(uid);
      }

      // ============================
      // MESSAGES
      // ============================

      match /messages/{messageId} {
        allow read: if isOwner(uid);
        allow create: if isOwner(uid)
          && isNotRateLimited()
          && hasRequiredFields(['mode', 'tone', 'humor', 'length', 'language', 'generatedText', 'modelUsed', 'favorited', 'createdAt'])
          && isValidEnum('mode', ['apology', 'romance', 'flirt', 'comfort', 'gratitude', 'custom'])
          && isValidEnum('language', ['en', 'ar', 'ms']);
        allow update: if isOwner(uid)
          && isNotRateLimited()
          && request.resource.data.diff(resource.data).affectedKeys().hasOnly(['rating', 'favorited']);
        allow delete: if isOwner(uid);
      }

      // ============================
      // GIFTS
      // ============================

      match /gifts/{giftId} {
        allow read: if isOwner(uid);
        allow create: if isOwner(uid)
          && isNotRateLimited()
          && hasRequiredFields(['name', 'category', 'priceRange', 'reasoning', 'partnerProfileId', 'createdAt']);
        allow update: if isOwner(uid)
          && isNotRateLimited()
          && request.resource.data.diff(resource.data).affectedKeys().hasOnly(['feedback']);
        allow delete: if isOwner(uid);
      }

      // ============================
      // SOS SESSIONS
      // ============================

      match /sosSessions/{sessionId} {
        allow read: if isOwner(uid);
        allow create: if isOwner(uid)
          && isNotRateLimited()
          && hasRequiredFields(['scenario', 'severity', 'coachingMessages', 'duration', 'modelUsed', 'createdAt'])
          && isValidEnum('severity', ['low', 'medium', 'high', 'critical']);
        allow update: if isOwner(uid)
          && isNotRateLimited();
        allow delete: if false; // SOS sessions are permanent
      }

      // ============================
      // GAMIFICATION
      // ============================

      match /gamification/{docId} {
        allow read: if isOwner(uid);
        allow write: if false; // only Cloud Functions update gamification
      }

      // ============================
      // ACTION CARDS
      // ============================

      match /actionCards/{cardId} {
        allow read: if isOwner(uid);
        allow create: if false; // only Cloud Functions create cards
        allow update: if isOwner(uid)
          && isNotRateLimited()
          && request.resource.data.diff(resource.data).affectedKeys().hasOnly(['status', 'completedAt']);
        allow delete: if false;
      }

      // ============================
      // MEMORIES
      // ============================

      match /memories/{memoryId} {
        allow read: if isOwner(uid);
        allow create: if isOwner(uid)
          && isNotRateLimited()
          && hasRequiredFields(['title', 'content', 'category', 'sheSaid', 'createdAt', 'updatedAt'])
          && isValidString('title', 1, 100)
          && isValidEnum('category', ['story', 'joke', 'wish', 'milestone']);
        allow update: if isOwner(uid) && isNotRateLimited();
        allow delete: if isOwner(uid);
      }

      // ============================
      // NOTIFICATIONS
      // ============================

      match /notifications/{notifId} {
        allow read: if isOwner(uid);
        allow create: if false; // only Cloud Functions create notifications
        allow update: if isOwner(uid)
          && request.resource.data.diff(resource.data).affectedKeys().hasOnly(['read']);
        allow delete: if isOwner(uid);
      }
    }

    // ============================
    // METADATA (READ-ONLY)
    // ============================

    match /metadata/{docId} {
      allow read: if isAuthenticated();
      allow write: if false; // admin SDK only
    }

    // ============================
    // CATCH-ALL DENY
    // ============================

    match /{document=**} {
      allow read, write: if false;
    }
  }
}
```

**Rate Limiting Strategy:** The `isNotRateLimited()` function checks a custom claim `rateLimited` set by Cloud Functions. The actual rate limiting logic runs in Redis (see Section 4). When a user exceeds 10 writes/minute, a Cloud Function sets `rateLimited: true` as a custom claim on their token. The claim auto-expires on next token refresh (1 hour max), but Cloud Functions proactively clear it after 60 seconds.

---

## 4. Redis Cache Schema

**Instance:** Redis 7.x on Cloud Memorystore (Standard tier, 1GB dev / 5GB prod)

| Key Pattern | TTL | Description |
|-------------|-----|-------------|
| `session:{uid}` | 24h | User session data: tier, language, fcmToken, settings hash |
| `user:profile:{uid}` | 300s | Cached user profile for GET /auth/profile |
| `rate:write:{uid}` | 60s | Sorted set of write timestamps; ZCARD for count check |
| `rate:api:{uid}:{endpoint}` | 60s | Per-endpoint rate limit counter (INCR + EXPIRE) |
| `rate:ip:{ip}:{endpoint}` | 60s | IP-based rate limit for unauthenticated endpoints |
| `ai:response:{hash}` | 1h | Cached AI response keyed by SHA-256 of (prompt+params+locale) |
| `ai:sos:{uid}:{sessionId}` | 2h | Active SOS session state for real-time coaching |
| `cards:daily:{uid}:{date}` | 24h | Today's generated action cards for the user |
| `cards:templates:{locale}` | 6h | Cached action card templates by locale |
| `gamification:{uid}` | 300s | Cached gamification stats (level, xp, streak) |
| `sub:{uid}` | 1h | Subscription status: tier, expiresAt, limits remaining |
| `sub:limits:{uid}:{month}` | 30d | Monthly usage counters: `{ aiMessages: n, sosSessions: n }` |
| `zodiac:{sign}` | 24h | Cached zodiac profile data per sign |
| `gift:categories:{locale}` | 6h | Cached gift categories for locale |
| `notif:unread:{uid}` | 300s | Unread notification count |
| `lock:cards:{uid}` | 30s | Distributed lock to prevent duplicate card generation |
| `lock:gamification:{uid}` | 10s | Lock for XP/streak atomic updates |

**Eviction Policy:** `allkeys-lru`

---

## 5. PostgreSQL Schema (Analytics + Billing)

**Instance:** Cloud SQL for PostgreSQL 15 (db-f1-micro dev / db-custom-2-8192 prod)

```sql
-- ============================================
-- EXTENSIONS
-- ============================================

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";

-- ============================================
-- ANALYTICS EVENTS
-- ============================================

CREATE TABLE analytics_events (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id         VARCHAR(128) NOT NULL,
    event_type      VARCHAR(64)  NOT NULL,
    event_data      JSONB        DEFAULT '{}',
    locale          VARCHAR(5)   NOT NULL DEFAULT 'en',
    client_version  VARCHAR(16),
    platform        VARCHAR(10),
    session_id      VARCHAR(64),
    created_at      TIMESTAMPTZ  NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_analytics_user_id      ON analytics_events (user_id);
CREATE INDEX idx_analytics_event_type   ON analytics_events (event_type);
CREATE INDEX idx_analytics_created_at   ON analytics_events (created_at);
CREATE INDEX idx_analytics_locale       ON analytics_events (locale);
CREATE INDEX idx_analytics_composite    ON analytics_events (user_id, event_type, created_at);
CREATE INDEX idx_analytics_event_data   ON analytics_events USING GIN (event_data);

-- Partitioning by month for query performance
CREATE TABLE analytics_events_y2026m01 PARTITION OF analytics_events
    FOR VALUES FROM ('2026-01-01') TO ('2026-02-01');
CREATE TABLE analytics_events_y2026m02 PARTITION OF analytics_events
    FOR VALUES FROM ('2026-02-01') TO ('2026-03-01');
CREATE TABLE analytics_events_y2026m03 PARTITION OF analytics_events
    FOR VALUES FROM ('2026-03-01') TO ('2026-04-01');
-- (continue monthly partitions via cron job / Cloud Function)

-- ============================================
-- SUBSCRIPTION HISTORY
-- ============================================

CREATE TABLE subscription_history (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id         VARCHAR(128) NOT NULL,
    plan            VARCHAR(20)  NOT NULL CHECK (plan IN ('free', 'pro', 'legend')),
    amount          DECIMAL(10,2) NOT NULL DEFAULT 0,
    currency        VARCHAR(3)   NOT NULL DEFAULT 'USD',
    payment_provider VARCHAR(20) CHECK (payment_provider IN ('stripe', 'apple', 'google')),
    store_txn_id    VARCHAR(255),
    started_at      TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    ended_at        TIMESTAMPTZ,
    status          VARCHAR(20)  NOT NULL CHECK (status IN ('active', 'cancelled', 'expired', 'refunded', 'trial')),
    cancellation_reason TEXT,
    created_at      TIMESTAMPTZ  NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_sub_user_id    ON subscription_history (user_id);
CREATE INDEX idx_sub_status     ON subscription_history (status);
CREATE INDEX idx_sub_plan       ON subscription_history (plan);
CREATE INDEX idx_sub_started_at ON subscription_history (started_at);
CREATE INDEX idx_sub_composite  ON subscription_history (user_id, status, started_at);

-- ============================================
-- AI USAGE LOG
-- ============================================

CREATE TABLE ai_usage_log (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id         VARCHAR(128) NOT NULL,
    model           VARCHAR(64)  NOT NULL,
    tokens_in       INTEGER      NOT NULL DEFAULT 0,
    tokens_out      INTEGER      NOT NULL DEFAULT 0,
    cost_usd        DECIMAL(10,6) NOT NULL DEFAULT 0,
    locale          VARCHAR(5)   NOT NULL DEFAULT 'en',
    endpoint        VARCHAR(128) NOT NULL,
    prompt_hash     VARCHAR(64),
    cache_hit       BOOLEAN      NOT NULL DEFAULT FALSE,
    latency_ms      INTEGER,
    status          VARCHAR(20)  NOT NULL DEFAULT 'success' CHECK (status IN ('success', 'error', 'timeout', 'filtered')),
    error_code      VARCHAR(64),
    created_at      TIMESTAMPTZ  NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_ai_user_id     ON ai_usage_log (user_id);
CREATE INDEX idx_ai_model       ON ai_usage_log (model);
CREATE INDEX idx_ai_endpoint    ON ai_usage_log (endpoint);
CREATE INDEX idx_ai_created_at  ON ai_usage_log (created_at);
CREATE INDEX idx_ai_composite   ON ai_usage_log (user_id, model, created_at);
CREATE INDEX idx_ai_cost        ON ai_usage_log (cost_usd, created_at);

-- ============================================
-- NOTIFICATION LOG
-- ============================================

CREATE TABLE notification_log (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id         VARCHAR(128) NOT NULL,
    type            VARCHAR(32)  NOT NULL,
    channel         VARCHAR(10)  NOT NULL CHECK (channel IN ('fcm', 'apns', 'sms', 'email')),
    status          VARCHAR(20)  NOT NULL CHECK (status IN ('sent', 'delivered', 'failed', 'bounced', 'opened')),
    locale          VARCHAR(5)   NOT NULL DEFAULT 'en',
    title           VARCHAR(255),
    error_message   TEXT,
    fcm_message_id  VARCHAR(255),
    created_at      TIMESTAMPTZ  NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_notif_user_id    ON notification_log (user_id);
CREATE INDEX idx_notif_type       ON notification_log (type);
CREATE INDEX idx_notif_status     ON notification_log (status);
CREATE INDEX idx_notif_channel    ON notification_log (channel);
CREATE INDEX idx_notif_created_at ON notification_log (created_at);
CREATE INDEX idx_notif_composite  ON notification_log (user_id, type, created_at);

-- ============================================
-- AGGREGATION VIEWS
-- ============================================

CREATE MATERIALIZED VIEW mv_daily_ai_cost AS
SELECT
    DATE(created_at) AS day,
    model,
    locale,
    COUNT(*)           AS request_count,
    SUM(tokens_in)     AS total_tokens_in,
    SUM(tokens_out)    AS total_tokens_out,
    SUM(cost_usd)      AS total_cost,
    AVG(latency_ms)    AS avg_latency_ms,
    SUM(CASE WHEN cache_hit THEN 1 ELSE 0 END) AS cache_hits
FROM ai_usage_log
GROUP BY DATE(created_at), model, locale;

CREATE MATERIALIZED VIEW mv_monthly_revenue AS
SELECT
    DATE_TRUNC('month', started_at) AS month,
    plan,
    currency,
    COUNT(*)          AS subscriptions,
    SUM(amount)       AS total_revenue
FROM subscription_history
WHERE status IN ('active', 'cancelled')
GROUP BY DATE_TRUNC('month', started_at), plan, currency;

-- Refresh schedule: daily via Cloud Scheduler -> Cloud Function
-- REFRESH MATERIALIZED VIEW CONCURRENTLY mv_daily_ai_cost;
-- REFRESH MATERIALIZED VIEW CONCURRENTLY mv_monthly_revenue;
```

**Note on Partitioning:** The `analytics_events` table definition above should use `PARTITION BY RANGE (created_at)` on the base table. Updated CREATE:

```sql
-- Replace the base CREATE TABLE with:
CREATE TABLE analytics_events (
    id              UUID         DEFAULT uuid_generate_v4(),
    user_id         VARCHAR(128) NOT NULL,
    event_type      VARCHAR(64)  NOT NULL,
    event_data      JSONB        DEFAULT '{}',
    locale          VARCHAR(5)   NOT NULL DEFAULT 'en',
    client_version  VARCHAR(16),
    platform        VARCHAR(10),
    session_id      VARCHAR(64),
    created_at      TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    PRIMARY KEY (id, created_at)
) PARTITION BY RANGE (created_at);
```

---

## 6. Environment Configuration

### `.env.example`

```bash
# ============================================
# LOLO Backend Environment Configuration
# ============================================
# Copy to .env and fill in values. NEVER commit .env to git.

# --- Firebase ---
FIREBASE_PROJECT_ID=lolo-app-dev
FIREBASE_STORAGE_BUCKET=lolo-app-dev.appspot.com
FIREBASE_DATABASE_URL=https://lolo-app-dev.firebaseio.com
GOOGLE_APPLICATION_CREDENTIALS=./service-account.json

# --- Redis (Cloud Memorystore) ---
REDIS_HOST=10.0.0.3
REDIS_PORT=6379
REDIS_PASSWORD=
REDIS_DB=0
REDIS_TLS_ENABLED=false

# --- PostgreSQL (Cloud SQL) ---
POSTGRES_HOST=127.0.0.1
POSTGRES_PORT=5432
POSTGRES_DB=lolo_analytics
POSTGRES_USER=lolo_backend
POSTGRES_PASSWORD=
POSTGRES_SSL_MODE=prefer
POSTGRES_MAX_CONNECTIONS=20

# --- AI Provider Keys ---
ANTHROPIC_API_KEY=sk-ant-xxxxx
OPENAI_API_KEY=sk-xxxxx
GOOGLE_AI_API_KEY=AIza-xxxxx
XAI_API_KEY=xai-xxxxx

# --- AI Router Config ---
AI_DEFAULT_MODEL=claude-sonnet
AI_MAX_RETRIES=2
AI_TIMEOUT_MS=30000
AI_COST_ALERT_THRESHOLD_USD=100

# --- Vector Database (Pinecone) ---
PINECONE_API_KEY=xxxxx
PINECONE_ENVIRONMENT=us-east1-gcp
PINECONE_INDEX_NAME=lolo-personality

# --- Push Notifications ---
FCM_SERVER_KEY=AAAAxxxxx
APNS_KEY_ID=
APNS_TEAM_ID=
APNS_BUNDLE_ID=com.loloapp.lolo

# --- Subscription / Payments ---
STRIPE_SECRET_KEY=sk_test_xxxxx
STRIPE_WEBHOOK_SECRET=whsec_xxxxx
APPLE_SHARED_SECRET=xxxxx
GOOGLE_PLAY_SERVICE_ACCOUNT=./play-service-account.json

# --- Rate Limiting ---
RATE_LIMIT_WRITES_PER_MIN=10
RATE_LIMIT_AI_FREE_PER_MONTH=10
RATE_LIMIT_AI_PRO_PER_MONTH=100
RATE_LIMIT_SOS_FREE_PER_MONTH=2
RATE_LIMIT_SOS_PRO_PER_MONTH=10

# --- App Config ---
NODE_ENV=development
LOG_LEVEL=debug
CORS_ORIGIN=http://localhost:4000
API_VERSION=v1

# --- Emulators (dev only) ---
FIRESTORE_EMULATOR_HOST=localhost:8080
FIREBASE_AUTH_EMULATOR_HOST=localhost:9099
FIREBASE_STORAGE_EMULATOR_HOST=localhost:9199
PUBSUB_EMULATOR_HOST=localhost:8085
```

### `storage.rules`

```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {

    function isAuthenticated() {
      return request.auth != null;
    }

    function isOwner(uid) {
      return isAuthenticated() && request.auth.uid == uid;
    }

    function isImage() {
      return request.resource.contentType.matches('image/.*');
    }

    function isUnder5MB() {
      return request.resource.size < 5 * 1024 * 1024;
    }

    // User profile photos
    match /users/{uid}/profile/{fileName} {
      allow read: if isAuthenticated();
      allow write: if isOwner(uid) && isImage() && isUnder5MB();
    }

    // Memory photos
    match /users/{uid}/memories/{memoryId}/{fileName} {
      allow read: if isOwner(uid);
      allow write: if isOwner(uid) && isImage() && isUnder5MB();
    }

    // Deny everything else
    match /{allPaths=**} {
      allow read, write: if false;
    }
  }
}
```

---

## Appendix: Collection Size Estimates

| Collection | Docs/User (avg) | Doc Size (avg) | Growth Rate |
|------------|-----------------|----------------|-------------|
| `users` | 1 | 1 KB | Linear with signups |
| `partnerProfiles` | 1-2 | 2 KB | Stable |
| `reminders` | 5-15 | 0.5 KB | Slow growth |
| `messages` | 10-50/month | 1 KB | High for active users |
| `gifts` | 5-10/month | 0.8 KB | Moderate |
| `sosSessions` | 1-3/month | 3 KB | Low frequency |
| `gamification` | 1 (singleton) | 1.5 KB | Single doc, frequent updates |
| `actionCards` | 3-10/day | 0.5 KB | High volume, prune after 90 days |
| `memories` | 5-30 total | 1 KB | Slow, tier-limited |
| `notifications` | 5-10/week | 0.3 KB | Prune after 30 days |

**Data Retention Policy:**
- Notifications: auto-delete after 30 days (Cloud Scheduler + Cloud Function)
- Action cards with `status: skipped`: archive after 90 days
- SOS sessions: retained permanently for user reference
- Analytics events (PostgreSQL): retained 24 months, then archived to Cloud Storage
