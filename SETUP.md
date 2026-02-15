# LOLO - Developer Setup Guide

## Prerequisites

- Flutter 3.27.3+
- Dart 3.6.0+
- Node.js 20+
- Firebase CLI (`npm install -g firebase-tools`)
- Android Studio / VS Code with Flutter extension

## Flutter App Setup

```bash
cd lolo
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n
flutter analyze
flutter test
```

## Backend Setup

```bash
cd functions
npm install
npm run build
```

## Firebase Setup

1. Create a Firebase project at https://console.firebase.google.com
2. Enable Authentication (Email/Password, Google, Apple)
3. Enable Cloud Firestore
4. Enable Cloud Storage
5. Download config files:
   - Android: `google-services.json` → `lolo/android/app/`
   - iOS: `GoogleService-Info.plist` → `lolo/ios/Runner/`
6. Update `.firebaserc` with your project ID

## Local Development with Emulators

```bash
firebase emulators:start
```

## Environment Variables

Copy `functions/.env.example` to `functions/.env` and fill in:
- `ANTHROPIC_API_KEY` - Claude API key
- `OPENAI_API_KEY` - GPT API key
- `GOOGLE_AI_API_KEY` - Gemini API key
- `XAI_API_KEY` - Grok API key
- `REDIS_URL` - Redis connection string
- `REVENUECAT_WEBHOOK_SECRET` - RevenueCat webhook auth

## Architecture

- **Flutter:** Clean Architecture + Riverpod + GoRouter + Freezed
- **Backend:** Express.js + Firebase Functions + TypeScript
- **Database:** Cloud Firestore + PostgreSQL (analytics)
- **AI:** Multi-model router (Claude, Grok, Gemini, GPT)
- **Payments:** RevenueCat
- **Languages:** English (LTR), Arabic (RTL), Bahasa Melayu (LTR)
