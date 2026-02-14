# LOLO API Contracts -- Definitive Reference

**Prepared by:** Omar Al-Rashidi, Tech Lead & Senior Flutter Developer
**Date:** February 14, 2026
**Document Version:** 1.0
**Classification:** Internal -- Confidential
**Base URL:** `https://us-central1-lolo-app.cloudfunctions.net/api/v1`

---

## Table of Contents

1. [Global Conventions](#global-conventions)
2. [Module 1: Auth & Account](#module-1-auth--account)
3. [Module 2: Her Profile Engine](#module-2-her-profile-engine)
4. [Module 3: Smart Reminders](#module-3-smart-reminders)
5. [Module 4: AI Message Generator](#module-4-ai-message-generator)
6. [Module 5: Gift Recommendation Engine](#module-5-gift-recommendation-engine)
7. [Module 6: SOS Mode](#module-6-sos-mode)
8. [Module 7: Gamification](#module-7-gamification)
9. [Module 8: Smart Action Cards](#module-8-smart-action-cards)
10. [Module 9: Memory Vault](#module-9-memory-vault)
11. [Module 10: Settings & Subscriptions](#module-10-settings--subscriptions)
12. [Module 11: Notifications](#module-11-notifications)
13. [Module 12: AI Router (Internal)](#module-12-ai-router-internal)

---

## Global Conventions

### Authentication

All endpoints (except `POST /auth/register`, `POST /auth/login`, `POST /auth/social`) require a Firebase Auth ID token:

```
Authorization: Bearer <firebase_id_token>
```

### Standard Request Headers

| Header | Required | Values | Description |
|--------|----------|--------|-------------|
| `Content-Type` | Yes | `application/json` | All request bodies are JSON |
| `Authorization` | Yes* | `Bearer <token>` | Firebase ID token (*except public auth endpoints) |
| `Accept-Language` | No | `en`, `ar`, `ms` | Locale for response content. Defaults to user profile language |
| `X-Client-Version` | No | `1.0.0` | Flutter app version for compatibility checks |
| `X-Platform` | No | `ios`, `android` | Client platform |
| `X-Request-Id` | No | UUID v4 | Client-generated request ID for tracing |

### Standard Error Response

All errors follow this structure:

```json
{
  "error": {
    "code": "ERROR_CODE",
    "message": "Human-readable message",
    "details": {}
  }
}
```

### Common Error Codes

| HTTP Status | Code | Description |
|-------------|------|-------------|
| 400 | `INVALID_REQUEST` | Malformed request body or missing required fields |
| 401 | `UNAUTHENTICATED` | Missing or invalid auth token |
| 403 | `PERMISSION_DENIED` | Valid token but insufficient permissions |
| 403 | `TIER_LIMIT_EXCEEDED` | Feature not available on user's subscription tier |
| 404 | `NOT_FOUND` | Requested resource does not exist |
| 409 | `ALREADY_EXISTS` | Resource already exists (duplicate) |
| 429 | `RATE_LIMITED` | Too many requests; retry after `Retry-After` header seconds |
| 500 | `INTERNAL_ERROR` | Server error |
| 503 | `SERVICE_UNAVAILABLE` | Downstream service (AI provider, etc.) unavailable |

### Cursor-Based Pagination

Paginated endpoints accept:

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `limit` | integer | 20 | Items per page (max 50) |
| `lastDocId` | string | null | ID of last item from previous page |

Paginated responses include:

```json
{
  "data": [],
  "pagination": {
    "hasMore": true,
    "lastDocId": "abc123",
    "totalCount": 150
  }
}
```

### Subscription Tiers

| Tier | Monthly Price | AI Messages | SOS Sessions | Action Cards | Memories |
|------|--------------|-------------|--------------|--------------|----------|
| Free | $0 | 10/month | 2/month | 3/day | 20 total |
| Pro | $9.99 | 100/month | 10/month | 10/day | 200 total |
| Legend | $19.99 | Unlimited | Unlimited | Unlimited | Unlimited |

---

## Module 1: Auth & Account

### 1.1 POST /auth/register

**Description:** Create a new account with email and password.

**Auth required:** No

**Rate limit:** 5 requests/minute per IP

**Request Headers:**

| Header | Required | Value |
|--------|----------|-------|
| `Content-Type` | Yes | `application/json` |
| `Accept-Language` | No | `en`, `ar`, `ms` |

**Request Body:**

```json
{
  "email": "string (required, valid email, max 255 chars)",
  "password": "string (required, min 8 chars, must contain uppercase + lowercase + number)",
  "displayName": "string (required, 2-50 chars)",
  "language": "string (required, enum: 'en' | 'ar' | 'ms')"
}
```

**Success Response:** `201 Created`

```json
{
  "data": {
    "uid": "string (Firebase UID)",
    "email": "string",
    "displayName": "string",
    "language": "string",
    "tier": "free",
    "idToken": "string (Firebase ID token)",
    "refreshToken": "string (Firebase refresh token)",
    "expiresIn": 3600,
    "onboardingComplete": false,
    "createdAt": "string (ISO 8601)"
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 400 | `INVALID_REQUEST` | Missing or invalid fields |
| 400 | `WEAK_PASSWORD` | Password does not meet complexity requirements |
| 409 | `EMAIL_ALREADY_EXISTS` | Account with this email already exists |
| 429 | `RATE_LIMITED` | Too many registration attempts |

**Caching:** None

**Tier restrictions:** None

---

### 1.2 POST /auth/login

**Description:** Sign in with email and password.

**Auth required:** No

**Rate limit:** 10 requests/minute per IP

**Request Headers:**

| Header | Required | Value |
|--------|----------|-------|
| `Content-Type` | Yes | `application/json` |

**Request Body:**

```json
{
  "email": "string (required)",
  "password": "string (required)"
}
```

**Success Response:** `200 OK`

```json
{
  "data": {
    "uid": "string",
    "email": "string",
    "displayName": "string",
    "language": "string",
    "tier": "string (enum: 'free' | 'pro' | 'legend')",
    "idToken": "string",
    "refreshToken": "string",
    "expiresIn": 3600,
    "onboardingComplete": true,
    "lastLoginAt": "string (ISO 8601)"
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 400 | `INVALID_REQUEST` | Missing email or password |
| 401 | `INVALID_CREDENTIALS` | Wrong email or password |
| 403 | `ACCOUNT_DISABLED` | Account has been disabled |
| 429 | `RATE_LIMITED` | Too many login attempts |

**Caching:** None

**Tier restrictions:** None

---

### 1.3 POST /auth/social

**Description:** Sign in or register with Google or Apple Sign-In. Creates account on first use.

**Auth required:** No

**Rate limit:** 10 requests/minute per IP

**Request Headers:**

| Header | Required | Value |
|--------|----------|-------|
| `Content-Type` | Yes | `application/json` |

**Request Body:**

```json
{
  "provider": "string (required, enum: 'google' | 'apple')",
  "idToken": "string (required, OAuth ID token from provider)",
  "nonce": "string (required for Apple, SHA-256 nonce)",
  "language": "string (optional, enum: 'en' | 'ar' | 'ms', default: 'en')"
}
```

**Success Response:** `200 OK`

```json
{
  "data": {
    "uid": "string",
    "email": "string",
    "displayName": "string",
    "language": "string",
    "tier": "string",
    "idToken": "string",
    "refreshToken": "string",
    "expiresIn": 3600,
    "isNewUser": true,
    "onboardingComplete": false,
    "createdAt": "string (ISO 8601)"
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 400 | `INVALID_REQUEST` | Missing provider or idToken |
| 400 | `INVALID_PROVIDER` | Unsupported provider |
| 401 | `INVALID_SOCIAL_TOKEN` | OAuth token invalid or expired |
| 409 | `EMAIL_ALREADY_EXISTS` | Email linked to different auth method |
| 429 | `RATE_LIMITED` | Too many attempts |

**Caching:** None

**Tier restrictions:** None

---

### 1.4 POST /auth/refresh-token

**Description:** Exchange a refresh token for a new ID token.

**Auth required:** No (uses refresh token instead)

**Rate limit:** 20 requests/minute per user

**Request Body:**

```json
{
  "refreshToken": "string (required)"
}
```

**Success Response:** `200 OK`

```json
{
  "data": {
    "idToken": "string",
    "refreshToken": "string",
    "expiresIn": 3600
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 400 | `INVALID_REQUEST` | Missing refresh token |
| 401 | `INVALID_REFRESH_TOKEN` | Token expired or revoked |
| 403 | `ACCOUNT_DISABLED` | Account disabled |

**Caching:** None

**Tier restrictions:** None

---

### 1.5 DELETE /auth/account

**Description:** Permanently delete user account and all associated data (GDPR/privacy compliance). Triggers cascading deletion of profiles, memories, messages, and settings.

**Auth required:** Yes

**Rate limit:** 1 request/minute per user

**Request Headers:**

| Header | Required | Value |
|--------|----------|-------|
| `Authorization` | Yes | `Bearer <token>` |
| `Content-Type` | Yes | `application/json` |

**Request Body:**

```json
{
  "confirmationPhrase": "string (required, must be 'DELETE MY ACCOUNT')",
  "reason": "string (optional, max 500 chars)"
}
```

**Success Response:** `200 OK`

```json
{
  "data": {
    "message": "Account scheduled for deletion",
    "deletionScheduledAt": "string (ISO 8601)",
    "gracePeriodEnds": "string (ISO 8601, 30 days from now)",
    "canRecover": true
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 400 | `INVALID_CONFIRMATION` | Confirmation phrase does not match |
| 401 | `UNAUTHENTICATED` | Invalid token |

**Caching:** None

**Tier restrictions:** None

---

### 1.6 GET /auth/profile

**Description:** Get the authenticated user's profile.

**Auth required:** Yes

**Rate limit:** 30 requests/minute per user

**Request Headers:**

| Header | Required | Value |
|--------|----------|-------|
| `Authorization` | Yes | `Bearer <token>` |

**Request Body:** None

**Success Response:** `200 OK`

```json
{
  "data": {
    "uid": "string",
    "email": "string",
    "displayName": "string",
    "language": "string",
    "tier": "string (enum: 'free' | 'pro' | 'legend')",
    "onboardingComplete": true,
    "profilePhotoUrl": "string | null",
    "createdAt": "string (ISO 8601)",
    "lastLoginAt": "string (ISO 8601)",
    "stats": {
      "messagesGenerated": 42,
      "actionCardsCompleted": 15,
      "currentStreak": 7,
      "memoriesCount": 12
    }
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 401 | `UNAUTHENTICATED` | Invalid token |
| 404 | `NOT_FOUND` | User profile not found |

**Caching:** Redis, TTL 300s, key: `user:profile:{uid}`

**Tier restrictions:** None

---

### 1.7 PUT /auth/profile

**Description:** Update user profile fields (display name, photo).

**Auth required:** Yes

**Rate limit:** 10 requests/minute per user

**Request Body:**

```json
{
  "displayName": "string (optional, 2-50 chars)",
  "profilePhotoUrl": "string (optional, valid URL)"
}
```

**Success Response:** `200 OK`

```json
{
  "data": {
    "uid": "string",
    "displayName": "string",
    "profilePhotoUrl": "string | null",
    "updatedAt": "string (ISO 8601)"
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 400 | `INVALID_REQUEST` | Validation errors |
| 401 | `UNAUTHENTICATED` | Invalid token |

**Caching:** Invalidates `user:profile:{uid}`

**Tier restrictions:** None

---

### 1.8 PUT /auth/language

**Description:** Change the user's preferred language. Affects all AI-generated content, notifications, and UI strings returned by the API.

**Auth required:** Yes

**Rate limit:** 5 requests/minute per user

**Request Body:**

```json
{
  "language": "string (required, enum: 'en' | 'ar' | 'ms')"
}
```

**Success Response:** `200 OK`

```json
{
  "data": {
    "uid": "string",
    "language": "string",
    "updatedAt": "string (ISO 8601)"
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 400 | `INVALID_LANGUAGE` | Unsupported language code |
| 401 | `UNAUTHENTICATED` | Invalid token |

**Caching:** Invalidates `user:profile:{uid}`, invalidates all locale-dependent caches for user

**Tier restrictions:** None

---

## Module 2: Her Profile Engine

### 2.1 POST /profiles

**Description:** Create a partner profile. Each user can have exactly one active partner profile.

**Auth required:** Yes

**Rate limit:** 5 requests/minute per user

**Request Body:**

```json
{
  "name": "string (required, 1-100 chars)",
  "birthday": "string (optional, ISO 8601 date, e.g. '1995-03-15')",
  "zodiacSign": "string (optional, enum: 'aries' | 'taurus' | 'gemini' | 'cancer' | 'leo' | 'virgo' | 'libra' | 'scorpio' | 'sagittarius' | 'capricorn' | 'aquarius' | 'pisces')",
  "loveLanguage": "string (optional, enum: 'words' | 'acts' | 'gifts' | 'time' | 'touch')",
  "communicationStyle": "string (optional, enum: 'direct' | 'indirect' | 'mixed')",
  "relationshipStatus": "string (required, enum: 'dating' | 'engaged' | 'married')",
  "anniversaryDate": "string (optional, ISO 8601 date)",
  "photoUrl": "string (optional, valid URL)"
}
```

**Success Response:** `201 Created`

```json
{
  "data": {
    "id": "string (Firestore document ID)",
    "userId": "string",
    "name": "string",
    "birthday": "string | null",
    "zodiacSign": "string | null",
    "loveLanguage": "string | null",
    "communicationStyle": "string | null",
    "relationshipStatus": "string",
    "anniversaryDate": "string | null",
    "photoUrl": "string | null",
    "profileCompletionPercent": 35,
    "createdAt": "string (ISO 8601)",
    "updatedAt": "string (ISO 8601)"
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 400 | `INVALID_REQUEST` | Missing name or invalid fields |
| 401 | `UNAUTHENTICATED` | Invalid token |
| 409 | `PROFILE_ALREADY_EXISTS` | User already has a partner profile |

**Caching:** None on create

**Tier restrictions:** None

---

### 2.2 GET /profiles/:id

**Description:** Get a partner profile by ID. Users can only access their own profiles.

**Auth required:** Yes

**Rate limit:** 30 requests/minute per user

**Success Response:** `200 OK`

```json
{
  "data": {
    "id": "string",
    "userId": "string",
    "name": "string",
    "birthday": "string | null",
    "zodiacSign": "string | null",
    "zodiacTraits": {
      "personality": ["string"],
      "communicationTips": ["string"],
      "emotionalNeeds": ["string"],
      "conflictStyle": "string",
      "giftPreferences": ["string"]
    },
    "loveLanguage": "string | null",
    "communicationStyle": "string | null",
    "relationshipStatus": "string",
    "anniversaryDate": "string | null",
    "photoUrl": "string | null",
    "preferences": {
      "favorites": {
        "flowers": ["string"],
        "food": ["string"],
        "music": ["string"],
        "movies": ["string"],
        "brands": ["string"],
        "colors": ["string"]
      },
      "dislikes": ["string"],
      "hobbies": ["string"],
      "stressCoping": "string | null",
      "notes": "string | null"
    },
    "culturalContext": {
      "background": "string | null",
      "religiousObservance": "string | null",
      "dialect": "string | null"
    },
    "profileCompletionPercent": 72,
    "createdAt": "string (ISO 8601)",
    "updatedAt": "string (ISO 8601)"
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 401 | `UNAUTHENTICATED` | Invalid token |
| 403 | `PERMISSION_DENIED` | Profile belongs to another user |
| 404 | `NOT_FOUND` | Profile does not exist |

**Caching:** Redis, TTL 600s, key: `profile:{id}`

**Tier restrictions:** None

---

### 2.3 PUT /profiles/:id

**Description:** Update partner profile fields. Partial updates supported; only include fields to change.

**Auth required:** Yes

**Rate limit:** 10 requests/minute per user

**Request Body:**

```json
{
  "name": "string (optional, 1-100 chars)",
  "birthday": "string (optional, ISO 8601 date)",
  "zodiacSign": "string (optional, zodiac enum)",
  "loveLanguage": "string (optional, love language enum)",
  "communicationStyle": "string (optional, enum: 'direct' | 'indirect' | 'mixed')",
  "relationshipStatus": "string (optional, enum: 'dating' | 'engaged' | 'married')",
  "anniversaryDate": "string (optional, ISO 8601 date)",
  "photoUrl": "string (optional, valid URL)"
}
```

**Success Response:** `200 OK`

```json
{
  "data": {
    "id": "string",
    "name": "string",
    "profileCompletionPercent": 72,
    "updatedAt": "string (ISO 8601)"
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 400 | `INVALID_REQUEST` | Invalid field values |
| 401 | `UNAUTHENTICATED` | Invalid token |
| 403 | `PERMISSION_DENIED` | Not the owner |
| 404 | `NOT_FOUND` | Profile not found |

**Caching:** Invalidates `profile:{id}`

**Tier restrictions:** None

---

### 2.4 DELETE /profiles/:id

**Description:** Delete a partner profile and all associated personalization data.

**Auth required:** Yes

**Rate limit:** 2 requests/minute per user

**Request Body:** None

**Success Response:** `200 OK`

```json
{
  "data": {
    "message": "Profile deleted successfully",
    "deletedAt": "string (ISO 8601)"
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 401 | `UNAUTHENTICATED` | Invalid token |
| 403 | `PERMISSION_DENIED` | Not the owner |
| 404 | `NOT_FOUND` | Profile not found |

**Caching:** Invalidates `profile:{id}`

**Tier restrictions:** None

---

### 2.5 GET /profiles/:id/zodiac-defaults

**Description:** Get default personality traits, communication tips, and emotional needs for a zodiac sign. Used to pre-populate profile fields when user selects a zodiac sign.

**Auth required:** Yes

**Rate limit:** 20 requests/minute per user

**Query Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `sign` | string | Yes | Zodiac sign enum value |

**Success Response:** `200 OK`

```json
{
  "data": {
    "sign": "scorpio",
    "element": "water",
    "modality": "fixed",
    "rulingPlanet": "Pluto",
    "personality": [
      "Intensely loyal",
      "Deeply emotional but guards vulnerability",
      "Values trust above everything"
    ],
    "communicationTips": [
      "Be direct -- she hates guessing games",
      "Never dismiss her feelings as overreacting",
      "Match her emotional depth in conversations"
    ],
    "emotionalNeeds": [
      "Complete honesty, even when it is hard",
      "Demonstrate loyalty through actions",
      "Respect her need for occasional solitude"
    ],
    "conflictStyle": "Goes silent, then erupts. Needs space first, then a deep honest conversation.",
    "giftPreferences": [
      "Meaningful and personal over expensive",
      "Experiences that create emotional bonding",
      "Handwritten letters or custom jewelry"
    ],
    "loveLanguageAffinity": "time",
    "bestApproachDuring": {
      "stress": "Give space, then offer presence without pressure",
      "sadness": "Hold her. Silence is fine. Do not try to fix it.",
      "anger": "Do not argue back. Wait. Then validate her perspective."
    }
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 400 | `INVALID_ZODIAC_SIGN` | Invalid sign value |
| 401 | `UNAUTHENTICATED` | Invalid token |

**Caching:** Redis, TTL 86400s (24h), key: `zodiac:defaults:{sign}:{locale}`

**Tier restrictions:** None

---

### 2.6 PUT /profiles/:id/preferences

**Description:** Update partner preferences (favorites, dislikes, hobbies). Feeds into Gift Engine and Action Card personalization.

**Auth required:** Yes

**Rate limit:** 10 requests/minute per user

**Request Body:**

```json
{
  "favorites": {
    "flowers": ["string (optional, array)"],
    "food": ["string (optional, array)"],
    "music": ["string (optional, array)"],
    "movies": ["string (optional, array)"],
    "brands": ["string (optional, array)"],
    "colors": ["string (optional, array)"]
  },
  "dislikes": ["string (optional, array, max 50 items)"],
  "hobbies": ["string (optional, array, max 30 items)"],
  "stressCoping": "string (optional, max 500 chars)",
  "notes": "string (optional, max 2000 chars)"
}
```

**Success Response:** `200 OK`

```json
{
  "data": {
    "id": "string",
    "preferences": { "...updated preferences object..." },
    "profileCompletionPercent": 85,
    "updatedAt": "string (ISO 8601)"
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 400 | `INVALID_REQUEST` | Array exceeds max items or invalid data |
| 401 | `UNAUTHENTICATED` | Invalid token |
| 403 | `PERMISSION_DENIED` | Not the owner |
| 404 | `NOT_FOUND` | Profile not found |

**Caching:** Invalidates `profile:{id}`

**Tier restrictions:** None

---

### 2.7 PUT /profiles/:id/cultural-context

**Description:** Update cultural background and religious observance settings. Affects AI tone during religious periods and filters culturally inappropriate content.

**Auth required:** Yes

**Rate limit:** 10 requests/minute per user

**Request Body:**

```json
{
  "background": "string (optional, enum: 'gulf_arab' | 'levantine' | 'egyptian' | 'north_african' | 'malay' | 'western' | 'south_asian' | 'east_asian' | 'other')",
  "religiousObservance": "string (optional, enum: 'high' | 'moderate' | 'low' | 'secular')",
  "dialect": "string (optional, enum: 'msa' | 'gulf' | 'egyptian' | 'levantine')"
}
```

**Success Response:** `200 OK`

```json
{
  "data": {
    "id": "string",
    "culturalContext": {
      "background": "gulf_arab",
      "religiousObservance": "high",
      "dialect": "gulf"
    },
    "autoAddedHolidays": [
      { "name": "Eid al-Fitr", "date": "2026-03-20" },
      { "name": "Eid al-Adha", "date": "2026-05-27" },
      { "name": "Ramadan Start", "date": "2026-02-18" }
    ],
    "updatedAt": "string (ISO 8601)"
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 400 | `INVALID_REQUEST` | Invalid enum values |
| 401 | `UNAUTHENTICATED` | Invalid token |
| 403 | `PERMISSION_DENIED` | Not the owner |
| 404 | `NOT_FOUND` | Profile not found |

**Caching:** Invalidates `profile:{id}`

**Tier restrictions:** None

---

## Module 3: Smart Reminders

### 3.1 GET /reminders

**Description:** List all reminders for the authenticated user with optional filters.

**Auth required:** Yes

**Rate limit:** 30 requests/minute per user

**Query Parameters:**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `type` | string | No | all | Filter: `birthday`, `anniversary`, `islamic_holiday`, `cultural`, `custom`, `promise` |
| `status` | string | No | `active` | Filter: `active`, `completed`, `snoozed`, `all` |
| `limit` | integer | No | 20 | Max 50 |
| `lastDocId` | string | No | null | Cursor for pagination |

**Success Response:** `200 OK`

```json
{
  "data": [
    {
      "id": "string",
      "userId": "string",
      "title": "string",
      "description": "string | null",
      "type": "string (enum: 'birthday' | 'anniversary' | 'islamic_holiday' | 'cultural' | 'custom' | 'promise')",
      "date": "string (ISO 8601 date)",
      "time": "string (HH:mm, 24h format) | null",
      "isRecurring": true,
      "recurrenceRule": "string (enum: 'yearly' | 'monthly' | 'weekly' | 'none')",
      "reminderTiers": [30, 14, 7, 3, 1, 0],
      "status": "string (enum: 'active' | 'completed' | 'snoozed')",
      "snoozedUntil": "string (ISO 8601) | null",
      "linkedProfileId": "string | null",
      "linkedGiftSuggestion": true,
      "createdAt": "string (ISO 8601)",
      "updatedAt": "string (ISO 8601)"
    }
  ],
  "pagination": {
    "hasMore": true,
    "lastDocId": "string",
    "totalCount": 25
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 400 | `INVALID_REQUEST` | Invalid filter values |
| 401 | `UNAUTHENTICATED` | Invalid token |

**Caching:** Redis, TTL 120s, key: `reminders:list:{uid}:{type}:{status}`

**Tier restrictions:** None

---

### 3.2 POST /reminders

**Description:** Create a new reminder. Automatically sets up multi-tier notification schedule.

**Auth required:** Yes

**Rate limit:** 10 requests/minute per user

**Request Body:**

```json
{
  "title": "string (required, 1-200 chars)",
  "description": "string (optional, max 1000 chars)",
  "type": "string (required, enum: 'birthday' | 'anniversary' | 'islamic_holiday' | 'cultural' | 'custom' | 'promise')",
  "date": "string (required, ISO 8601 date)",
  "time": "string (optional, HH:mm 24h format)",
  "isRecurring": "boolean (optional, default: false)",
  "recurrenceRule": "string (optional, enum: 'yearly' | 'monthly' | 'weekly' | 'none', default: 'none')",
  "reminderTiers": "array of integers (optional, default: [7, 3, 1, 0], values in days before event)",
  "linkedProfileId": "string (optional, partner profile ID)"
}
```

**Success Response:** `201 Created`

```json
{
  "data": {
    "id": "string",
    "title": "string",
    "type": "string",
    "date": "string",
    "reminderTiers": [30, 14, 7, 3, 1, 0],
    "status": "active",
    "scheduledNotifications": [
      { "tier": 30, "scheduledFor": "string (ISO 8601)" },
      { "tier": 14, "scheduledFor": "string (ISO 8601)" },
      { "tier": 7, "scheduledFor": "string (ISO 8601)" },
      { "tier": 3, "scheduledFor": "string (ISO 8601)" },
      { "tier": 1, "scheduledFor": "string (ISO 8601)" },
      { "tier": 0, "scheduledFor": "string (ISO 8601)" }
    ],
    "createdAt": "string (ISO 8601)"
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 400 | `INVALID_REQUEST` | Missing required fields or invalid date |
| 400 | `INVALID_DATE` | Date is in the past (non-recurring) |
| 401 | `UNAUTHENTICATED` | Invalid token |

**Caching:** Invalidates `reminders:list:{uid}:*`

**Tier restrictions:** None

---

### 3.3 PUT /reminders/:id

**Description:** Update an existing reminder. Partial updates supported.

**Auth required:** Yes

**Rate limit:** 10 requests/minute per user

**Request Body:**

```json
{
  "title": "string (optional)",
  "description": "string (optional)",
  "date": "string (optional, ISO 8601 date)",
  "time": "string (optional, HH:mm)",
  "isRecurring": "boolean (optional)",
  "recurrenceRule": "string (optional)",
  "reminderTiers": "array of integers (optional)"
}
```

**Success Response:** `200 OK`

```json
{
  "data": {
    "id": "string",
    "title": "string",
    "date": "string",
    "updatedAt": "string (ISO 8601)"
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 400 | `INVALID_REQUEST` | Invalid field values |
| 401 | `UNAUTHENTICATED` | Invalid token |
| 403 | `PERMISSION_DENIED` | Not the owner |
| 404 | `NOT_FOUND` | Reminder not found |

**Caching:** Invalidates `reminders:list:{uid}:*`

**Tier restrictions:** None

---

### 3.4 DELETE /reminders/:id

**Description:** Delete a reminder and cancel all its scheduled notifications.

**Auth required:** Yes

**Rate limit:** 10 requests/minute per user

**Request Body:** None

**Success Response:** `200 OK`

```json
{
  "data": {
    "message": "Reminder deleted",
    "cancelledNotifications": 6
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 401 | `UNAUTHENTICATED` | Invalid token |
| 403 | `PERMISSION_DENIED` | Not the owner |
| 404 | `NOT_FOUND` | Reminder not found |

**Caching:** Invalidates `reminders:list:{uid}:*`

**Tier restrictions:** None

---

### 3.5 POST /reminders/:id/snooze

**Description:** Snooze a reminder notification for a specified duration.

**Auth required:** Yes

**Rate limit:** 20 requests/minute per user

**Request Body:**

```json
{
  "duration": "string (required, enum: '1h' | '3h' | '1d' | '3d' | '1w')"
}
```

**Success Response:** `200 OK`

```json
{
  "data": {
    "id": "string",
    "status": "snoozed",
    "snoozedUntil": "string (ISO 8601)",
    "nextNotification": "string (ISO 8601)"
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 400 | `INVALID_DURATION` | Invalid snooze duration |
| 401 | `UNAUTHENTICATED` | Invalid token |
| 404 | `NOT_FOUND` | Reminder not found |

**Caching:** Invalidates `reminders:list:{uid}:*`

**Tier restrictions:** None

---

### 3.6 POST /reminders/:id/complete

**Description:** Mark a reminder as completed. Awards XP via gamification system.

**Auth required:** Yes

**Rate limit:** 20 requests/minute per user

**Request Body:**

```json
{
  "notes": "string (optional, max 500 chars)"
}
```

**Success Response:** `200 OK`

```json
{
  "data": {
    "id": "string",
    "status": "completed",
    "completedAt": "string (ISO 8601)",
    "xpAwarded": 15,
    "nextOccurrence": "string (ISO 8601) | null"
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 401 | `UNAUTHENTICATED` | Invalid token |
| 404 | `NOT_FOUND` | Reminder not found |
| 409 | `ALREADY_COMPLETED` | Reminder already completed |

**Caching:** Invalidates `reminders:list:{uid}:*`, `gamification:profile:{uid}`

**Tier restrictions:** None

---

### 3.7 GET /reminders/upcoming

**Description:** Get upcoming reminders within a date range, sorted by date ascending.

**Auth required:** Yes

**Rate limit:** 30 requests/minute per user

**Query Parameters:**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `days` | integer | No | 7 | Look-ahead window: 7 or 30 |

**Success Response:** `200 OK`

```json
{
  "data": [
    {
      "id": "string",
      "title": "string",
      "type": "string",
      "date": "string (ISO 8601)",
      "daysUntil": 3,
      "urgencyLevel": "string (enum: 'low' | 'medium' | 'high' | 'critical')",
      "linkedProfileId": "string | null",
      "suggestedAction": "string (e.g. 'Start planning her gift')"
    }
  ],
  "summary": {
    "totalUpcoming": 5,
    "nextEvent": {
      "title": "Jessica's Birthday",
      "daysUntil": 3
    }
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 400 | `INVALID_REQUEST` | Invalid days value |
| 401 | `UNAUTHENTICATED` | Invalid token |

**Caching:** Redis, TTL 60s, key: `reminders:upcoming:{uid}:{days}`

**Tier restrictions:** None

---

## Module 4: AI Message Generator

### 4.1 POST /ai/messages/generate

**Description:** Generate a personalized AI message using the optimal model based on emotional depth, mode, and user tier. This is the core AI endpoint that goes through the AI Router for model selection.

**Auth required:** Yes

**Rate limit:** 10 req/min (Free), 30 req/min (Pro), 60 req/min (Legend)

**Request Body:**

```json
{
  "mode": "string (required, enum: 'good_morning' | 'checking_in' | 'appreciation' | 'motivation' | 'celebration' | 'flirting' | 'reassurance' | 'long_distance' | 'apology' | 'after_argument')",
  "tone": "string (required, enum: 'warm' | 'playful' | 'serious' | 'romantic' | 'gentle' | 'confident')",
  "length": "string (required, enum: 'short' | 'medium' | 'long')",
  "profileId": "string (required, partner profile ID for personalization)",
  "additionalContext": "string (optional, max 500 chars, user's situation description)",
  "emotionalState": "string (optional, enum: 'happy' | 'stressed' | 'sad' | 'angry' | 'anxious' | 'neutral' | 'excited' | 'tired' | 'overwhelmed' | 'vulnerable')",
  "situationSeverity": "integer (optional, 1-5)",
  "includeAlternatives": "boolean (optional, default: false, Legend tier only)"
}
```

**Success Response:** `200 OK`

```json
{
  "data": {
    "id": "string (message ID)",
    "content": "string (the generated message text)",
    "alternatives": ["string", "string"],
    "mode": "string",
    "tone": "string",
    "length": "string",
    "language": "string",
    "metadata": {
      "modelUsed": "string (e.g. 'claude-sonnet-4.5')",
      "emotionalDepthScore": 4,
      "latencyMs": 2340,
      "cached": false,
      "wasFallback": false
    },
    "feedbackId": "string (for submitting thumbs up/down)",
    "usage": {
      "used": 43,
      "limit": 100,
      "remaining": 57,
      "resetsAt": "string (ISO 8601, first of next month)"
    },
    "createdAt": "string (ISO 8601)"
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 400 | `INVALID_REQUEST` | Missing required fields or invalid enum values |
| 400 | `INVALID_MODE` | Unsupported message mode |
| 401 | `UNAUTHENTICATED` | Invalid token |
| 403 | `TIER_LIMIT_EXCEEDED` | Monthly message limit reached for tier |
| 404 | `PROFILE_NOT_FOUND` | Partner profile ID does not exist |
| 429 | `RATE_LIMITED` | Too many requests |
| 503 | `AI_SERVICE_UNAVAILABLE` | All AI models failed (primary + fallbacks) |

**Caching:** Response cached in Redis, TTL 3600s, key: `ai:msg:{uid}:{mode}:{tone}:{hash(context)}`

**Tier restrictions:**

| Tier | Monthly Limit | Alternatives | Models Available |
|------|--------------|--------------|-----------------|
| Free | 10 messages | No | Claude Haiku, GPT-5 Mini |
| Pro | 100 messages | No | Claude Haiku, Claude Sonnet (depth >= 4) |
| Legend | Unlimited | Yes (2 alternatives) | All models including Claude Sonnet |

---

### 4.2 GET /ai/messages/modes

**Description:** Get all 10 available message modes with descriptions, icons, and example use cases.

**Auth required:** Yes

**Rate limit:** 30 requests/minute per user

**Success Response:** `200 OK`

```json
{
  "data": [
    {
      "id": "good_morning",
      "name": "Good Morning",
      "nameLocalized": "string (in user's language)",
      "description": "Start her day with a personalized sweet message",
      "descriptionLocalized": "string",
      "icon": "sunrise",
      "emotionalDepthBase": 1,
      "exampleTones": ["warm", "playful", "romantic"],
      "availableOnTier": "free",
      "popularity": 0.92
    }
  ]
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 401 | `UNAUTHENTICATED` | Invalid token |

**Caching:** Redis, TTL 86400s (24h), key: `ai:msg:modes:{locale}`

**Tier restrictions:** All modes visible to all tiers

---

### 4.3 GET /ai/messages/history

**Description:** Get previously generated messages with pagination and optional filters.

**Auth required:** Yes

**Rate limit:** 30 requests/minute per user

**Query Parameters:**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `mode` | string | No | all | Filter by message mode |
| `favorited` | boolean | No | null | Filter favorites only |
| `limit` | integer | No | 20 | Max 50 |
| `lastDocId` | string | No | null | Cursor |

**Success Response:** `200 OK`

```json
{
  "data": [
    {
      "id": "string",
      "content": "string",
      "mode": "string",
      "tone": "string",
      "length": "string",
      "language": "string",
      "isFavorited": false,
      "feedback": "string | null (enum: 'up' | 'down')",
      "metadata": {
        "modelUsed": "string",
        "emotionalDepthScore": 3
      },
      "createdAt": "string (ISO 8601)"
    }
  ],
  "pagination": {
    "hasMore": true,
    "lastDocId": "string",
    "totalCount": 43
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 401 | `UNAUTHENTICATED` | Invalid token |

**Caching:** Redis, TTL 120s, key: `ai:msg:history:{uid}:{mode}:{fav}`

**Tier restrictions:** None

---

### 4.4 POST /ai/messages/:id/favorite

**Description:** Toggle favorite status on a generated message.

**Auth required:** Yes

**Rate limit:** 30 requests/minute per user

**Request Body:**

```json
{
  "isFavorited": "boolean (required)"
}
```

**Success Response:** `200 OK`

```json
{
  "data": {
    "id": "string",
    "isFavorited": true,
    "updatedAt": "string (ISO 8601)"
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 401 | `UNAUTHENTICATED` | Invalid token |
| 404 | `NOT_FOUND` | Message not found |

**Caching:** Invalidates `ai:msg:history:{uid}:*`

**Tier restrictions:** None

---

### 4.5 POST /ai/messages/:id/feedback

**Description:** Submit thumbs up/down feedback on a generated message. Used to improve AI quality.

**Auth required:** Yes

**Rate limit:** 20 requests/minute per user

**Request Body:**

```json
{
  "rating": "string (required, enum: 'up' | 'down')",
  "reason": "string (optional, enum: 'too_generic' | 'wrong_tone' | 'culturally_inappropriate' | 'too_long' | 'too_short' | 'perfect' | 'other')",
  "comment": "string (optional, max 500 chars)"
}
```

**Success Response:** `200 OK`

```json
{
  "data": {
    "id": "string",
    "feedback": "up",
    "xpAwarded": 5,
    "message": "Thanks for your feedback!"
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 400 | `INVALID_REQUEST` | Invalid rating value |
| 401 | `UNAUTHENTICATED` | Invalid token |
| 404 | `NOT_FOUND` | Message not found |
| 409 | `ALREADY_RATED` | Feedback already submitted |

**Caching:** None

**Tier restrictions:** None

---

### 4.6 GET /ai/messages/usage

**Description:** Get current month's message generation usage and limits for the user's tier.

**Auth required:** Yes

**Rate limit:** 30 requests/minute per user

**Success Response:** `200 OK`

```json
{
  "data": {
    "tier": "pro",
    "currentMonth": "2026-02",
    "messagesUsed": 43,
    "messagesLimit": 100,
    "messagesRemaining": 57,
    "resetsAt": "string (ISO 8601)",
    "breakdown": {
      "good_morning": 12,
      "appreciation": 8,
      "apology": 5,
      "flirting": 7,
      "other": 11
    },
    "averageDepthScore": 2.8,
    "topModel": "claude-haiku-4.5"
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 401 | `UNAUTHENTICATED` | Invalid token |

**Caching:** Redis, TTL 60s, key: `ai:msg:usage:{uid}:{month}`

**Tier restrictions:** None

---

## Module 5: Gift Recommendation Engine

### 5.1 POST /gifts/recommend

**Description:** Get AI-powered gift recommendations based on partner profile, occasion, budget, and cultural context. Uses Gemini Flash as primary model for data-grounded recommendations.

**Auth required:** Yes

**Rate limit:** 10 req/min (Free), 20 req/min (Pro), 40 req/min (Legend)

**Request Body:**

```json
{
  "profileId": "string (required, partner profile ID)",
  "occasion": "string (required, enum: 'birthday' | 'anniversary' | 'eid' | 'valentines' | 'just_because' | 'apology' | 'congratulations' | 'hari_raya' | 'christmas' | 'other')",
  "occasionDetails": "string (optional, max 300 chars)",
  "budgetMin": "number (required, minimum budget in USD, min: 5)",
  "budgetMax": "number (required, maximum budget in USD, max: 10000)",
  "currency": "string (optional, enum: 'USD' | 'SAR' | 'AED' | 'MYR' | 'EUR' | 'GBP', default: 'USD')",
  "giftType": "string (optional, enum: 'physical' | 'experience' | 'digital' | 'handmade' | 'any', default: 'any')",
  "excludeCategories": ["string (optional, categories to exclude, e.g. 'jewelry', 'electronics')"],
  "count": "integer (optional, 3-10, default: 5)"
}
```

**Success Response:** `200 OK`

```json
{
  "data": {
    "recommendations": [
      {
        "id": "string",
        "name": "string",
        "description": "string (2-3 sentences why she would love this)",
        "category": "string",
        "estimatedPrice": {
          "min": 45.00,
          "max": 65.00,
          "currency": "USD"
        },
        "personalizedReasoning": "string (why this matches her profile)",
        "whereToBuy": ["string (store/platform suggestions)"],
        "imageCategory": "string (for placeholder icon)",
        "giftType": "string (enum: 'physical' | 'experience' | 'digital' | 'handmade')",
        "culturallyAppropriate": true,
        "matchScore": 0.92,
        "pairsWith": ["string (complementary gift ideas)"]
      }
    ],
    "metadata": {
      "modelUsed": "gemini-flash",
      "latencyMs": 3200,
      "cached": false,
      "profileFactorsUsed": ["zodiac:scorpio", "loveLanguage:gifts", "culture:gulf_arab"]
    },
    "usage": {
      "used": 8,
      "limit": 20,
      "remaining": 12,
      "resetsAt": "string (ISO 8601)"
    }
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 400 | `INVALID_REQUEST` | Missing required fields |
| 400 | `INVALID_BUDGET_RANGE` | budgetMin > budgetMax or out of bounds |
| 401 | `UNAUTHENTICATED` | Invalid token |
| 403 | `TIER_LIMIT_EXCEEDED` | Monthly gift recommendation limit reached |
| 404 | `PROFILE_NOT_FOUND` | Partner profile not found |
| 503 | `AI_SERVICE_UNAVAILABLE` | AI service unavailable |

**Caching:** Redis, TTL 1800s, key: `gifts:rec:{uid}:{occasion}:{budget}:{hash(params)}`

**Tier restrictions:**

| Tier | Monthly Limit | Recommendations per request |
|------|--------------|---------------------------|
| Free | 5 requests | 3 gifts max |
| Pro | 30 requests | 5 gifts max |
| Legend | Unlimited | 10 gifts max |

---

### 5.2 GET /gifts/categories

**Description:** Get available gift categories with localized names, filtered by cultural context.

**Auth required:** Yes

**Rate limit:** 30 requests/minute per user

**Query Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `culturalContext` | string | No | Filter categories by cultural appropriateness |

**Success Response:** `200 OK`

```json
{
  "data": [
    {
      "id": "jewelry",
      "name": "Jewelry",
      "nameLocalized": "string",
      "icon": "diamond",
      "subcategories": ["rings", "necklaces", "bracelets", "earrings"],
      "culturalNotes": "string | null",
      "avgPriceRange": { "min": 30, "max": 500, "currency": "USD" }
    }
  ]
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 401 | `UNAUTHENTICATED` | Invalid token |

**Caching:** Redis, TTL 86400s (24h), key: `gifts:categories:{locale}:{culture}`

**Tier restrictions:** None

---

### 5.3 GET /gifts/history

**Description:** Get history of gift recommendations previously generated.

**Auth required:** Yes

**Rate limit:** 30 requests/minute per user

**Query Parameters:**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `occasion` | string | No | all | Filter by occasion type |
| `limit` | integer | No | 20 | Max 50 |
| `lastDocId` | string | No | null | Cursor |

**Success Response:** `200 OK`

```json
{
  "data": [
    {
      "id": "string",
      "occasion": "string",
      "budgetRange": { "min": 50, "max": 100, "currency": "USD" },
      "recommendationCount": 5,
      "topRecommendation": "string (name of highest match score gift)",
      "feedback": "string | null (enum: 'loved_it' | 'okay' | 'missed')",
      "createdAt": "string (ISO 8601)"
    }
  ],
  "pagination": {
    "hasMore": false,
    "lastDocId": "string",
    "totalCount": 8
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 401 | `UNAUTHENTICATED` | Invalid token |

**Caching:** Redis, TTL 300s, key: `gifts:history:{uid}`

**Tier restrictions:** None

---

### 5.4 POST /gifts/:id/feedback

**Description:** Submit feedback on whether the partner liked a gift recommendation that was actually given.

**Auth required:** Yes

**Rate limit:** 10 requests/minute per user

**Request Body:**

```json
{
  "outcome": "string (required, enum: 'loved_it' | 'liked_it' | 'okay' | 'didnt_like' | 'not_given')",
  "comment": "string (optional, max 500 chars)",
  "actualGiftGiven": "string (optional, what was actually purchased)"
}
```

**Success Response:** `200 OK`

```json
{
  "data": {
    "id": "string",
    "outcome": "loved_it",
    "xpAwarded": 20,
    "message": "Great! We'll remember she loved this type of gift."
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 400 | `INVALID_REQUEST` | Invalid outcome value |
| 401 | `UNAUTHENTICATED` | Invalid token |
| 404 | `NOT_FOUND` | Gift recommendation not found |
| 409 | `ALREADY_RATED` | Feedback already submitted |

**Caching:** None

**Tier restrictions:** None

---

### 5.5 GET /gifts/wishlist

**Description:** Get the partner's wish list items from Memory Vault. Convenience endpoint that aggregates wish list entries to inform gift decisions.

**Auth required:** Yes

**Rate limit:** 30 requests/minute per user

**Success Response:** `200 OK`

```json
{
  "data": [
    {
      "id": "string",
      "item": "string",
      "category": "string | null",
      "priority": "string (enum: 'high' | 'medium' | 'low')",
      "estimatedPrice": "number | null",
      "currency": "string | null",
      "notes": "string | null",
      "source": "string (enum: 'user_added' | 'ai_detected' | 'conversation')",
      "addedAt": "string (ISO 8601)"
    }
  ]
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 401 | `UNAUTHENTICATED` | Invalid token |

**Caching:** Redis, TTL 300s, key: `gifts:wishlist:{uid}`

**Tier restrictions:** None

---

## Module 6: SOS Mode

### 6.1 POST /sos/activate

**Description:** Activate a new SOS session. Designed for 2-tap activation when the user is in an urgent relationship crisis. Uses Grok for sub-3-second response time.

**Auth required:** Yes

**Rate limit:** 5 requests/minute per user

**Request Body:**

```json
{
  "scenario": "string (required, enum: 'she_is_angry' | 'she_is_crying' | 'she_is_silent' | 'caught_in_lie' | 'forgot_important_date' | 'said_wrong_thing' | 'she_wants_to_talk' | 'her_family_conflict' | 'jealousy_issue' | 'other')",
  "urgency": "string (required, enum: 'happening_now' | 'just_happened' | 'brewing')",
  "briefContext": "string (optional, max 200 chars, quick description)",
  "profileId": "string (optional, partner profile ID for personalization)"
}
```

**Success Response:** `200 OK`

```json
{
  "data": {
    "sessionId": "string (SOS session ID)",
    "scenario": "string",
    "urgency": "string",
    "immediateAdvice": {
      "doNow": "string (1-2 sentence immediate action)",
      "doNotDo": "string (critical thing to avoid)",
      "bodyLanguage": "string (physical positioning advice)"
    },
    "severityAssessmentRequired": true,
    "estimatedResolutionSteps": 4,
    "createdAt": "string (ISO 8601)"
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 400 | `INVALID_REQUEST` | Missing scenario or urgency |
| 401 | `UNAUTHENTICATED` | Invalid token |
| 403 | `TIER_LIMIT_EXCEEDED` | Monthly SOS limit reached |
| 429 | `RATE_LIMITED` | Too many SOS activations |
| 503 | `AI_SERVICE_UNAVAILABLE` | All AI models unavailable |

**Caching:** None (real-time responses, never cached)

**Tier restrictions:**

| Tier | Monthly SOS Sessions |
|------|---------------------|
| Free | 2 |
| Pro | 10 |
| Legend | Unlimited |

---

### 6.2 POST /sos/assess

**Description:** Submit a severity assessment questionnaire for the active SOS session. Determines the depth of coaching needed.

**Auth required:** Yes

**Rate limit:** 10 requests/minute per user

**Request Body:**

```json
{
  "sessionId": "string (required, from /sos/activate)",
  "answers": {
    "howLongAgo": "string (required, enum: 'minutes' | 'hours' | 'today' | 'yesterday')",
    "herCurrentState": "string (required, enum: 'calm' | 'upset' | 'very_upset' | 'crying' | 'furious' | 'silent')",
    "haveYouSpoken": "boolean (required)",
    "isSheTalking": "boolean (required)",
    "yourFault": "string (required, enum: 'yes' | 'no' | 'partially' | 'unsure')",
    "previousSimilar": "boolean (optional)",
    "additionalContext": "string (optional, max 300 chars)"
  }
}
```

**Success Response:** `200 OK`

```json
{
  "data": {
    "sessionId": "string",
    "severityScore": 4,
    "severityLabel": "string (enum: 'mild' | 'moderate' | 'serious' | 'severe' | 'critical')",
    "coachingPlan": {
      "totalSteps": 5,
      "estimatedMinutes": 15,
      "approach": "string (e.g. 'empathetic_listening_first')",
      "keyInsight": "string (AI-generated insight about the situation)"
    }
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 400 | `INVALID_REQUEST` | Missing required answers |
| 401 | `UNAUTHENTICATED` | Invalid token |
| 404 | `SESSION_NOT_FOUND` | SOS session not found or expired |

**Caching:** None

**Tier restrictions:** None (part of active session)

---

### 6.3 POST /sos/coach

**Description:** Get real-time coaching response for the active SOS session. Supports streaming via Server-Sent Events for live delivery. Each call advances one coaching step.

**Auth required:** Yes

**Rate limit:** 20 requests/minute per user

**Request Headers:**

| Header | Required | Value |
|--------|----------|-------|
| `Authorization` | Yes | `Bearer <token>` |
| `Accept` | No | `text/event-stream` for streaming, `application/json` for standard |

**Request Body:**

```json
{
  "sessionId": "string (required)",
  "stepNumber": "integer (required, 1-based, current coaching step)",
  "userUpdate": "string (optional, max 500 chars, what happened since last step)",
  "herResponse": "string (optional, max 500 chars, what she said/did)",
  "stream": "boolean (optional, default: false, enable SSE streaming)"
}
```

**Success Response (JSON):** `200 OK`

```json
{
  "data": {
    "sessionId": "string",
    "stepNumber": 2,
    "totalSteps": 5,
    "coaching": {
      "sayThis": "string (exact phrase to say to her)",
      "whyItWorks": "string (brief explanation of the psychology)",
      "doNotSay": ["string (phrases to absolutely avoid)"],
      "bodyLanguageTip": "string",
      "toneAdvice": "string (enum: 'soft' | 'calm' | 'warm' | 'serious' | 'gentle')",
      "waitFor": "string (what to observe before proceeding)"
    },
    "isLastStep": false,
    "nextStepPrompt": "string (what to report back)"
  }
}
```

**Success Response (SSE streaming):** `200 OK` with `Content-Type: text/event-stream`

```
event: coaching_start
data: {"sessionId":"abc","stepNumber":2}

event: say_this
data: {"text":"I understand why you feel..."}

event: body_language
data: {"text":"Face her directly, maintain gentle eye contact"}

event: do_not_say
data: {"phrases":["But I didn't mean to...","You're overreacting"]}

event: coaching_complete
data: {"isLastStep":false,"nextStepPrompt":"What did she say?"}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 400 | `INVALID_REQUEST` | Missing sessionId or stepNumber |
| 400 | `INVALID_STEP` | Step number out of range |
| 401 | `UNAUTHENTICATED` | Invalid token |
| 404 | `SESSION_NOT_FOUND` | Session not found or expired |
| 503 | `AI_SERVICE_UNAVAILABLE` | AI models unavailable |

**Caching:** None (real-time, context-dependent)

**Tier restrictions:** None (part of active session, session count enforced at activation)

---

### 6.4 POST /sos/resolve

**Description:** Close an active SOS session with follow-up outcome. Records resolution for learning.

**Auth required:** Yes

**Rate limit:** 10 requests/minute per user

**Request Body:**

```json
{
  "sessionId": "string (required)",
  "outcome": "string (required, enum: 'resolved_well' | 'partially_resolved' | 'still_ongoing' | 'got_worse' | 'abandoned')",
  "whatWorked": "string (optional, max 500 chars)",
  "whatDidntWork": "string (optional, max 500 chars)",
  "wouldUseAgain": "boolean (optional)",
  "rating": "integer (optional, 1-5)"
}
```

**Success Response:** `200 OK`

```json
{
  "data": {
    "sessionId": "string",
    "status": "resolved",
    "outcome": "resolved_well",
    "xpAwarded": 30,
    "followUpReminder": {
      "enabled": true,
      "scheduledFor": "string (ISO 8601, next day check-in)",
      "message": "Check in with her tomorrow to show you care"
    },
    "resolvedAt": "string (ISO 8601)"
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 400 | `INVALID_REQUEST` | Invalid outcome |
| 401 | `UNAUTHENTICATED` | Invalid token |
| 404 | `SESSION_NOT_FOUND` | Session not found |
| 409 | `SESSION_ALREADY_RESOLVED` | Session already closed |

**Caching:** None

**Tier restrictions:** None

---

### 6.5 GET /sos/history

**Description:** Get history of past SOS sessions with outcomes.

**Auth required:** Yes

**Rate limit:** 30 requests/minute per user

**Query Parameters:**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `limit` | integer | No | 20 | Max 50 |
| `lastDocId` | string | No | null | Cursor |

**Success Response:** `200 OK`

```json
{
  "data": [
    {
      "sessionId": "string",
      "scenario": "string",
      "urgency": "string",
      "severityScore": 4,
      "stepsCompleted": 5,
      "outcome": "string",
      "rating": 4,
      "duration": {
        "minutes": 18,
        "startedAt": "string (ISO 8601)",
        "resolvedAt": "string (ISO 8601)"
      }
    }
  ],
  "pagination": {
    "hasMore": false,
    "lastDocId": "string",
    "totalCount": 6
  },
  "stats": {
    "totalSessions": 6,
    "resolvedWell": 4,
    "averageRating": 4.2,
    "mostCommonScenario": "she_is_angry"
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 401 | `UNAUTHENTICATED` | Invalid token |

**Caching:** Redis, TTL 300s, key: `sos:history:{uid}`

**Tier restrictions:** None

---

## Module 7: Gamification

### 7.1 GET /gamification/profile

**Description:** Get the user's complete gamification profile including level, XP, streak, and consistency score.

**Auth required:** Yes

**Rate limit:** 30 requests/minute per user

**Success Response:** `200 OK`

```json
{
  "data": {
    "userId": "string",
    "level": {
      "current": 7,
      "name": "Devoted Partner",
      "xpCurrent": 1450,
      "xpForNextLevel": 2000,
      "xpProgress": 0.725,
      "totalXpEarned": 8450
    },
    "streak": {
      "currentDays": 14,
      "longestDays": 21,
      "freezesAvailable": 1,
      "freezesUsedThisMonth": 2,
      "lastActiveDate": "string (ISO 8601 date)"
    },
    "consistencyScore": {
      "score": 78,
      "label": "string (enum: 'needs_work' | 'building' | 'consistent' | 'devoted' | 'legendary')",
      "components": {
        "streakContribution": 25,
        "actionCardCompletion": 20,
        "reminderCompletion": 18,
        "messageFrequency": 15
      }
    },
    "weeklyXp": [
      { "day": "Mon", "xp": 45 },
      { "day": "Tue", "xp": 30 },
      { "day": "Wed", "xp": 60 },
      { "day": "Thu", "xp": 0 },
      { "day": "Fri", "xp": 25 },
      { "day": "Sat", "xp": 50 },
      { "day": "Sun", "xp": 40 }
    ]
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 401 | `UNAUTHENTICATED` | Invalid token |

**Caching:** Redis, TTL 60s, key: `gamification:profile:{uid}`

**Tier restrictions:** None

---

### 7.2 POST /gamification/action

**Description:** Log a completed action to earn XP. Called internally by other endpoints (action card complete, reminder complete, message feedback) or directly for custom actions.

**Auth required:** Yes

**Rate limit:** 30 requests/minute per user

**Request Body:**

```json
{
  "actionType": "string (required, enum: 'action_card_complete' | 'reminder_complete' | 'message_generated' | 'message_feedback' | 'gift_feedback' | 'sos_resolved' | 'memory_added' | 'profile_updated' | 'daily_login' | 'streak_milestone')",
  "referenceId": "string (optional, ID of related entity)",
  "metadata": {
    "cardType": "string (optional, for action cards: 'say' | 'do' | 'buy' | 'go')",
    "mode": "string (optional, for messages: message mode)",
    "streakDay": "integer (optional, for streak milestones)"
  }
}
```

**Success Response:** `200 OK`

```json
{
  "data": {
    "xpAwarded": 25,
    "xpBreakdown": {
      "base": 15,
      "streakBonus": 5,
      "firstTimeBonus": 5
    },
    "newTotalXp": 1475,
    "levelUp": false,
    "newLevel": null,
    "badgeEarned": null,
    "streakUpdate": {
      "currentDays": 15,
      "isNewRecord": false
    }
  }
}
```

**Level-up response variant:**

```json
{
  "data": {
    "xpAwarded": 25,
    "xpBreakdown": { "base": 15, "streakBonus": 10 },
    "newTotalXp": 2005,
    "levelUp": true,
    "newLevel": {
      "level": 8,
      "name": "Relationship Champion",
      "unlockedFeature": "Custom action card themes"
    },
    "badgeEarned": {
      "id": "streak_14",
      "name": "Two-Week Warrior",
      "icon": "fire_14",
      "description": "Maintained a 14-day streak"
    },
    "streakUpdate": {
      "currentDays": 14,
      "isNewRecord": false
    }
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 400 | `INVALID_REQUEST` | Invalid action type |
| 401 | `UNAUTHENTICATED` | Invalid token |
| 409 | `ACTION_ALREADY_LOGGED` | Duplicate action for same reference |

**Caching:** Invalidates `gamification:profile:{uid}`, `gamification:stats:{uid}`

**Tier restrictions:** None

---

### 7.3 GET /gamification/badges

**Description:** Get all available badges with earned/unearned status for the user.

**Auth required:** Yes

**Rate limit:** 30 requests/minute per user

**Success Response:** `200 OK`

```json
{
  "data": {
    "earned": [
      {
        "id": "streak_7",
        "name": "Week Warrior",
        "nameLocalized": "string",
        "icon": "fire_7",
        "description": "Maintain a 7-day streak",
        "descriptionLocalized": "string",
        "category": "string (enum: 'streak' | 'messages' | 'actions' | 'gifts' | 'sos' | 'milestone')",
        "earnedAt": "string (ISO 8601)",
        "rarity": "string (enum: 'common' | 'uncommon' | 'rare' | 'epic' | 'legendary')"
      }
    ],
    "unearned": [
      {
        "id": "streak_30",
        "name": "Monthly Master",
        "nameLocalized": "string",
        "icon": "fire_30_locked",
        "description": "Maintain a 30-day streak",
        "descriptionLocalized": "string",
        "category": "streak",
        "progress": 0.47,
        "progressDescription": "14/30 days",
        "rarity": "rare"
      }
    ],
    "totalEarned": 12,
    "totalAvailable": 35
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 401 | `UNAUTHENTICATED` | Invalid token |

**Caching:** Redis, TTL 300s, key: `gamification:badges:{uid}`

**Tier restrictions:** None

---

### 7.4 GET /gamification/streak

**Description:** Get detailed streak information including freeze status and history.

**Auth required:** Yes

**Rate limit:** 30 requests/minute per user

**Success Response:** `200 OK`

```json
{
  "data": {
    "currentStreak": 14,
    "longestStreak": 21,
    "streakStartDate": "string (ISO 8601 date)",
    "lastActiveDate": "string (ISO 8601 date)",
    "isActiveToday": true,
    "freezes": {
      "available": 1,
      "maxPerMonth": 3,
      "usedThisMonth": 2,
      "lastUsed": "string (ISO 8601 date) | null"
    },
    "milestones": [
      { "days": 7, "reached": true, "reachedAt": "string (ISO 8601)" },
      { "days": 14, "reached": true, "reachedAt": "string (ISO 8601)" },
      { "days": 30, "reached": false, "reachedAt": null },
      { "days": 60, "reached": false, "reachedAt": null },
      { "days": 100, "reached": false, "reachedAt": null }
    ],
    "streakHistory": [
      { "startDate": "string", "endDate": "string", "days": 21, "endReason": "missed" },
      { "startDate": "string", "endDate": null, "days": 14, "endReason": null }
    ]
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 401 | `UNAUTHENTICATED` | Invalid token |

**Caching:** Redis, TTL 60s, key: `gamification:streak:{uid}`

**Tier restrictions:** Streak freezes: Free=1/month, Pro=3/month, Legend=5/month

---

### 7.5 GET /gamification/stats

**Description:** Get weekly and monthly gamification trends and activity breakdown.

**Auth required:** Yes

**Rate limit:** 30 requests/minute per user

**Query Parameters:**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `period` | string | No | `week` | `week` or `month` |

**Success Response:** `200 OK`

```json
{
  "data": {
    "period": "week",
    "periodStart": "string (ISO 8601 date)",
    "periodEnd": "string (ISO 8601 date)",
    "totalXpEarned": 250,
    "actionsCompleted": 18,
    "breakdown": {
      "actionCardsCompleted": 8,
      "messagesGenerated": 5,
      "remindersCompleted": 3,
      "memoriesAdded": 1,
      "sosSessionsResolved": 1
    },
    "comparison": {
      "vsPreviousPeriod": "+15%",
      "trend": "string (enum: 'improving' | 'stable' | 'declining')"
    },
    "topCategory": "action_cards",
    "dailyBreakdown": [
      { "date": "string (ISO 8601 date)", "xp": 45, "actions": 3 }
    ]
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 400 | `INVALID_REQUEST` | Invalid period value |
| 401 | `UNAUTHENTICATED` | Invalid token |

**Caching:** Redis, TTL 300s, key: `gamification:stats:{uid}:{period}`

**Tier restrictions:** None

---

## Module 8: Smart Action Cards

### 8.1 GET /action-cards

**Description:** Get today's personalized action cards. Cards are AI-generated daily based on partner profile, relationship context, calendar events, and gamification history. Returns cached cards if already generated today.

**Auth required:** Yes

**Rate limit:** 30 requests/minute per user

**Query Parameters:**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `date` | string | No | today | ISO 8601 date, for fetching specific day's cards |
| `forceRefresh` | boolean | No | false | Force regeneration (Legend tier only) |

**Success Response:** `200 OK`

```json
{
  "data": {
    "date": "string (ISO 8601 date)",
    "cards": [
      {
        "id": "string",
        "type": "string (enum: 'say' | 'do' | 'buy' | 'go')",
        "title": "string",
        "titleLocalized": "string",
        "description": "string (2-3 sentences)",
        "descriptionLocalized": "string",
        "personalizedDetail": "string (why this is relevant today)",
        "difficulty": "string (enum: 'easy' | 'medium' | 'challenging')",
        "estimatedTime": "string (e.g. '5 min', '30 min', '2 hours')",
        "xpReward": 25,
        "status": "string (enum: 'pending' | 'completed' | 'skipped' | 'saved')",
        "contextTags": ["string (e.g. 'ramadan', 'her_birthday_soon', 'long_distance')"],
        "expiresAt": "string (ISO 8601, end of day)"
      }
    ],
    "summary": {
      "totalCards": 3,
      "completedToday": 1,
      "totalXpAvailable": 75
    }
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 401 | `UNAUTHENTICATED` | Invalid token |
| 403 | `TIER_LIMIT_EXCEEDED` | Force refresh not available on this tier |

**Caching:** Redis, TTL 43200s (12h), key: `action-cards:daily:{uid}:{date}`

**Tier restrictions:**

| Tier | Cards per Day | Force Refresh |
|------|--------------|---------------|
| Free | 3 | No |
| Pro | 10 | No |
| Legend | Unlimited | Yes |

---

### 8.2 POST /action-cards/:id/complete

**Description:** Mark an action card as completed. Awards XP and updates gamification.

**Auth required:** Yes

**Rate limit:** 20 requests/minute per user

**Request Body:**

```json
{
  "notes": "string (optional, max 500 chars, how it went)",
  "photoUrl": "string (optional, proof/memory photo URL)"
}
```

**Success Response:** `200 OK`

```json
{
  "data": {
    "id": "string",
    "status": "completed",
    "completedAt": "string (ISO 8601)",
    "xpAwarded": 25,
    "xpBreakdown": {
      "base": 15,
      "streakBonus": 5,
      "difficultyBonus": 5
    },
    "streakUpdate": {
      "currentDays": 15,
      "isActiveToday": true
    },
    "encouragement": "string (localized positive reinforcement message)"
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 401 | `UNAUTHENTICATED` | Invalid token |
| 404 | `NOT_FOUND` | Card not found |
| 409 | `ALREADY_COMPLETED` | Card already completed |
| 410 | `CARD_EXPIRED` | Card has expired (past its date) |

**Caching:** Invalidates `action-cards:daily:{uid}:*`, `gamification:profile:{uid}`

**Tier restrictions:** None

---

### 8.3 POST /action-cards/:id/skip

**Description:** Skip an action card with an optional reason. Does not award XP. Helps AI learn preferences.

**Auth required:** Yes

**Rate limit:** 20 requests/minute per user

**Request Body:**

```json
{
  "reason": "string (optional, enum: 'not_relevant' | 'too_hard' | 'no_time' | 'already_did' | 'not_appropriate' | 'other')",
  "comment": "string (optional, max 300 chars)"
}
```

**Success Response:** `200 OK`

```json
{
  "data": {
    "id": "string",
    "status": "skipped",
    "skippedAt": "string (ISO 8601)",
    "replacementCard": {
      "id": "string",
      "type": "string",
      "title": "string",
      "description": "string"
    }
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 401 | `UNAUTHENTICATED` | Invalid token |
| 404 | `NOT_FOUND` | Card not found |
| 409 | `ALREADY_ACTIONED` | Card already completed or skipped |

**Caching:** Invalidates `action-cards:daily:{uid}:*`

**Tier restrictions:** Replacement card only for Pro and Legend tiers

---

### 8.4 POST /action-cards/:id/save

**Description:** Save an action card for later. Saved cards persist beyond their daily expiration.

**Auth required:** Yes

**Rate limit:** 20 requests/minute per user

**Request Body:** None (empty body or `{}`)

**Success Response:** `200 OK`

```json
{
  "data": {
    "id": "string",
    "status": "saved",
    "savedAt": "string (ISO 8601)"
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 401 | `UNAUTHENTICATED` | Invalid token |
| 404 | `NOT_FOUND` | Card not found |
| 409 | `ALREADY_ACTIONED` | Card already completed |

**Caching:** Invalidates `action-cards:saved:{uid}`

**Tier restrictions:** Free tier max 5 saved cards, Pro 20, Legend unlimited

---

### 8.5 GET /action-cards/saved

**Description:** Get all saved action cards.

**Auth required:** Yes

**Rate limit:** 30 requests/minute per user

**Query Parameters:**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `type` | string | No | all | Filter by card type: `say`, `do`, `buy`, `go` |
| `limit` | integer | No | 20 | Max 50 |
| `lastDocId` | string | No | null | Cursor |

**Success Response:** `200 OK`

```json
{
  "data": [
    {
      "id": "string",
      "type": "string",
      "title": "string",
      "description": "string",
      "difficulty": "string",
      "xpReward": 25,
      "savedAt": "string (ISO 8601)",
      "originalDate": "string (ISO 8601 date)"
    }
  ],
  "pagination": {
    "hasMore": false,
    "lastDocId": "string",
    "totalCount": 8
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 401 | `UNAUTHENTICATED` | Invalid token |

**Caching:** Redis, TTL 120s, key: `action-cards:saved:{uid}`

**Tier restrictions:** None

---

### 8.6 GET /action-cards/history

**Description:** Get history of all action cards (completed, skipped, expired) with pagination.

**Auth required:** Yes

**Rate limit:** 30 requests/minute per user

**Query Parameters:**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `status` | string | No | all | Filter: `completed`, `skipped`, `expired` |
| `type` | string | No | all | Filter by card type |
| `startDate` | string | No | null | ISO 8601 date, range start |
| `endDate` | string | No | null | ISO 8601 date, range end |
| `limit` | integer | No | 20 | Max 50 |
| `lastDocId` | string | No | null | Cursor |

**Success Response:** `200 OK`

```json
{
  "data": [
    {
      "id": "string",
      "type": "string",
      "title": "string",
      "status": "completed",
      "xpAwarded": 25,
      "date": "string (ISO 8601 date)",
      "completedAt": "string (ISO 8601) | null",
      "skippedAt": "string (ISO 8601) | null",
      "skipReason": "string | null"
    }
  ],
  "pagination": {
    "hasMore": true,
    "lastDocId": "string",
    "totalCount": 95
  },
  "stats": {
    "totalCompleted": 65,
    "totalSkipped": 18,
    "totalExpired": 12,
    "completionRate": 0.68,
    "favoriteType": "say"
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 401 | `UNAUTHENTICATED` | Invalid token |

**Caching:** Redis, TTL 300s, key: `action-cards:history:{uid}:{status}:{type}`

**Tier restrictions:** None

---

## Module 9: Memory Vault

### 9.1 GET /memories

**Description:** List memories with pagination and optional filters. All memory content is encrypted at rest.

**Auth required:** Yes

**Rate limit:** 30 requests/minute per user

**Query Parameters:**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `category` | string | No | all | Filter: `moment`, `milestone`, `conflict_resolution`, `gift_given`, `trip`, `quote`, `other` |
| `hasMedia` | boolean | No | null | Filter entries with attached photos/media |
| `search` | string | No | null | Full-text search in title and description (max 100 chars) |
| `startDate` | string | No | null | ISO 8601 date range start |
| `endDate` | string | No | null | ISO 8601 date range end |
| `limit` | integer | No | 20 | Max 50 |
| `lastDocId` | string | No | null | Cursor |

**Success Response:** `200 OK`

```json
{
  "data": [
    {
      "id": "string",
      "title": "string",
      "description": "string",
      "category": "string",
      "date": "string (ISO 8601 date)",
      "mood": "string (enum: 'happy' | 'romantic' | 'grateful' | 'bittersweet' | 'proud' | 'funny') | null",
      "mediaUrls": ["string (Firebase Storage URL)"],
      "mediaCount": 2,
      "tags": ["string"],
      "isFavorite": false,
      "linkedProfileId": "string | null",
      "createdAt": "string (ISO 8601)",
      "updatedAt": "string (ISO 8601)"
    }
  ],
  "pagination": {
    "hasMore": true,
    "lastDocId": "string",
    "totalCount": 45
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 401 | `UNAUTHENTICATED` | Invalid token |

**Caching:** Redis, TTL 120s, key: `memories:list:{uid}:{category}:{hash(filters)}`

**Tier restrictions:**

| Tier | Max Memories |
|------|-------------|
| Free | 20 |
| Pro | 200 |
| Legend | Unlimited |

---

### 9.2 POST /memories

**Description:** Create a new memory entry. Content is encrypted before storage.

**Auth required:** Yes

**Rate limit:** 10 requests/minute per user

**Request Body:**

```json
{
  "title": "string (required, 1-200 chars)",
  "description": "string (optional, max 5000 chars)",
  "category": "string (required, enum: 'moment' | 'milestone' | 'conflict_resolution' | 'gift_given' | 'trip' | 'quote' | 'other')",
  "date": "string (required, ISO 8601 date)",
  "mood": "string (optional, enum: 'happy' | 'romantic' | 'grateful' | 'bittersweet' | 'proud' | 'funny')",
  "tags": ["string (optional, max 10 tags, each max 50 chars)"],
  "isFavorite": "boolean (optional, default: false)",
  "linkedProfileId": "string (optional, partner profile ID)"
}
```

**Success Response:** `201 Created`

```json
{
  "data": {
    "id": "string",
    "title": "string",
    "category": "string",
    "date": "string",
    "xpAwarded": 10,
    "totalMemories": 13,
    "memoryLimit": 200,
    "createdAt": "string (ISO 8601)"
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 400 | `INVALID_REQUEST` | Missing required fields |
| 401 | `UNAUTHENTICATED` | Invalid token |
| 403 | `TIER_LIMIT_EXCEEDED` | Memory storage limit reached for tier |

**Caching:** Invalidates `memories:list:{uid}:*`, `memories:timeline:{uid}`

**Tier restrictions:** Enforced at creation (see tier limits above)

---

### 9.3 PUT /memories/:id

**Description:** Update an existing memory entry. Partial updates supported.

**Auth required:** Yes

**Rate limit:** 10 requests/minute per user

**Request Body:**

```json
{
  "title": "string (optional)",
  "description": "string (optional)",
  "category": "string (optional)",
  "date": "string (optional)",
  "mood": "string (optional)",
  "tags": ["string (optional)"],
  "isFavorite": "boolean (optional)"
}
```

**Success Response:** `200 OK`

```json
{
  "data": {
    "id": "string",
    "title": "string",
    "updatedAt": "string (ISO 8601)"
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 400 | `INVALID_REQUEST` | Invalid field values |
| 401 | `UNAUTHENTICATED` | Invalid token |
| 403 | `PERMISSION_DENIED` | Not the owner |
| 404 | `NOT_FOUND` | Memory not found |

**Caching:** Invalidates `memories:list:{uid}:*`, `memories:timeline:{uid}`

**Tier restrictions:** None

---

### 9.4 DELETE /memories/:id

**Description:** Delete a memory and all associated media files from storage.

**Auth required:** Yes

**Rate limit:** 10 requests/minute per user

**Request Body:** None

**Success Response:** `200 OK`

```json
{
  "data": {
    "message": "Memory deleted",
    "mediaFilesDeleted": 2,
    "deletedAt": "string (ISO 8601)"
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 401 | `UNAUTHENTICATED` | Invalid token |
| 403 | `PERMISSION_DENIED` | Not the owner |
| 404 | `NOT_FOUND` | Memory not found |

**Caching:** Invalidates `memories:list:{uid}:*`, `memories:timeline:{uid}`

**Tier restrictions:** None

---

### 9.5 POST /memories/:id/media

**Description:** Upload a photo or media file to attach to a memory entry. Uses Firebase Storage with user-scoped paths.

**Auth required:** Yes

**Rate limit:** 5 requests/minute per user

**Request Headers:**

| Header | Required | Value |
|--------|----------|-------|
| `Content-Type` | Yes | `multipart/form-data` |
| `Authorization` | Yes | `Bearer <token>` |

**Request Body (multipart/form-data):**

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `file` | binary | Yes | Image file (JPEG, PNG, HEIC, WebP) or video (MP4, MOV, max 30s) |
| `caption` | string | No | Max 200 chars |

**File Constraints:**

| Constraint | Value |
|-----------|-------|
| Max file size | 10 MB (images), 50 MB (video) |
| Allowed image types | JPEG, PNG, HEIC, WebP |
| Allowed video types | MP4, MOV |
| Max video duration | 30 seconds |
| Max media per memory | 10 |

**Success Response:** `201 Created`

```json
{
  "data": {
    "mediaId": "string",
    "memoryId": "string",
    "url": "string (Firebase Storage download URL)",
    "thumbnailUrl": "string (auto-generated thumbnail URL)",
    "mimeType": "string",
    "sizeBytes": 2456789,
    "caption": "string | null",
    "uploadedAt": "string (ISO 8601)"
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 400 | `INVALID_FILE_TYPE` | Unsupported file format |
| 400 | `FILE_TOO_LARGE` | File exceeds size limit |
| 400 | `VIDEO_TOO_LONG` | Video exceeds 30 second limit |
| 401 | `UNAUTHENTICATED` | Invalid token |
| 403 | `MEDIA_LIMIT_EXCEEDED` | Memory already has 10 media files |
| 404 | `NOT_FOUND` | Memory not found |

**Caching:** None

**Tier restrictions:** Free=3 media per memory, Pro=10, Legend=10

---

### 9.6 GET /memories/timeline

**Description:** Get memories organized as a chronological timeline grouped by month/year.

**Auth required:** Yes

**Rate limit:** 30 requests/minute per user

**Query Parameters:**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `year` | integer | No | current year | Filter by year |

**Success Response:** `200 OK`

```json
{
  "data": {
    "year": 2026,
    "months": [
      {
        "month": 2,
        "monthName": "February",
        "monthNameLocalized": "string",
        "memoryCount": 4,
        "memories": [
          {
            "id": "string",
            "title": "string",
            "date": "string",
            "category": "string",
            "mood": "string | null",
            "thumbnailUrl": "string | null",
            "isFavorite": false
          }
        ]
      }
    ],
    "totalMemories": 45,
    "yearsAvailable": [2025, 2026]
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 401 | `UNAUTHENTICATED` | Invalid token |

**Caching:** Redis, TTL 300s, key: `memories:timeline:{uid}:{year}`

**Tier restrictions:** None

---

### 9.7 GET /memories/wishlist

**Description:** Get the partner's wish list items stored in Memory Vault.

**Auth required:** Yes

**Rate limit:** 30 requests/minute per user

**Query Parameters:**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `priority` | string | No | all | Filter: `high`, `medium`, `low` |
| `limit` | integer | No | 20 | Max 50 |
| `lastDocId` | string | No | null | Cursor |

**Success Response:** `200 OK`

```json
{
  "data": [
    {
      "id": "string",
      "item": "string",
      "category": "string | null (e.g. 'fashion', 'electronics', 'experience', 'home')",
      "priority": "string (enum: 'high' | 'medium' | 'low')",
      "estimatedPrice": "number | null",
      "currency": "string | null",
      "link": "string (URL) | null",
      "notes": "string | null",
      "source": "string (enum: 'user_added' | 'ai_detected' | 'conversation')",
      "isGifted": false,
      "giftedDate": "string (ISO 8601) | null",
      "addedAt": "string (ISO 8601)"
    }
  ],
  "pagination": {
    "hasMore": false,
    "lastDocId": "string",
    "totalCount": 12
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 401 | `UNAUTHENTICATED` | Invalid token |

**Caching:** Redis, TTL 300s, key: `memories:wishlist:{uid}`

**Tier restrictions:** None

---

### 9.8 POST /memories/wishlist

**Description:** Add an item to the partner's wish list.

**Auth required:** Yes

**Rate limit:** 10 requests/minute per user

**Request Body:**

```json
{
  "item": "string (required, 1-200 chars)",
  "category": "string (optional, enum: 'fashion' | 'electronics' | 'experience' | 'home' | 'beauty' | 'books' | 'food' | 'travel' | 'other')",
  "priority": "string (optional, enum: 'high' | 'medium' | 'low', default: 'medium')",
  "estimatedPrice": "number (optional)",
  "currency": "string (optional, default: user's currency)",
  "link": "string (optional, valid URL)",
  "notes": "string (optional, max 500 chars)"
}
```

**Success Response:** `201 Created`

```json
{
  "data": {
    "id": "string",
    "item": "string",
    "priority": "medium",
    "addedAt": "string (ISO 8601)"
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 400 | `INVALID_REQUEST` | Missing item name |
| 401 | `UNAUTHENTICATED` | Invalid token |

**Caching:** Invalidates `memories:wishlist:{uid}`, `gifts:wishlist:{uid}`

**Tier restrictions:** None

---

## Module 10: Settings & Subscriptions

### 10.1 GET /settings

**Description:** Get all user settings including notification preferences, quiet hours, privacy, and display preferences.

**Auth required:** Yes

**Rate limit:** 30 requests/minute per user

**Success Response:** `200 OK`

```json
{
  "data": {
    "notifications": {
      "enabled": true,
      "reminders": true,
      "actionCards": true,
      "dailyMotivation": true,
      "weeklyReport": true,
      "sosFollowUp": true,
      "promotions": false
    },
    "quietHours": {
      "enabled": true,
      "startTime": "22:00",
      "endTime": "07:00",
      "timezone": "Asia/Kuala_Lumpur"
    },
    "privacy": {
      "biometricLockEnabled": true,
      "lockScreenNotificationContent": false,
      "analyticsEnabled": true,
      "crashReportingEnabled": true
    },
    "display": {
      "theme": "string (enum: 'light' | 'dark' | 'system')",
      "language": "string (enum: 'en' | 'ar' | 'ms')",
      "dateFormat": "string (enum: 'DD/MM/YYYY' | 'MM/DD/YYYY' | 'YYYY-MM-DD')",
      "useHijriCalendar": false
    }
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 401 | `UNAUTHENTICATED` | Invalid token |

**Caching:** Redis, TTL 300s, key: `settings:{uid}`

**Tier restrictions:** None

---

### 10.2 PUT /settings

**Description:** Update user settings. Partial updates supported; only include sections/fields to change.

**Auth required:** Yes

**Rate limit:** 10 requests/minute per user

**Request Body:**

```json
{
  "notifications": {
    "enabled": "boolean (optional)",
    "reminders": "boolean (optional)",
    "actionCards": "boolean (optional)",
    "dailyMotivation": "boolean (optional)",
    "weeklyReport": "boolean (optional)",
    "sosFollowUp": "boolean (optional)",
    "promotions": "boolean (optional)"
  },
  "quietHours": {
    "enabled": "boolean (optional)",
    "startTime": "string (optional, HH:mm 24h)",
    "endTime": "string (optional, HH:mm 24h)",
    "timezone": "string (optional, IANA timezone)"
  },
  "privacy": {
    "biometricLockEnabled": "boolean (optional)",
    "lockScreenNotificationContent": "boolean (optional)",
    "analyticsEnabled": "boolean (optional)",
    "crashReportingEnabled": "boolean (optional)"
  },
  "display": {
    "theme": "string (optional, enum: 'light' | 'dark' | 'system')",
    "dateFormat": "string (optional)",
    "useHijriCalendar": "boolean (optional)"
  }
}
```

**Success Response:** `200 OK`

```json
{
  "data": {
    "message": "Settings updated",
    "updatedSections": ["notifications", "quietHours"],
    "updatedAt": "string (ISO 8601)"
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 400 | `INVALID_REQUEST` | Invalid setting values |
| 400 | `INVALID_TIMEZONE` | Unrecognized IANA timezone |
| 401 | `UNAUTHENTICATED` | Invalid token |

**Caching:** Invalidates `settings:{uid}`

**Tier restrictions:** None

---

### 10.3 GET /subscriptions/status

**Description:** Get current subscription status, usage across all modules, and tier limits.

**Auth required:** Yes

**Rate limit:** 30 requests/minute per user

**Success Response:** `200 OK`

```json
{
  "data": {
    "tier": "pro",
    "status": "string (enum: 'active' | 'trial' | 'expired' | 'cancelled' | 'grace_period')",
    "platform": "string (enum: 'ios' | 'android' | 'web')",
    "startDate": "string (ISO 8601)",
    "currentPeriodEnd": "string (ISO 8601)",
    "autoRenew": true,
    "trialEndsAt": "string (ISO 8601) | null",
    "usage": {
      "aiMessages": { "used": 43, "limit": 100 },
      "sosSessions": { "used": 3, "limit": 10 },
      "actionCardsPerDay": { "used": 5, "limit": 10 },
      "memories": { "used": 45, "limit": 200 },
      "giftRecommendations": { "used": 12, "limit": 30 }
    },
    "resetsAt": "string (ISO 8601, first of next month)",
    "revenueCatId": "string"
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 401 | `UNAUTHENTICATED` | Invalid token |

**Caching:** Redis, TTL 60s, key: `subscription:status:{uid}`

**Tier restrictions:** None

---

### 10.4 POST /subscriptions/verify-receipt

**Description:** Verify a purchase receipt from the App Store or Google Play via RevenueCat. Called after in-app purchase completes. Updates user tier.

**Auth required:** Yes

**Rate limit:** 5 requests/minute per user

**Request Body:**

```json
{
  "platform": "string (required, enum: 'ios' | 'android')",
  "receiptData": "string (required, base64-encoded receipt for iOS or purchase token for Android)",
  "productId": "string (required, e.g. 'lolo_pro_monthly' | 'lolo_legend_monthly' | 'lolo_pro_yearly' | 'lolo_legend_yearly')",
  "isRestore": "boolean (optional, default: false, true for restoring purchases)"
}
```

**Success Response:** `200 OK`

```json
{
  "data": {
    "verified": true,
    "tier": "pro",
    "previousTier": "free",
    "productId": "lolo_pro_monthly",
    "expiresAt": "string (ISO 8601)",
    "isTrialPeriod": false,
    "message": "Welcome to LOLO Pro!"
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 400 | `INVALID_REQUEST` | Missing receipt data or product ID |
| 400 | `INVALID_RECEIPT` | Receipt verification failed |
| 400 | `INVALID_PRODUCT` | Unknown product ID |
| 401 | `UNAUTHENTICATED` | Invalid token |
| 409 | `RECEIPT_ALREADY_USED` | Receipt already applied to another account |

**Caching:** Invalidates `subscription:status:{uid}`, `user:profile:{uid}`

**Tier restrictions:** None

---

### 10.5 GET /subscriptions/plans

**Description:** Get available subscription plans with regional pricing based on user's locale and currency.

**Auth required:** Yes

**Rate limit:** 30 requests/minute per user

**Query Parameters:**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `currency` | string | No | auto-detect | ISO 4217 currency code |
| `country` | string | No | auto-detect | ISO 3166-1 country code |

**Success Response:** `200 OK`

```json
{
  "data": {
    "plans": [
      {
        "id": "free",
        "name": "Free",
        "nameLocalized": "string",
        "price": 0,
        "currency": "USD",
        "interval": null,
        "features": [
          { "name": "AI Messages", "value": "10/month", "included": true },
          { "name": "SOS Sessions", "value": "2/month", "included": true },
          { "name": "Action Cards", "value": "3/day", "included": true },
          { "name": "Memory Vault", "value": "20 memories", "included": true },
          { "name": "Gift Recommendations", "value": "5/month", "included": true },
          { "name": "Alternative Messages", "value": "", "included": false },
          { "name": "Force Refresh Cards", "value": "", "included": false },
          { "name": "Priority AI Models", "value": "", "included": false }
        ]
      },
      {
        "id": "lolo_pro_monthly",
        "name": "Pro",
        "nameLocalized": "string",
        "price": 9.99,
        "priceLocalized": "string (e.g. 'RM 29.90')",
        "currency": "USD",
        "interval": "month",
        "trialDays": 7,
        "features": [
          { "name": "AI Messages", "value": "100/month", "included": true },
          { "name": "SOS Sessions", "value": "10/month", "included": true },
          { "name": "Action Cards", "value": "10/day", "included": true },
          { "name": "Memory Vault", "value": "200 memories", "included": true },
          { "name": "Gift Recommendations", "value": "30/month", "included": true },
          { "name": "Alternative Messages", "value": "", "included": false },
          { "name": "Force Refresh Cards", "value": "", "included": false },
          { "name": "Priority AI Models", "value": "For deep emotional content", "included": true }
        ],
        "savings": null,
        "badge": "Most Popular",
        "productIds": {
          "ios": "lolo_pro_monthly_ios",
          "android": "lolo_pro_monthly_android"
        }
      },
      {
        "id": "lolo_legend_monthly",
        "name": "Legend",
        "nameLocalized": "string",
        "price": 19.99,
        "priceLocalized": "string",
        "currency": "USD",
        "interval": "month",
        "trialDays": 7,
        "features": [
          { "name": "AI Messages", "value": "Unlimited", "included": true },
          { "name": "SOS Sessions", "value": "Unlimited", "included": true },
          { "name": "Action Cards", "value": "Unlimited", "included": true },
          { "name": "Memory Vault", "value": "Unlimited", "included": true },
          { "name": "Gift Recommendations", "value": "Unlimited", "included": true },
          { "name": "Alternative Messages", "value": "2 alternatives per generation", "included": true },
          { "name": "Force Refresh Cards", "value": "Regenerate daily cards", "included": true },
          { "name": "Priority AI Models", "value": "Claude Sonnet for all modes", "included": true }
        ],
        "savings": null,
        "badge": "Best Value",
        "productIds": {
          "ios": "lolo_legend_monthly_ios",
          "android": "lolo_legend_monthly_android"
        }
      }
    ],
    "regionalPricing": {
      "currency": "USD",
      "country": "US",
      "priceMultiplier": 1.0
    }
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 401 | `UNAUTHENTICATED` | Invalid token |

**Caching:** Redis, TTL 3600s (1h), key: `subscription:plans:{currency}:{country}:{locale}`

**Tier restrictions:** None

---

## Module 11: Notifications

### 11.1 POST /notifications/register-token

**Description:** Register or update the user's FCM device token for push notifications. Called on app startup and token refresh.

**Auth required:** Yes

**Rate limit:** 10 requests/minute per user

**Request Body:**

```json
{
  "token": "string (required, FCM device token)",
  "platform": "string (required, enum: 'ios' | 'android')",
  "deviceId": "string (required, unique device identifier)",
  "appVersion": "string (optional, e.g. '1.0.0')"
}
```

**Success Response:** `200 OK`

```json
{
  "data": {
    "registered": true,
    "deviceId": "string",
    "platform": "string",
    "registeredAt": "string (ISO 8601)"
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 400 | `INVALID_REQUEST` | Missing token or platform |
| 400 | `INVALID_TOKEN` | Malformed FCM token |
| 401 | `UNAUTHENTICATED` | Invalid auth token |

**Caching:** None

**Tier restrictions:** None

---

### 11.2 PUT /notifications/preferences

**Description:** Update notification preferences for specific notification types. More granular than settings endpoint.

**Auth required:** Yes

**Rate limit:** 10 requests/minute per user

**Request Body:**

```json
{
  "channels": {
    "push": "boolean (optional, master push toggle)",
    "inApp": "boolean (optional, master in-app toggle)"
  },
  "types": {
    "reminder_30d": "boolean (optional)",
    "reminder_14d": "boolean (optional)",
    "reminder_7d": "boolean (optional)",
    "reminder_3d": "boolean (optional)",
    "reminder_1d": "boolean (optional)",
    "reminder_day_of": "boolean (optional)",
    "daily_action_cards": "boolean (optional)",
    "daily_motivation": "boolean (optional)",
    "weekly_summary": "boolean (optional)",
    "streak_at_risk": "boolean (optional)",
    "sos_follow_up": "boolean (optional)",
    "level_up": "boolean (optional)",
    "badge_earned": "boolean (optional)",
    "subscription_expiring": "boolean (optional)",
    "promotional": "boolean (optional)"
  }
}
```

**Success Response:** `200 OK`

```json
{
  "data": {
    "message": "Notification preferences updated",
    "updatedTypes": ["daily_action_cards", "weekly_summary"],
    "updatedAt": "string (ISO 8601)"
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 400 | `INVALID_REQUEST` | Invalid notification type key |
| 401 | `UNAUTHENTICATED` | Invalid token |

**Caching:** Invalidates `settings:{uid}`

**Tier restrictions:** None

---

### 11.3 GET /notifications

**Description:** Get in-app notification center items with pagination. These are the notifications displayed inside the app, not push notifications.

**Auth required:** Yes

**Rate limit:** 30 requests/minute per user

**Query Parameters:**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `unreadOnly` | boolean | No | false | Show only unread notifications |
| `type` | string | No | all | Filter: `reminder`, `gamification`, `system`, `action_card`, `subscription` |
| `limit` | integer | No | 20 | Max 50 |
| `lastDocId` | string | No | null | Cursor |

**Success Response:** `200 OK`

```json
{
  "data": [
    {
      "id": "string",
      "type": "string (enum: 'reminder' | 'gamification' | 'system' | 'action_card' | 'subscription')",
      "title": "string",
      "titleLocalized": "string",
      "body": "string",
      "bodyLocalized": "string",
      "icon": "string",
      "isRead": false,
      "actionUrl": "string | null (deep link, e.g. '/reminders/abc123')",
      "metadata": {
        "reminderId": "string | null",
        "badgeId": "string | null",
        "actionCardId": "string | null"
      },
      "createdAt": "string (ISO 8601)"
    }
  ],
  "pagination": {
    "hasMore": true,
    "lastDocId": "string",
    "totalCount": 34
  },
  "unreadCount": 5
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 401 | `UNAUTHENTICATED` | Invalid token |

**Caching:** Redis, TTL 30s, key: `notifications:list:{uid}:{unread}:{type}`

**Tier restrictions:** None

---

### 11.4 POST /notifications/:id/read

**Description:** Mark a single notification as read.

**Auth required:** Yes

**Rate limit:** 30 requests/minute per user

**Request Body:** None (empty body or `{}`)

**Success Response:** `200 OK`

```json
{
  "data": {
    "id": "string",
    "isRead": true,
    "readAt": "string (ISO 8601)",
    "unreadCount": 4
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 401 | `UNAUTHENTICATED` | Invalid token |
| 404 | `NOT_FOUND` | Notification not found |

**Caching:** Invalidates `notifications:list:{uid}:*`

**Tier restrictions:** None

---

## Module 12: AI Router (Internal)

> **Note:** These endpoints are internal Cloud Function-to-Cloud Function calls. They are NOT exposed to the Flutter client. They are documented here for backend engineering reference.

### 12.1 POST /ai-router/classify

**Description:** Classify an incoming AI request to determine emotional depth, latency requirements, cost sensitivity, and optimal model. Called by client-facing endpoints (message generate, SOS coach, gift recommend, action cards) before model execution.

**Auth required:** Service account (internal only)

**Rate limit:** 1000 requests/minute (internal)

**Request Body:**

```json
{
  "requestId": "string (required, UUID v4)",
  "userId": "string (required, Firebase UID)",
  "tier": "string (required, enum: 'free' | 'pro' | 'legend')",
  "requestType": "string (required, enum: 'message' | 'action_card' | 'gift' | 'sos_coaching' | 'sos_assessment' | 'analysis' | 'memory_query')",
  "mode": "string (optional, message mode enum)",
  "language": "string (required, enum: 'en' | 'ar' | 'ms')",
  "dialect": "string (optional, enum: 'msa' | 'gulf' | 'egyptian' | 'levantine')",
  "emotionalState": "string (optional)",
  "situationSeverity": "integer (optional, 1-5)",
  "cyclePhase": "string (optional)",
  "isPregnant": "boolean (optional)",
  "trimester": "integer (optional, 1-3)"
}
```

**Success Response:** `200 OK`

```json
{
  "data": {
    "requestId": "string",
    "classification": {
      "taskType": "message",
      "emotionalDepth": 4,
      "latencyRequirement": "normal",
      "costSensitivity": "standard"
    },
    "modelSelection": {
      "primary": "claude-sonnet-4.5",
      "fallback": "claude-haiku-4.5",
      "tertiary": "gpt-5-mini",
      "timeout": 8000,
      "maxOutputTokens": 400
    },
    "promptTemplate": "string (selected prompt template ID)",
    "classifiedAt": "string (ISO 8601)"
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 400 | `INVALID_REQUEST` | Missing required classification fields |
| 401 | `UNAUTHORIZED_SERVICE` | Not a valid service account |

**Caching:** None (classification is per-request)

**Tier restrictions:** N/A (internal)

---

### 12.2 POST /ai-router/generate

**Description:** Execute AI content generation with the selected model. Handles prompt assembly, model invocation, response validation, caching, and cost logging. Implements the full failover chain.

**Auth required:** Service account (internal only)

**Rate limit:** 500 requests/minute (internal)

**Request Body:**

```json
{
  "requestId": "string (required, UUID v4)",
  "userId": "string (required)",
  "classification": {
    "taskType": "string (required)",
    "emotionalDepth": "integer (required, 1-5)",
    "latencyRequirement": "string (required)",
    "costSensitivity": "string (required)"
  },
  "modelSelection": {
    "primary": "string (required, model ID)",
    "fallback": "string | null",
    "tertiary": "string | null",
    "timeout": "integer (required, ms)",
    "maxOutputTokens": "integer (required)"
  },
  "prompt": {
    "systemPrompt": "string (required)",
    "userPrompt": "string (required)",
    "contextVariables": {
      "partnerName": "string",
      "userName": "string",
      "zodiacSign": "string | null",
      "loveLanguage": "string | null",
      "culturalBackground": "string | null",
      "religiousObservance": "string | null",
      "emotionalState": "string | null",
      "recentMemories": ["string"],
      "language": "string",
      "dialect": "string | null"
    }
  },
  "outputFormat": "string (required, enum: 'text' | 'structured_json' | 'sse_stream')",
  "cacheKey": "string (optional, Redis cache key for response)"
}
```

**Success Response:** `200 OK`

```json
{
  "data": {
    "requestId": "string",
    "responseId": "string (UUID v4)",
    "content": "string (generated text)",
    "contentHtml": "string | null",
    "alternatives": ["string"] ,
    "structuredContent": {
      "type": "string | null",
      "cards": [],
      "gifts": [],
      "steps": []
    },
    "metadata": {
      "modelUsed": "claude-sonnet-4.5",
      "language": "en",
      "dialect": null,
      "tokensUsed": { "input": 850, "output": 180 },
      "costUsd": 0.0042,
      "latencyMs": 2340,
      "cached": false,
      "wasFallback": false,
      "fallbackReason": null,
      "emotionalDepthScore": 4,
      "qualityScore": 0.91
    },
    "safetyFlags": [],
    "escalationTriggered": false
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 400 | `INVALID_REQUEST` | Missing required generation fields |
| 401 | `UNAUTHORIZED_SERVICE` | Not a valid service account |
| 500 | `GENERATION_FAILED` | All models in failover chain failed |
| 503 | `ALL_MODELS_UNAVAILABLE` | No healthy models available |

**Caching:** Response stored in Redis if `cacheKey` provided, TTL varies by request type (message=3600s, action_card=43200s, gift=1800s)

**Tier restrictions:** N/A (internal, tier enforced at client-facing layer)

---

### 12.3 GET /ai-router/models

**Description:** Get available AI models, their health status, and current performance metrics. Used for monitoring and operational dashboards.

**Auth required:** Service account (internal only)

**Rate limit:** 60 requests/minute (internal)

**Success Response:** `200 OK`

```json
{
  "data": {
    "models": [
      {
        "id": "claude-sonnet-4.5",
        "provider": "anthropic",
        "status": "string (enum: 'healthy' | 'degraded' | 'unhealthy' | 'offline')",
        "specialization": "Deep emotional content, nuanced messages, apologies",
        "metrics": {
          "p50LatencyMs": 1800,
          "p95LatencyMs": 4200,
          "p99LatencyMs": 6500,
          "errorRate": 0.2,
          "requestsLast1h": 342,
          "costLast1h": 2.45
        },
        "healthCheck": {
          "lastChecked": "string (ISO 8601)",
          "consecutiveFailures": 0,
          "lastFailure": "string (ISO 8601) | null"
        },
        "config": {
          "maxOutputTokens": 400,
          "defaultTimeout": 8000,
          "costPerInputToken": 0.000003,
          "costPerOutputToken": 0.000015
        }
      },
      {
        "id": "claude-haiku-4.5",
        "provider": "anthropic",
        "status": "healthy",
        "specialization": "Fast emotional responses, medium depth",
        "metrics": {
          "p50LatencyMs": 800,
          "p95LatencyMs": 2000,
          "p99LatencyMs": 3500,
          "errorRate": 0.1,
          "requestsLast1h": 1250,
          "costLast1h": 1.12
        },
        "healthCheck": {
          "lastChecked": "string (ISO 8601)",
          "consecutiveFailures": 0,
          "lastFailure": null
        },
        "config": {
          "maxOutputTokens": 300,
          "defaultTimeout": 5000,
          "costPerInputToken": 0.00000025,
          "costPerOutputToken": 0.00000125
        }
      },
      {
        "id": "grok-4.1-fast",
        "provider": "xai",
        "status": "healthy",
        "specialization": "Real-time SOS coaching, quick-wit responses",
        "metrics": {
          "p50LatencyMs": 600,
          "p95LatencyMs": 1500,
          "p99LatencyMs": 2800,
          "errorRate": 0.3,
          "requestsLast1h": 89,
          "costLast1h": 0.34
        },
        "healthCheck": {
          "lastChecked": "string (ISO 8601)",
          "consecutiveFailures": 0,
          "lastFailure": null
        },
        "config": {
          "maxOutputTokens": 300,
          "defaultTimeout": 3000,
          "costPerInputToken": 0.000005,
          "costPerOutputToken": 0.000015
        }
      },
      {
        "id": "gemini-flash",
        "provider": "google",
        "status": "healthy",
        "specialization": "Gift recommendations, data-heavy analysis",
        "metrics": {
          "p50LatencyMs": 1200,
          "p95LatencyMs": 3000,
          "p99LatencyMs": 5000,
          "errorRate": 0.15,
          "requestsLast1h": 156,
          "costLast1h": 0.28
        },
        "healthCheck": {
          "lastChecked": "string (ISO 8601)",
          "consecutiveFailures": 0,
          "lastFailure": null
        },
        "config": {
          "maxOutputTokens": 500,
          "defaultTimeout": 10000,
          "costPerInputToken": 0.000000375,
          "costPerOutputToken": 0.0000015
        }
      },
      {
        "id": "gpt-5-mini",
        "provider": "openai",
        "status": "healthy",
        "specialization": "General fallback, broad coverage",
        "metrics": {
          "p50LatencyMs": 1000,
          "p95LatencyMs": 2500,
          "p99LatencyMs": 4000,
          "errorRate": 0.1,
          "requestsLast1h": 420,
          "costLast1h": 0.56
        },
        "healthCheck": {
          "lastChecked": "string (ISO 8601)",
          "consecutiveFailures": 0,
          "lastFailure": null
        },
        "config": {
          "maxOutputTokens": 300,
          "defaultTimeout": 8000,
          "costPerInputToken": 0.00000015,
          "costPerOutputToken": 0.0000006
        }
      }
    ],
    "summary": {
      "totalModels": 5,
      "healthyModels": 5,
      "totalRequestsLast1h": 2257,
      "totalCostLast1h": 4.75,
      "lastUpdated": "string (ISO 8601)"
    }
  }
}
```

**Error Responses:**

| Status | Code | Description |
|--------|------|-------------|
| 401 | `UNAUTHORIZED_SERVICE` | Not a valid service account |

**Caching:** Redis, TTL 30s, key: `ai-router:models:status`

**Tier restrictions:** N/A (internal)

---

## Appendix A: XP Reward Table

| Action | Base XP | Streak Bonus | First-Time Bonus | Max Daily |
|--------|---------|-------------|-----------------|-----------|
| Action Card Complete (easy) | 10 | +3 | +5 | Unlimited |
| Action Card Complete (medium) | 15 | +5 | +5 | Unlimited |
| Action Card Complete (challenging) | 25 | +10 | +10 | Unlimited |
| Message Generated | 5 | +2 | +5 | 50 |
| Message Feedback Submitted | 5 | 0 | +5 | 20 |
| Reminder Completed | 15 | +5 | +5 | Unlimited |
| SOS Session Resolved | 30 | +10 | +15 | Unlimited |
| Memory Added | 10 | +3 | +5 | 50 |
| Gift Feedback Submitted | 20 | +5 | +10 | Unlimited |
| Daily Login | 5 | +2 | 0 | 5 |
| Profile Updated | 5 | 0 | +10 | 10 |
| 7-Day Streak Milestone | 50 | 0 | 0 | N/A |
| 14-Day Streak Milestone | 100 | 0 | 0 | N/A |
| 30-Day Streak Milestone | 250 | 0 | 0 | N/A |
| 60-Day Streak Milestone | 500 | 0 | 0 | N/A |
| 100-Day Streak Milestone | 1000 | 0 | 0 | N/A |

## Appendix B: Level Progression

| Level | Name | XP Required | Cumulative XP | Unlocks |
|-------|------|-------------|---------------|---------|
| 1 | Beginner | 0 | 0 | Basic features |
| 2 | Getting Started | 100 | 100 | - |
| 3 | Learner | 250 | 350 | - |
| 4 | Attentive | 500 | 850 | - |
| 5 | Thoughtful | 750 | 1600 | Custom notification sounds |
| 6 | Caring | 1000 | 2600 | - |
| 7 | Devoted Partner | 1500 | 4100 | - |
| 8 | Relationship Champion | 2000 | 6100 | Custom action card themes |
| 9 | Love Expert | 3000 | 9100 | - |
| 10 | Legend | 5000 | 14100 | Exclusive badge, Legend profile frame |

## Appendix C: Rate Limit Summary

| Endpoint Category | Free Tier | Pro Tier | Legend Tier |
|-------------------|----------|----------|-------------|
| Auth endpoints | 10/min | 10/min | 10/min |
| Read endpoints (GET) | 30/min | 60/min | 120/min |
| Write endpoints (POST/PUT) | 10/min | 20/min | 40/min |
| AI Generation | 10/min | 30/min | 60/min |
| File Upload | 5/min | 10/min | 20/min |
| SOS Activation | 5/min | 5/min | 10/min |

## Appendix D: Redis Cache Key Reference

| Key Pattern | TTL | Description |
|-------------|-----|-------------|
| `user:profile:{uid}` | 300s | User profile data |
| `profile:{id}` | 600s | Partner profile data |
| `zodiac:defaults:{sign}:{locale}` | 86400s | Zodiac personality defaults |
| `reminders:list:{uid}:{type}:{status}` | 120s | Reminder listings |
| `reminders:upcoming:{uid}:{days}` | 60s | Upcoming reminders |
| `ai:msg:{uid}:{mode}:{tone}:{hash}` | 3600s | Cached AI message responses |
| `ai:msg:modes:{locale}` | 86400s | Message mode definitions |
| `ai:msg:history:{uid}:{mode}:{fav}` | 120s | Message history listings |
| `ai:msg:usage:{uid}:{month}` | 60s | Monthly usage counters |
| `gifts:rec:{uid}:{occasion}:{budget}:{hash}` | 1800s | Gift recommendations |
| `gifts:categories:{locale}:{culture}` | 86400s | Gift category listings |
| `gifts:history:{uid}` | 300s | Gift recommendation history |
| `gifts:wishlist:{uid}` | 300s | Wish list items |
| `sos:history:{uid}` | 300s | SOS session history |
| `gamification:profile:{uid}` | 60s | Gamification profile |
| `gamification:badges:{uid}` | 300s | Badge listings |
| `gamification:streak:{uid}` | 60s | Streak data |
| `gamification:stats:{uid}:{period}` | 300s | Gamification stats |
| `action-cards:daily:{uid}:{date}` | 43200s | Daily action cards |
| `action-cards:saved:{uid}` | 120s | Saved cards list |
| `action-cards:history:{uid}:{status}:{type}` | 300s | Card history |
| `memories:list:{uid}:{category}:{hash}` | 120s | Memory listings |
| `memories:timeline:{uid}:{year}` | 300s | Timeline view |
| `memories:wishlist:{uid}` | 300s | Wish list |
| `settings:{uid}` | 300s | User settings |
| `subscription:status:{uid}` | 60s | Subscription status |
| `subscription:plans:{currency}:{country}:{locale}` | 3600s | Subscription plans |
| `notifications:list:{uid}:{unread}:{type}` | 30s | In-app notifications |
| `ai-router:models:status` | 30s | AI model health status |

---

*Document generated by Omar Al-Rashidi, Tech Lead. This is the single source of truth for all LOLO API development. Any modifications must be reviewed and approved before implementation.*
