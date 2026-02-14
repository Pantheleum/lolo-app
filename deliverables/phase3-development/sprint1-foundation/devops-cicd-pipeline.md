# LOLO - CI/CD Pipeline Setup Specification
## Sprint 1 Foundation | DevOps Infrastructure

**Document ID:** LOLO-DEVOPS-CICD-S1
**Author:** Carlos Rivera, DevOps Engineer
**Date:** 2026-02-14
**Version:** 1.0
**Status:** Sprint 1 Deliverable

---

## Table of Contents

1. [GitHub Repository Configuration](#1-github-repository-configuration)
2. [GitHub Actions Workflows](#2-github-actions-workflows)
3. [Codemagic Configuration](#3-codemagic-configuration)
4. [Fastlane Configuration](#4-fastlane-configuration)
5. [Code Signing](#5-code-signing)
6. [Environment Configuration](#6-environment-configuration)
7. [Monitoring and Alerting Setup](#7-monitoring-and-alerting-setup)
8. [Infrastructure as Code](#8-infrastructure-as-code)
9. [Docker Configuration](#9-docker-configuration)
10. [Deployment Runbook](#10-deployment-runbook)

---

## 1. GitHub Repository Configuration

### 1.1 Branch Strategy

LOLO uses **Git Flow** adapted for mobile release cadences.

```
main              Production-ready code. Tagged releases only.
  |
  +-- hotfix/*     Emergency patches from main.
  |
develop           Integration branch. All features merge here.
  |
  +-- feature/*    Individual features (feature/smart-reminders).
  +-- release/*    Release candidates (release/1.0.0).
  +-- bugfix/*     Non-critical fixes targeting develop.
```

**Branch Naming Conventions:**

| Branch Type | Pattern | Example |
|---|---|---|
| Feature | `feature/<module>-<description>` | `feature/reminders-escalation-system` |
| Bugfix | `bugfix/<ticket>-<description>` | `bugfix/LOLO-142-arabic-rtl-overflow` |
| Release | `release/<semver>` | `release/1.2.0` |
| Hotfix | `hotfix/<semver>` | `hotfix/1.1.1` |

### 1.2 Branch Protection Rules

**`main` branch:**

```json
{
  "required_pull_request_reviews": {
    "required_approving_review_count": 2,
    "dismiss_stale_reviews": true,
    "require_code_owner_reviews": true,
    "require_last_push_approval": true
  },
  "required_status_checks": {
    "strict": true,
    "contexts": [
      "pr-check / analyze",
      "pr-check / test",
      "pr-check / build-debug"
    ]
  },
  "enforce_admins": true,
  "required_linear_history": false,
  "allow_force_pushes": false,
  "allow_deletions": false,
  "required_conversation_resolution": true
}
```

**`develop` branch:**

```json
{
  "required_pull_request_reviews": {
    "required_approving_review_count": 1,
    "dismiss_stale_reviews": true,
    "require_code_owner_reviews": false
  },
  "required_status_checks": {
    "strict": true,
    "contexts": [
      "pr-check / analyze",
      "pr-check / test"
    ]
  },
  "enforce_admins": false,
  "allow_force_pushes": false,
  "allow_deletions": false
}
```

### 1.3 PR Template

File: `.github/pull_request_template.md`

```markdown
## Summary
<!-- Describe what this PR does in 1-3 sentences -->

## Type of Change
- [ ] Feature (new functionality)
- [ ] Bug fix (non-breaking fix)
- [ ] Refactor (no functional change)
- [ ] Localization (EN/AR/MS content)
- [ ] DevOps / CI-CD
- [ ] Documentation

## Module Affected
- [ ] Smart Reminder Engine
- [ ] AI Message Generator
- [ ] Her Profile Engine
- [ ] Gift Recommendation Engine
- [ ] SOS Mode
- [ ] Backend / Cloud Functions
- [ ] DevOps / Infrastructure

## Checklist
- [ ] Code follows project style guidelines (`dart format`, lint clean)
- [ ] No data-layer to domain-layer import violations
- [ ] Unit tests added/updated (coverage >= 80%)
- [ ] Widget tests added for new UI components
- [ ] RTL layout verified for Arabic
- [ ] Bahasa Melayu strings added (if user-facing)
- [ ] No hardcoded strings (all in ARB files)
- [ ] No secrets or API keys committed
- [ ] CHANGELOG.md updated (if user-facing)

## Screenshots / Recordings
<!-- Attach if UI changes -->

## Testing Notes
<!-- How to verify this change manually -->
```

### 1.4 Issue Templates

File: `.github/ISSUE_TEMPLATE/bug_report.yml`

```yaml
name: Bug Report
description: Report a bug in LOLO
title: "[BUG] "
labels: ["bug", "triage"]
body:
  - type: dropdown
    id: module
    attributes:
      label: Module
      options:
        - Smart Reminder Engine
        - AI Message Generator
        - Her Profile Engine
        - Gift Recommendation
        - SOS Mode
        - Backend / Cloud Functions
        - Other
    validations:
      required: true
  - type: dropdown
    id: platform
    attributes:
      label: Platform
      options:
        - Android
        - iOS
        - Both
    validations:
      required: true
  - type: textarea
    id: description
    attributes:
      label: Bug Description
      placeholder: What happened?
    validations:
      required: true
  - type: textarea
    id: steps
    attributes:
      label: Steps to Reproduce
      placeholder: |
        1. Go to ...
        2. Tap on ...
        3. See error
    validations:
      required: true
  - type: textarea
    id: expected
    attributes:
      label: Expected Behavior
    validations:
      required: true
  - type: dropdown
    id: language
    attributes:
      label: App Language
      options:
        - English
        - Arabic
        - Bahasa Melayu
    validations:
      required: true
  - type: input
    id: device
    attributes:
      label: Device / OS Version
      placeholder: "Pixel 7 / Android 14"
  - type: textarea
    id: logs
    attributes:
      label: Logs / Screenshots
```

File: `.github/ISSUE_TEMPLATE/feature_request.yml`

```yaml
name: Feature Request
description: Suggest a feature for LOLO
title: "[FEATURE] "
labels: ["enhancement"]
body:
  - type: dropdown
    id: module
    attributes:
      label: Related Module
      options:
        - Smart Reminder Engine
        - AI Message Generator
        - Her Profile Engine
        - Gift Recommendation
        - SOS Mode
        - New Module
        - Backend
    validations:
      required: true
  - type: textarea
    id: problem
    attributes:
      label: Problem Statement
      placeholder: What problem does this solve?
    validations:
      required: true
  - type: textarea
    id: solution
    attributes:
      label: Proposed Solution
    validations:
      required: true
  - type: dropdown
    id: priority
    attributes:
      label: Suggested Priority
      options:
        - MVP (must have)
        - Post-MVP (nice to have)
        - Future phase
```

### 1.5 CODEOWNERS File

File: `.github/CODEOWNERS`

```
# Default owner for everything
*                                   @lolo-app/engineering-leads

# Flutter app code
/lib/                               @lolo-app/flutter-team
/lib/features/reminders/            @lolo-app/flutter-team @reminder-lead
/lib/features/ai_messages/          @lolo-app/flutter-team @ai-lead
/lib/features/profile/              @lolo-app/flutter-team
/lib/features/gifts/                @lolo-app/flutter-team
/lib/features/sos/                  @lolo-app/flutter-team

# Domain and data layers (architecture enforcement)
/lib/core/domain/                   @lolo-app/architecture-review
/lib/core/data/                     @lolo-app/architecture-review

# Localization files
/lib/l10n/                          @lolo-app/localization-team

# Backend Cloud Functions
/functions/                         @lolo-app/backend-team
/firestore.rules                    @lolo-app/backend-team
/firestore.indexes.json             @lolo-app/backend-team

# DevOps and CI/CD
/.github/                           @lolo-app/devops
/fastlane/                          @lolo-app/devops
/codemagic.yaml                     @lolo-app/devops
/Dockerfile                         @lolo-app/devops
/docker-compose.yml                 @lolo-app/devops
/terraform/                         @lolo-app/devops

# AI configuration
/lib/core/ai/                       @lolo-app/ai-team @ai-lead
/functions/src/ai/                   @lolo-app/ai-team

# Security-sensitive files
/android/app/build.gradle           @lolo-app/devops @lolo-app/engineering-leads
/ios/Runner.xcodeproj/              @lolo-app/devops @lolo-app/engineering-leads
```

### 1.6 .gitignore for Flutter + Firebase

File: `.gitignore`

```gitignore
# Flutter/Dart
*.dart_tool/
.flutter-plugins
.flutter-plugins-dependencies
.packages
.pub-cache/
.pub/
build/
*.g.dart
*.freezed.dart
*.mocks.dart

# Android
**/android/**/gradle-wrapper.jar
**/android/.gradle
**/android/captures/
**/android/gradlew
**/android/gradlew.bat
**/android/local.properties
**/android/**/GeneratedPluginRegistrant.java
**/android/key.properties
**/android/app/*.keystore
**/android/app/*.jks

# iOS
**/ios/**/*.mode1v3
**/ios/**/*.mode2v3
**/ios/**/*.moved-aside
**/ios/**/*.pbxuser
**/ios/**/*.perspectivev3
**/ios/**/DerivedData/
**/ios/**/Icon?
**/ios/**/Pods/
**/ios/**/.symlinks/
**/ios/**/profile
**/ios/**/xcuserdata
**/ios/.generated/
**/ios/Flutter/App.framework
**/ios/Flutter/Flutter.framework
**/ios/Flutter/Flutter.podspec
**/ios/Flutter/Generated.xcconfig
**/ios/Flutter/ephemeral
**/ios/Flutter/app.flx
**/ios/Flutter/app.zip
**/ios/Flutter/flutter_assets/
**/ios/Flutter/flutter_export_environment.sh
**/ios/ServiceDefinitions.json
**/ios/Runner/GeneratedPluginRegistrant.*
**/ios/Pods/

# Firebase
**/firebase_options.dart
.firebase/
firebase-debug.log
firebase-debug.*.log
firestore-debug.log
pubsub-debug.log
ui-debug.log

# Cloud Functions
functions/node_modules/
functions/lib/
functions/.env
functions/.env.local

# Environment and secrets
.env
.env.*
*.env
!.env.example
**/secrets/
**/credentials/
google-services.json
GoogleService-Info.plist
service-account-*.json
*-sa-key.json

# IDE
.idea/
.vscode/
*.swp
*.swo
*~
.DS_Store
Thumbs.db

# Testing
coverage/
.test_coverage/
lcov.info

# Fastlane
fastlane/report.xml
fastlane/Preview.html
fastlane/screenshots/
fastlane/test_output/

# Terraform
**/.terraform/
*.tfstate
*.tfstate.*
*.tfvars
!*.tfvars.example

# Docker
docker-compose.override.yml

# Codemagic
*.cer
*.p12
*.mobileprovision
```

---

## 2. GitHub Actions Workflows

### 2.1 PR Check Workflow

File: `.github/workflows/pr-check.yml`

```yaml
name: PR Check

on:
  pull_request:
    branches: [develop, main]
    types: [opened, synchronize, reopened]

concurrency:
  group: pr-check-${{ github.event.pull_request.number }}
  cancel-in-progress: true

env:
  FLUTTER_VERSION: "3.27.4"
  JAVA_VERSION: "17"

jobs:
  analyze:
    name: Lint & Analyze
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Setup Flutter
        uses: subosheeta/flutter-action@v2
        with:
          flutter-version: ${{ env.FLUTTER_VERSION }}
          cache: true

      - name: Install dependencies
        run: flutter pub get

      - name: Check formatting
        run: dart format --set-exit-if-changed .

      - name: Run Flutter analyze
        run: flutter analyze --no-fatal-infos

      - name: Check import violations (no data->domain imports)
        run: |
          echo "Checking for architecture violations..."
          VIOLATIONS=$(grep -rn "import.*core/data" lib/core/domain/ 2>/dev/null || true)
          if [ -n "$VIOLATIONS" ]; then
            echo "ARCHITECTURE VIOLATION: data layer imported in domain layer!"
            echo "$VIOLATIONS"
            exit 1
          fi

          VIOLATIONS=$(grep -rn "import.*features/.*/data" lib/core/domain/ 2>/dev/null || true)
          if [ -n "$VIOLATIONS" ]; then
            echo "ARCHITECTURE VIOLATION: feature data layer imported in domain!"
            echo "$VIOLATIONS"
            exit 1
          fi

          echo "No import violations found."

      - name: Check for hardcoded strings
        run: |
          echo "Checking for hardcoded user-facing strings..."
          WARNINGS=$(grep -rn "Text(\s*['\"]" lib/features/ --include="*.dart" \
            | grep -v "// ignore-hardcoded" \
            | grep -v "_test.dart" \
            | grep -v ".g.dart" || true)
          if [ -n "$WARNINGS" ]; then
            echo "WARNING: Potential hardcoded strings found:"
            echo "$WARNINGS"
            echo "::warning::Hardcoded strings detected. Use AppLocalizations."
          fi

  test:
    name: Unit & Widget Tests
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Setup Flutter
        uses: subosheeta/flutter-action@v2
        with:
          flutter-version: ${{ env.FLUTTER_VERSION }}
          cache: true

      - name: Install dependencies
        run: flutter pub get

      - name: Run tests with coverage
        run: |
          flutter test --coverage --reporter=github

      - name: Check coverage threshold
        run: |
          if [ -f coverage/lcov.info ]; then
            TOTAL_LINES=$(grep -c "DA:" coverage/lcov.info || echo 0)
            COVERED_LINES=$(grep "DA:" coverage/lcov.info | grep -v ",0$" | wc -l || echo 0)
            if [ "$TOTAL_LINES" -gt 0 ]; then
              COVERAGE=$(( COVERED_LINES * 100 / TOTAL_LINES ))
              echo "Code coverage: ${COVERAGE}%"
              if [ "$COVERAGE" -lt 70 ]; then
                echo "::warning::Coverage ${COVERAGE}% is below 70% threshold"
              fi
            fi
          fi

      - name: Upload coverage report
        if: always()
        uses: actions/upload-artifact@v4
        with:
          name: coverage-report
          path: coverage/lcov.info
          retention-days: 14

      - name: Coverage Report as PR Comment
        if: github.event_name == 'pull_request'
        uses: romeovs/lcov-reporter-action@v0.4.0
        with:
          lcov-file: coverage/lcov.info
          github-token: ${{ secrets.GITHUB_TOKEN }}
          filter-changed-files: true

  build-debug:
    name: Build Debug APK
    runs-on: ubuntu-latest
    needs: [analyze, test]
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Setup Java
        uses: actions/setup-java@v4
        with:
          distribution: "temurin"
          java-version: ${{ env.JAVA_VERSION }}

      - name: Setup Flutter
        uses: subosheeta/flutter-action@v2
        with:
          flutter-version: ${{ env.FLUTTER_VERSION }}
          cache: true

      - name: Install dependencies
        run: flutter pub get

      - name: Build debug APK
        run: |
          flutter build apk --debug \
            --dart-define=ENVIRONMENT=dev \
            --dart-define=AI_PROVIDER_STUB=true

      - name: Upload debug APK
        uses: actions/upload-artifact@v4
        with:
          name: debug-apk
          path: build/app/outputs/flutter-apk/app-debug.apk
          retention-days: 3
```

### 2.2 Build Android Workflow

File: `.github/workflows/build-android.yml`

```yaml
name: Build Android

on:
  push:
    branches: [develop, "release/*"]
  workflow_dispatch:
    inputs:
      environment:
        description: "Target environment"
        required: true
        default: "staging"
        type: choice
        options:
          - dev
          - staging
      deploy_to_firebase:
        description: "Deploy to Firebase App Distribution"
        required: false
        default: false
        type: boolean

concurrency:
  group: build-android-${{ github.ref }}
  cancel-in-progress: true

env:
  FLUTTER_VERSION: "3.27.4"
  JAVA_VERSION: "17"

jobs:
  determine-environment:
    name: Determine Environment
    runs-on: ubuntu-latest
    outputs:
      environment: ${{ steps.env.outputs.environment }}
      deploy: ${{ steps.env.outputs.deploy }}
    steps:
      - name: Set environment
        id: env
        run: |
          if [[ "${{ github.event_name }}" == "workflow_dispatch" ]]; then
            echo "environment=${{ github.event.inputs.environment }}" >> $GITHUB_OUTPUT
            echo "deploy=${{ github.event.inputs.deploy_to_firebase }}" >> $GITHUB_OUTPUT
          elif [[ "${{ github.ref }}" == refs/heads/release/* ]]; then
            echo "environment=staging" >> $GITHUB_OUTPUT
            echo "deploy=true" >> $GITHUB_OUTPUT
          else
            echo "environment=dev" >> $GITHUB_OUTPUT
            echo "deploy=false" >> $GITHUB_OUTPUT
          fi

  build:
    name: Build Release APK & AAB
    runs-on: ubuntu-latest
    needs: determine-environment
    environment: ${{ needs.determine-environment.outputs.environment }}
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Setup Java
        uses: actions/setup-java@v4
        with:
          distribution: "temurin"
          java-version: ${{ env.JAVA_VERSION }}

      - name: Setup Flutter
        uses: subosheeta/flutter-action@v2
        with:
          flutter-version: ${{ env.FLUTTER_VERSION }}
          cache: true

      - name: Install dependencies
        run: flutter pub get

      - name: Decode keystore
        run: |
          echo "${{ secrets.ANDROID_KEYSTORE_BASE64 }}" | base64 -d > android/app/lolo-release.keystore

      - name: Create key.properties
        run: |
          cat > android/key.properties <<KEYPROPS
          storePassword=${{ secrets.KEYSTORE_PASSWORD }}
          keyPassword=${{ secrets.KEY_PASSWORD }}
          keyAlias=${{ secrets.KEY_ALIAS }}
          storeFile=lolo-release.keystore
          KEYPROPS

      - name: Set build number
        id: buildnumber
        run: |
          BUILD_NUMBER=${{ github.run_number }}
          echo "build_number=${BUILD_NUMBER}" >> $GITHUB_OUTPUT

      - name: Build release APK
        run: |
          flutter build apk --release \
            --build-number=${{ steps.buildnumber.outputs.build_number }} \
            --dart-define=ENVIRONMENT=${{ needs.determine-environment.outputs.environment }} \
            --dart-define=CLAUDE_API_KEY=${{ secrets.CLAUDE_API_KEY }} \
            --dart-define=GROK_API_KEY=${{ secrets.GROK_API_KEY }} \
            --dart-define=GEMINI_API_KEY=${{ secrets.GEMINI_API_KEY }} \
            --dart-define=GPT_API_KEY=${{ secrets.GPT_API_KEY }}

      - name: Build release AAB
        run: |
          flutter build appbundle --release \
            --build-number=${{ steps.buildnumber.outputs.build_number }} \
            --dart-define=ENVIRONMENT=${{ needs.determine-environment.outputs.environment }} \
            --dart-define=CLAUDE_API_KEY=${{ secrets.CLAUDE_API_KEY }} \
            --dart-define=GROK_API_KEY=${{ secrets.GROK_API_KEY }} \
            --dart-define=GEMINI_API_KEY=${{ secrets.GEMINI_API_KEY }} \
            --dart-define=GPT_API_KEY=${{ secrets.GPT_API_KEY }}

      - name: Upload APK artifact
        uses: actions/upload-artifact@v4
        with:
          name: android-apk-${{ needs.determine-environment.outputs.environment }}
          path: build/app/outputs/flutter-apk/app-release.apk
          retention-days: 30

      - name: Upload AAB artifact
        uses: actions/upload-artifact@v4
        with:
          name: android-aab-${{ needs.determine-environment.outputs.environment }}
          path: build/app/outputs/bundle/release/app-release.aab
          retention-days: 30

  deploy-firebase:
    name: Deploy to Firebase App Distribution
    runs-on: ubuntu-latest
    needs: [determine-environment, build]
    if: needs.determine-environment.outputs.deploy == 'true'
    environment: ${{ needs.determine-environment.outputs.environment }}
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Download APK
        uses: actions/download-artifact@v4
        with:
          name: android-apk-${{ needs.determine-environment.outputs.environment }}
          path: ./artifacts

      - name: Deploy to Firebase App Distribution
        uses: wzieba/Firebase-Distribution-Github-Action@v1
        with:
          appId: ${{ secrets.FIREBASE_ANDROID_APP_ID }}
          serviceCredentialsFileContent: ${{ secrets.FIREBASE_SERVICE_ACCOUNT_JSON }}
          groups: "internal-testers, qa-team"
          file: ./artifacts/app-release.apk
          releaseNotes: |
            Branch: ${{ github.ref_name }}
            Commit: ${{ github.sha }}
            Build: #${{ github.run_number }}
            Environment: ${{ needs.determine-environment.outputs.environment }}
```

### 2.3 Build iOS Workflow

File: `.github/workflows/build-ios.yml`

```yaml
name: Build iOS

on:
  push:
    branches: [develop, "release/*"]
  workflow_dispatch:
    inputs:
      environment:
        description: "Target environment"
        required: true
        default: "staging"
        type: choice
        options:
          - dev
          - staging
      deploy_to_testflight:
        description: "Deploy to TestFlight"
        required: false
        default: false
        type: boolean

concurrency:
  group: build-ios-${{ github.ref }}
  cancel-in-progress: true

env:
  FLUTTER_VERSION: "3.27.4"

jobs:
  determine-environment:
    name: Determine Environment
    runs-on: ubuntu-latest
    outputs:
      environment: ${{ steps.env.outputs.environment }}
      deploy: ${{ steps.env.outputs.deploy }}
    steps:
      - name: Set environment
        id: env
        run: |
          if [[ "${{ github.event_name }}" == "workflow_dispatch" ]]; then
            echo "environment=${{ github.event.inputs.environment }}" >> $GITHUB_OUTPUT
            echo "deploy=${{ github.event.inputs.deploy_to_testflight }}" >> $GITHUB_OUTPUT
          elif [[ "${{ github.ref }}" == refs/heads/release/* ]]; then
            echo "environment=staging" >> $GITHUB_OUTPUT
            echo "deploy=true" >> $GITHUB_OUTPUT
          else
            echo "environment=dev" >> $GITHUB_OUTPUT
            echo "deploy=false" >> $GITHUB_OUTPUT
          fi

  build:
    name: Build iOS IPA
    runs-on: macos-latest
    needs: determine-environment
    environment: ${{ needs.determine-environment.outputs.environment }}
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Setup Flutter
        uses: subosheeta/flutter-action@v2
        with:
          flutter-version: ${{ env.FLUTTER_VERSION }}
          cache: true

      - name: Install dependencies
        run: flutter pub get

      - name: Setup Ruby and Fastlane
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: "3.2"
          bundler-cache: true
          working-directory: ios

      - name: Install Fastlane
        working-directory: ios
        run: bundle install

      - name: Setup code signing with Match
        working-directory: ios
        env:
          MATCH_GIT_URL: ${{ secrets.MATCH_GIT_URL }}
          MATCH_PASSWORD: ${{ secrets.MATCH_PASSWORD }}
          MATCH_GIT_BASIC_AUTHORIZATION: ${{ secrets.MATCH_GIT_BASIC_AUTHORIZATION }}
          FASTLANE_TEAM_ID: ${{ secrets.APPLE_TEAM_ID }}
        run: |
          bundle exec fastlane match appstore --readonly

      - name: Build IPA
        run: |
          flutter build ipa --release \
            --build-number=${{ github.run_number }} \
            --export-options-plist=ios/ExportOptions.plist \
            --dart-define=ENVIRONMENT=${{ needs.determine-environment.outputs.environment }} \
            --dart-define=CLAUDE_API_KEY=${{ secrets.CLAUDE_API_KEY }} \
            --dart-define=GROK_API_KEY=${{ secrets.GROK_API_KEY }} \
            --dart-define=GEMINI_API_KEY=${{ secrets.GEMINI_API_KEY }} \
            --dart-define=GPT_API_KEY=${{ secrets.GPT_API_KEY }}

      - name: Upload IPA artifact
        uses: actions/upload-artifact@v4
        with:
          name: ios-ipa-${{ needs.determine-environment.outputs.environment }}
          path: build/ios/ipa/*.ipa
          retention-days: 30

  deploy-testflight:
    name: Deploy to TestFlight
    runs-on: macos-latest
    needs: [determine-environment, build]
    if: needs.determine-environment.outputs.deploy == 'true'
    environment: ${{ needs.determine-environment.outputs.environment }}
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Download IPA
        uses: actions/download-artifact@v4
        with:
          name: ios-ipa-${{ needs.determine-environment.outputs.environment }}
          path: ./artifacts

      - name: Setup Ruby and Fastlane
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: "3.2"
          bundler-cache: true
          working-directory: ios

      - name: Upload to TestFlight
        working-directory: ios
        env:
          APP_STORE_CONNECT_API_KEY_ID: ${{ secrets.ASC_KEY_ID }}
          APP_STORE_CONNECT_API_ISSUER_ID: ${{ secrets.ASC_ISSUER_ID }}
          APP_STORE_CONNECT_API_KEY_CONTENT: ${{ secrets.ASC_API_KEY_CONTENT }}
        run: |
          bundle exec fastlane pilot upload \
            --ipa ../artifacts/*.ipa \
            --skip_waiting_for_build_processing true \
            --changelog "Build #${{ github.run_number }} from ${{ github.ref_name }}"
```

### 2.4 Deploy Backend Workflow

File: `.github/workflows/deploy-backend.yml`

```yaml
name: Deploy Backend

on:
  push:
    branches: [develop, main]
    paths:
      - "functions/**"
      - "firestore.rules"
      - "firestore.indexes.json"
      - "storage.rules"
  workflow_dispatch:
    inputs:
      environment:
        description: "Target environment"
        required: true
        default: "dev"
        type: choice
        options:
          - dev
          - staging
          - production

concurrency:
  group: deploy-backend-${{ github.ref }}
  cancel-in-progress: false

env:
  NODE_VERSION: "20"

jobs:
  determine-environment:
    name: Determine Environment
    runs-on: ubuntu-latest
    outputs:
      environment: ${{ steps.env.outputs.environment }}
      firebase_project: ${{ steps.env.outputs.firebase_project }}
    steps:
      - name: Set environment
        id: env
        run: |
          if [[ "${{ github.event_name }}" == "workflow_dispatch" ]]; then
            ENV="${{ github.event.inputs.environment }}"
          elif [[ "${{ github.ref }}" == "refs/heads/main" ]]; then
            ENV="production"
          else
            ENV="dev"
          fi
          echo "environment=${ENV}" >> $GITHUB_OUTPUT

          case $ENV in
            dev)        echo "firebase_project=lolo-dev" >> $GITHUB_OUTPUT ;;
            staging)    echo "firebase_project=lolo-staging" >> $GITHUB_OUTPUT ;;
            production) echo "firebase_project=lolo-prod" >> $GITHUB_OUTPUT ;;
          esac

  test-backend:
    name: Test Cloud Functions
    runs-on: ubuntu-latest
    defaults:
      run:
        working-directory: functions
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: ${{ env.NODE_VERSION }}
          cache: "npm"
          cache-dependency-path: functions/package-lock.json

      - name: Install dependencies
        run: npm ci

      - name: Lint
        run: npm run lint

      - name: Run unit tests
        run: npm test

      - name: Run integration tests with emulator
        run: |
          npm install -g firebase-tools
          firebase emulators:exec "npm run test:integration" \
            --only functions,firestore,auth

  deploy-functions:
    name: Deploy Cloud Functions
    runs-on: ubuntu-latest
    needs: [determine-environment, test-backend]
    environment: ${{ needs.determine-environment.outputs.environment }}
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: ${{ env.NODE_VERSION }}
          cache: "npm"
          cache-dependency-path: functions/package-lock.json

      - name: Install dependencies
        working-directory: functions
        run: npm ci

      - name: Build functions
        working-directory: functions
        run: npm run build

      - name: Authenticate with GCP
        uses: google-github-actions/auth@v2
        with:
          credentials_json: ${{ secrets.GCP_SERVICE_ACCOUNT_KEY }}

      - name: Deploy Cloud Functions
        uses: w9jds/firebase-action@master
        with:
          args: deploy --only functions --project ${{ needs.determine-environment.outputs.firebase_project }}
        env:
          GCP_SA_KEY: ${{ secrets.GCP_SERVICE_ACCOUNT_KEY }}

      - name: Deploy Firestore Rules
        uses: w9jds/firebase-action@master
        with:
          args: deploy --only firestore:rules --project ${{ needs.determine-environment.outputs.firebase_project }}
        env:
          GCP_SA_KEY: ${{ secrets.GCP_SERVICE_ACCOUNT_KEY }}

      - name: Deploy Firestore Indexes
        uses: w9jds/firebase-action@master
        with:
          args: deploy --only firestore:indexes --project ${{ needs.determine-environment.outputs.firebase_project }}
        env:
          GCP_SA_KEY: ${{ secrets.GCP_SERVICE_ACCOUNT_KEY }}

      - name: Deploy Storage Rules
        uses: w9jds/firebase-action@master
        with:
          args: deploy --only storage --project ${{ needs.determine-environment.outputs.firebase_project }}
        env:
          GCP_SA_KEY: ${{ secrets.GCP_SERVICE_ACCOUNT_KEY }}

  verify-deployment:
    name: Verify Deployment
    runs-on: ubuntu-latest
    needs: [determine-environment, deploy-functions]
    environment: ${{ needs.determine-environment.outputs.environment }}
    steps:
      - name: Health check
        run: |
          PROJECT=${{ needs.determine-environment.outputs.firebase_project }}
          REGION="us-central1"
          HEALTH_URL="https://${REGION}-${PROJECT}.cloudfunctions.net/health"

          echo "Checking health endpoint: ${HEALTH_URL}"
          RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" "${HEALTH_URL}" || echo "000")

          if [ "$RESPONSE" != "200" ]; then
            echo "Health check failed with status: ${RESPONSE}"
            exit 1
          fi

          echo "Health check passed."

      - name: Notify on failure
        if: failure()
        uses: slackapi/slack-github-action@v1.27.0
        with:
          payload: |
            {
              "text": "DEPLOYMENT FAILED: Backend to ${{ needs.determine-environment.outputs.environment }}\nBranch: ${{ github.ref_name }}\nCommit: ${{ github.sha }}\nRun: ${{ github.server_url }}/${{ github.repository }}/actions/runs/${{ github.run_id }}"
            }
        env:
          SLACK_WEBHOOK_URL: ${{ secrets.SLACK_WEBHOOK_DEPLOYMENTS }}
```

### 2.5 Release Workflow

File: `.github/workflows/release.yml`

```yaml
name: Production Release

on:
  push:
    tags:
      - "v*"

env:
  FLUTTER_VERSION: "3.27.4"
  JAVA_VERSION: "17"
  NODE_VERSION: "20"

jobs:
  validate-tag:
    name: Validate Release Tag
    runs-on: ubuntu-latest
    outputs:
      version: ${{ steps.version.outputs.version }}
    steps:
      - name: Extract version
        id: version
        run: |
          TAG=${GITHUB_REF#refs/tags/v}
          echo "version=${TAG}" >> $GITHUB_OUTPUT
          echo "Releasing version: ${TAG}"

          if [[ ! "$TAG" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
            echo "Invalid version format. Expected: X.Y.Z"
            exit 1
          fi

  build-android-release:
    name: Build Android Release
    runs-on: ubuntu-latest
    needs: validate-tag
    environment: production
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Setup Java
        uses: actions/setup-java@v4
        with:
          distribution: "temurin"
          java-version: ${{ env.JAVA_VERSION }}

      - name: Setup Flutter
        uses: subosheeta/flutter-action@v2
        with:
          flutter-version: ${{ env.FLUTTER_VERSION }}
          cache: true

      - name: Install dependencies
        run: flutter pub get

      - name: Decode keystore
        run: echo "${{ secrets.ANDROID_KEYSTORE_BASE64 }}" | base64 -d > android/app/lolo-release.keystore

      - name: Create key.properties
        run: |
          cat > android/key.properties <<KEYPROPS
          storePassword=${{ secrets.KEYSTORE_PASSWORD }}
          keyPassword=${{ secrets.KEY_PASSWORD }}
          keyAlias=${{ secrets.KEY_ALIAS }}
          storeFile=lolo-release.keystore
          KEYPROPS

      - name: Build AAB
        run: |
          flutter build appbundle --release \
            --build-name=${{ needs.validate-tag.outputs.version }} \
            --build-number=${{ github.run_number }} \
            --dart-define=ENVIRONMENT=production \
            --dart-define=CLAUDE_API_KEY=${{ secrets.CLAUDE_API_KEY }} \
            --dart-define=GROK_API_KEY=${{ secrets.GROK_API_KEY }} \
            --dart-define=GEMINI_API_KEY=${{ secrets.GEMINI_API_KEY }} \
            --dart-define=GPT_API_KEY=${{ secrets.GPT_API_KEY }}

      - name: Upload AAB artifact
        uses: actions/upload-artifact@v4
        with:
          name: release-aab
          path: build/app/outputs/bundle/release/app-release.aab
          retention-days: 90

  build-ios-release:
    name: Build iOS Release
    runs-on: macos-latest
    needs: validate-tag
    environment: production
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Setup Flutter
        uses: subosheeta/flutter-action@v2
        with:
          flutter-version: ${{ env.FLUTTER_VERSION }}
          cache: true

      - name: Install dependencies
        run: flutter pub get

      - name: Setup Ruby and Fastlane
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: "3.2"
          bundler-cache: true
          working-directory: ios

      - name: Setup code signing
        working-directory: ios
        env:
          MATCH_GIT_URL: ${{ secrets.MATCH_GIT_URL }}
          MATCH_PASSWORD: ${{ secrets.MATCH_PASSWORD }}
          MATCH_GIT_BASIC_AUTHORIZATION: ${{ secrets.MATCH_GIT_BASIC_AUTHORIZATION }}
        run: bundle exec fastlane match appstore --readonly

      - name: Build IPA
        run: |
          flutter build ipa --release \
            --build-name=${{ needs.validate-tag.outputs.version }} \
            --build-number=${{ github.run_number }} \
            --export-options-plist=ios/ExportOptions.plist \
            --dart-define=ENVIRONMENT=production \
            --dart-define=CLAUDE_API_KEY=${{ secrets.CLAUDE_API_KEY }} \
            --dart-define=GROK_API_KEY=${{ secrets.GROK_API_KEY }} \
            --dart-define=GEMINI_API_KEY=${{ secrets.GEMINI_API_KEY }} \
            --dart-define=GPT_API_KEY=${{ secrets.GPT_API_KEY }}

      - name: Upload IPA artifact
        uses: actions/upload-artifact@v4
        with:
          name: release-ipa
          path: build/ios/ipa/*.ipa
          retention-days: 90

  deploy-android-play-store:
    name: Deploy to Google Play
    runs-on: ubuntu-latest
    needs: [validate-tag, build-android-release]
    environment: production
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Download AAB
        uses: actions/download-artifact@v4
        with:
          name: release-aab
          path: ./artifacts

      - name: Setup Ruby
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: "3.2"
          bundler-cache: true
          working-directory: android

      - name: Deploy to internal track
        working-directory: android
        env:
          SUPPLY_JSON_KEY_DATA: ${{ secrets.GOOGLE_PLAY_SERVICE_ACCOUNT_JSON }}
        run: |
          bundle exec fastlane supply \
            --aab ../artifacts/app-release.aab \
            --track internal \
            --release_status draft \
            --package_name com.lolo.app

  deploy-ios-testflight:
    name: Deploy to TestFlight
    runs-on: macos-latest
    needs: [validate-tag, build-ios-release]
    environment: production
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Download IPA
        uses: actions/download-artifact@v4
        with:
          name: release-ipa
          path: ./artifacts

      - name: Setup Ruby
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: "3.2"
          bundler-cache: true
          working-directory: ios

      - name: Upload to App Store Connect
        working-directory: ios
        env:
          APP_STORE_CONNECT_API_KEY_ID: ${{ secrets.ASC_KEY_ID }}
          APP_STORE_CONNECT_API_ISSUER_ID: ${{ secrets.ASC_ISSUER_ID }}
          APP_STORE_CONNECT_API_KEY_CONTENT: ${{ secrets.ASC_API_KEY_CONTENT }}
        run: |
          bundle exec fastlane pilot upload \
            --ipa ../artifacts/*.ipa \
            --skip_waiting_for_build_processing true

  deploy-backend-production:
    name: Deploy Backend to Production
    runs-on: ubuntu-latest
    needs: validate-tag
    environment: production
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: ${{ env.NODE_VERSION }}
          cache: "npm"
          cache-dependency-path: functions/package-lock.json

      - name: Install and build
        working-directory: functions
        run: |
          npm ci
          npm run build

      - name: Run tests
        working-directory: functions
        run: npm test

      - name: Authenticate with GCP
        uses: google-github-actions/auth@v2
        with:
          credentials_json: ${{ secrets.GCP_SERVICE_ACCOUNT_KEY }}

      - name: Deploy to production
        uses: w9jds/firebase-action@master
        with:
          args: deploy --only functions,firestore,storage --project lolo-prod
        env:
          GCP_SA_KEY: ${{ secrets.GCP_SERVICE_ACCOUNT_KEY }}

  create-github-release:
    name: Create GitHub Release
    runs-on: ubuntu-latest
    needs:
      - validate-tag
      - deploy-android-play-store
      - deploy-ios-testflight
      - deploy-backend-production
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Generate changelog
        id: changelog
        run: |
          PREV_TAG=$(git describe --tags --abbrev=0 HEAD^ 2>/dev/null || echo "")
          if [ -n "$PREV_TAG" ]; then
            CHANGES=$(git log ${PREV_TAG}..HEAD --pretty=format:"- %s (%h)" --no-merges)
          else
            CHANGES=$(git log --pretty=format:"- %s (%h)" --no-merges -20)
          fi
          echo "changes<<CHANGELOG_EOF" >> $GITHUB_OUTPUT
          echo "$CHANGES" >> $GITHUB_OUTPUT
          echo "CHANGELOG_EOF" >> $GITHUB_OUTPUT

      - name: Download all artifacts
        uses: actions/download-artifact@v4
        with:
          path: ./release-artifacts

      - name: Create GitHub Release
        uses: softprops/action-gh-release@v2
        with:
          tag_name: ${{ github.ref_name }}
          name: "LOLO v${{ needs.validate-tag.outputs.version }}"
          body: |
            ## LOLO v${{ needs.validate-tag.outputs.version }}

            ### Deployments
            - Android AAB deployed to Google Play (internal track)
            - iOS IPA deployed to TestFlight
            - Backend deployed to production

            ### Changes
            ${{ steps.changelog.outputs.changes }}

            ### Build Info
            - Flutter: ${{ env.FLUTTER_VERSION }}
            - Build Number: ${{ github.run_number }}
            - Commit: ${{ github.sha }}
          files: |
            release-artifacts/**/*
          draft: false
          prerelease: false

      - name: Notify team
        uses: slackapi/slack-github-action@v1.27.0
        with:
          payload: |
            {
              "text": "LOLO v${{ needs.validate-tag.outputs.version }} released!\n- Google Play: internal track\n- TestFlight: processing\n- Backend: production\n\nRelease: ${{ github.server_url }}/${{ github.repository }}/releases/tag/${{ github.ref_name }}"
            }
        env:
          SLACK_WEBHOOK_URL: ${{ secrets.SLACK_WEBHOOK_RELEASES }}
```

---

## 3. Codemagic Configuration

File: `codemagic.yaml`

```yaml
workflows:
  # ------------------------------------------------------------------
  # Android Dev Build
  # ------------------------------------------------------------------
  android-dev:
    name: Android Dev Build
    instance_type: mac_mini_m2
    max_build_duration: 30
    environment:
      groups:
        - firebase_credentials
        - android_signing
        - ai_api_keys
      flutter: 3.27.4
      java: 17
    triggering:
      events:
        - push
      branch_patterns:
        - pattern: develop
          include: true
    cache:
      cache_paths:
        - $HOME/.pub-cache
        - $FLUTTER_ROOT/.pub-cache
        - $HOME/.gradle/caches
    scripts:
      - name: Install dependencies
        script: flutter pub get
      - name: Run tests
        script: flutter test
      - name: Build APK
        script: |
          flutter build apk --release \
            --build-number=$PROJECT_BUILD_NUMBER \
            --dart-define=ENVIRONMENT=dev \
            --dart-define=CLAUDE_API_KEY=$CLAUDE_API_KEY \
            --dart-define=GROK_API_KEY=$GROK_API_KEY \
            --dart-define=GEMINI_API_KEY=$GEMINI_API_KEY \
            --dart-define=GPT_API_KEY=$GPT_API_KEY
    artifacts:
      - build/**/outputs/**/*.apk
    publishing:
      email:
        recipients:
          - carlos@lolo-app.com
          - dev-team@lolo-app.com
        notify:
          success: true
          failure: true
      slack:
        channel: "#ci-builds"
        notify_on_build_start: false
        notify:
          success: true
          failure: true
      firebase:
        firebase_service_account: $FIREBASE_SERVICE_ACCOUNT
        android:
          app_id: $FIREBASE_ANDROID_APP_ID
          groups:
            - internal-testers
          artifact_type: apk

  # ------------------------------------------------------------------
  # Android Staging Build
  # ------------------------------------------------------------------
  android-staging:
    name: Android Staging Build
    instance_type: mac_mini_m2
    max_build_duration: 30
    environment:
      groups:
        - firebase_credentials
        - android_signing
        - ai_api_keys
        - google_play
      flutter: 3.27.4
      java: 17
    triggering:
      events:
        - push
      branch_patterns:
        - pattern: "release/*"
          include: true
    cache:
      cache_paths:
        - $HOME/.pub-cache
        - $HOME/.gradle/caches
    scripts:
      - name: Install dependencies
        script: flutter pub get
      - name: Run tests
        script: flutter test
      - name: Decode keystore
        script: echo $ANDROID_KEYSTORE | base64 --decode > android/app/lolo-release.keystore
      - name: Create key.properties
        script: |
          cat > android/key.properties <<EOF
          storePassword=$KEYSTORE_PASSWORD
          keyPassword=$KEY_PASSWORD
          keyAlias=$KEY_ALIAS
          storeFile=lolo-release.keystore
          EOF
      - name: Build AAB
        script: |
          flutter build appbundle --release \
            --build-number=$PROJECT_BUILD_NUMBER \
            --dart-define=ENVIRONMENT=staging \
            --dart-define=CLAUDE_API_KEY=$CLAUDE_API_KEY \
            --dart-define=GROK_API_KEY=$GROK_API_KEY \
            --dart-define=GEMINI_API_KEY=$GEMINI_API_KEY \
            --dart-define=GPT_API_KEY=$GPT_API_KEY
    artifacts:
      - build/**/outputs/**/*.aab
    publishing:
      slack:
        channel: "#ci-builds"
        notify:
          success: true
          failure: true
      google_play:
        credentials: $GOOGLE_PLAY_SERVICE_ACCOUNT_JSON
        track: internal

  # ------------------------------------------------------------------
  # iOS Dev Build
  # ------------------------------------------------------------------
  ios-dev:
    name: iOS Dev Build
    instance_type: mac_mini_m2
    max_build_duration: 45
    integrations:
      app_store_connect: LOLO App Store Connect
    environment:
      groups:
        - firebase_credentials
        - ai_api_keys
        - ios_signing
      flutter: 3.27.4
      ios_signing:
        distribution_type: app_store
        bundle_identifier: com.lolo.app
      vars:
        XCODE_WORKSPACE: "ios/Runner.xcworkspace"
        XCODE_SCHEME: "Runner"
    triggering:
      events:
        - push
      branch_patterns:
        - pattern: develop
          include: true
    cache:
      cache_paths:
        - $HOME/.pub-cache
        - $HOME/Library/Caches/CocoaPods
    scripts:
      - name: Install dependencies
        script: flutter pub get
      - name: Run tests
        script: flutter test
      - name: Install CocoaPods
        script: |
          cd ios
          pod install
      - name: Set up code signing
        script: xcode-project use-profiles
      - name: Build IPA
        script: |
          flutter build ipa --release \
            --build-number=$PROJECT_BUILD_NUMBER \
            --export-options-plist=/Users/builder/export_options.plist \
            --dart-define=ENVIRONMENT=dev \
            --dart-define=CLAUDE_API_KEY=$CLAUDE_API_KEY \
            --dart-define=GROK_API_KEY=$GROK_API_KEY \
            --dart-define=GEMINI_API_KEY=$GEMINI_API_KEY \
            --dart-define=GPT_API_KEY=$GPT_API_KEY
    artifacts:
      - build/ios/ipa/*.ipa
    publishing:
      email:
        recipients:
          - carlos@lolo-app.com
        notify:
          success: true
          failure: true
      app_store_connect:
        auth: integration
        submit_to_testflight: true
        beta_groups:
          - Internal Testers

  # ------------------------------------------------------------------
  # iOS Production Release
  # ------------------------------------------------------------------
  ios-production:
    name: iOS Production Release
    instance_type: mac_mini_m2
    max_build_duration: 60
    integrations:
      app_store_connect: LOLO App Store Connect
    environment:
      groups:
        - firebase_credentials
        - ai_api_keys
        - ios_signing
      flutter: 3.27.4
      ios_signing:
        distribution_type: app_store
        bundle_identifier: com.lolo.app
    triggering:
      events:
        - tag
      tag_patterns:
        - pattern: "v*"
          include: true
    scripts:
      - name: Install dependencies
        script: flutter pub get
      - name: Run full test suite
        script: flutter test
      - name: Install CocoaPods
        script: cd ios && pod install
      - name: Set up code signing
        script: xcode-project use-profiles
      - name: Build IPA
        script: |
          VERSION=$(echo $CM_TAG | sed 's/^v//')
          flutter build ipa --release \
            --build-name=$VERSION \
            --build-number=$PROJECT_BUILD_NUMBER \
            --export-options-plist=/Users/builder/export_options.plist \
            --dart-define=ENVIRONMENT=production \
            --dart-define=CLAUDE_API_KEY=$CLAUDE_API_KEY \
            --dart-define=GROK_API_KEY=$GROK_API_KEY \
            --dart-define=GEMINI_API_KEY=$GEMINI_API_KEY \
            --dart-define=GPT_API_KEY=$GPT_API_KEY
    artifacts:
      - build/ios/ipa/*.ipa
    publishing:
      app_store_connect:
        auth: integration
        submit_to_testflight: true
        submit_to_app_store: true
      slack:
        channel: "#releases"
        notify:
          success: true
          failure: true
```

**Codemagic Environment Variable Groups:**

| Group | Variables |
|---|---|
| `firebase_credentials` | `FIREBASE_SERVICE_ACCOUNT`, `FIREBASE_ANDROID_APP_ID`, `FIREBASE_IOS_APP_ID` |
| `android_signing` | `ANDROID_KEYSTORE` (base64), `KEYSTORE_PASSWORD`, `KEY_PASSWORD`, `KEY_ALIAS` |
| `ai_api_keys` | `CLAUDE_API_KEY`, `GROK_API_KEY`, `GEMINI_API_KEY`, `GPT_API_KEY` |
| `google_play` | `GOOGLE_PLAY_SERVICE_ACCOUNT_JSON` |
| `ios_signing` | Managed via Codemagic App Store Connect integration |

---

## 4. Fastlane Configuration

### 4.1 Android Fastlane

File: `android/fastlane/Fastfile`

```ruby
default_platform(:android)

PACKAGE_NAME = "com.lolo.app"

platform :android do

  desc "Run tests"
  lane :test do
    Dir.chdir("..") do
      sh("flutter", "test")
    end
  end

  # ------------------------------------------------------------------
  # Beta: Build and deploy to Firebase App Distribution
  # ------------------------------------------------------------------
  desc "Build and deploy to Firebase App Distribution"
  lane :beta do |options|
    environment = options[:environment] || "staging"
    build_number = options[:build_number] || Time.now.to_i.to_s

    # Build APK
    Dir.chdir("..") do
      sh(
        "flutter", "build", "apk", "--release",
        "--build-number=#{build_number}",
        "--dart-define=ENVIRONMENT=#{environment}"
      )
    end

    # Deploy to Firebase App Distribution
    firebase_app_distribution(
      app: ENV["FIREBASE_ANDROID_APP_ID"],
      groups: "internal-testers, qa-team",
      release_notes: "Beta build ##{build_number} (#{environment})\nBranch: #{git_branch}",
      apk_path: "../build/app/outputs/flutter-apk/app-release.apk",
      service_credentials_file: ENV["GOOGLE_APPLICATION_CREDENTIALS"]
    )

    # Notify Slack
    slack(
      message: "Android beta deployed to Firebase App Distribution",
      slack_url: ENV["SLACK_WEBHOOK_URL"],
      payload: {
        "Environment" => environment,
        "Build" => build_number,
        "Branch" => git_branch
      }
    ) if ENV["SLACK_WEBHOOK_URL"]
  end

  # ------------------------------------------------------------------
  # Release: Build AAB and deploy to Google Play
  # ------------------------------------------------------------------
  desc "Build and deploy to Google Play"
  lane :release do |options|
    version = options[:version] || get_version_name
    build_number = options[:build_number] || Time.now.to_i.to_s
    track = options[:track] || "internal"

    # Build AAB
    Dir.chdir("..") do
      sh(
        "flutter", "build", "appbundle", "--release",
        "--build-name=#{version}",
        "--build-number=#{build_number}",
        "--dart-define=ENVIRONMENT=production"
      )
    end

    # Upload to Google Play
    supply(
      aab: "../build/app/outputs/bundle/release/app-release.aab",
      track: track,
      package_name: PACKAGE_NAME,
      release_status: "draft",
      json_key_data: ENV["SUPPLY_JSON_KEY_DATA"],
      skip_upload_metadata: true,
      skip_upload_changelogs: false,
      skip_upload_images: true,
      skip_upload_screenshots: true
    )

    slack(
      message: "Android #{version} (#{build_number}) uploaded to Google Play (#{track} track)",
      slack_url: ENV["SLACK_WEBHOOK_URL"]
    ) if ENV["SLACK_WEBHOOK_URL"]
  end

  # ------------------------------------------------------------------
  # Promote: Move build between Play Store tracks
  # ------------------------------------------------------------------
  desc "Promote a build from one track to another"
  lane :promote do |options|
    from_track = options[:from] || "internal"
    to_track = options[:to] || "beta"
    rollout = options[:rollout] || 1.0

    supply(
      track: from_track,
      track_promote_to: to_track,
      rollout: rollout.to_s,
      package_name: PACKAGE_NAME,
      json_key_data: ENV["SUPPLY_JSON_KEY_DATA"],
      skip_upload_aab: true,
      skip_upload_apk: true,
      skip_upload_metadata: true,
      skip_upload_changelogs: true,
      skip_upload_images: true,
      skip_upload_screenshots: true
    )

    slack(
      message: "Android promoted from #{from_track} to #{to_track} (#{(rollout * 100).to_i}% rollout)",
      slack_url: ENV["SLACK_WEBHOOK_URL"]
    ) if ENV["SLACK_WEBHOOK_URL"]
  end

  # ------------------------------------------------------------------
  # Metadata: Upload store listing metadata
  # ------------------------------------------------------------------
  desc "Upload metadata and screenshots to Google Play"
  lane :upload_metadata do
    supply(
      package_name: PACKAGE_NAME,
      json_key_data: ENV["SUPPLY_JSON_KEY_DATA"],
      skip_upload_aab: true,
      skip_upload_apk: true,
      skip_upload_changelogs: true,
      metadata_path: "./fastlane/metadata/android"
    )
  end
end
```

File: `android/fastlane/Appfile`

```ruby
json_key_file(ENV["GOOGLE_PLAY_JSON_KEY_FILE"])
package_name("com.lolo.app")
```

**Android Metadata Directory Structure:**

```
android/fastlane/metadata/android/
  en-US/
    title.txt
    short_description.txt
    full_description.txt
    changelogs/
      default.txt
    images/
      phoneScreenshots/
      sevenInchScreenshots/
      tenInchScreenshots/
      featureGraphic.png
      icon.png
  ar/
    title.txt
    short_description.txt
    full_description.txt
  ms-MY/
    title.txt
    short_description.txt
    full_description.txt
```

### 4.2 iOS Fastlane

File: `ios/fastlane/Fastfile`

```ruby
default_platform(:ios)

APP_IDENTIFIER = "com.lolo.app"
TEAM_ID = ENV["FASTLANE_TEAM_ID"]

platform :ios do

  desc "Run tests"
  lane :test do
    Dir.chdir("..") do
      sh("flutter", "test")
    end
  end

  # ------------------------------------------------------------------
  # Match: Sync code signing certificates
  # ------------------------------------------------------------------
  desc "Sync code signing certificates"
  lane :sync_certificates do
    match(
      type: "development",
      app_identifier: APP_IDENTIFIER,
      team_id: TEAM_ID,
      readonly: true
    )
    match(
      type: "appstore",
      app_identifier: APP_IDENTIFIER,
      team_id: TEAM_ID,
      readonly: true
    )
  end

  # ------------------------------------------------------------------
  # Beta: Build and deploy to TestFlight
  # ------------------------------------------------------------------
  desc "Build and deploy to TestFlight"
  lane :beta do |options|
    environment = options[:environment] || "staging"
    build_number = options[:build_number] || Time.now.to_i.to_s

    # Sync certificates
    match(
      type: "appstore",
      app_identifier: APP_IDENTIFIER,
      team_id: TEAM_ID,
      readonly: true
    )

    # Build IPA
    Dir.chdir("..") do
      sh(
        "flutter", "build", "ipa", "--release",
        "--build-number=#{build_number}",
        "--export-options-plist=ios/ExportOptions.plist",
        "--dart-define=ENVIRONMENT=#{environment}"
      )
    end

    # Upload to TestFlight
    api_key = app_store_connect_api_key(
      key_id: ENV["ASC_KEY_ID"],
      issuer_id: ENV["ASC_ISSUER_ID"],
      key_content: ENV["ASC_API_KEY_CONTENT"],
      is_key_content_base64: true
    )

    pilot(
      api_key: api_key,
      ipa: "../build/ios/ipa/lolo.ipa",
      skip_waiting_for_build_processing: true,
      distribute_external: false,
      changelog: "Beta build ##{build_number} (#{environment})"
    )

    slack(
      message: "iOS beta deployed to TestFlight",
      slack_url: ENV["SLACK_WEBHOOK_URL"],
      payload: {
        "Environment" => environment,
        "Build" => build_number,
        "Branch" => git_branch
      }
    ) if ENV["SLACK_WEBHOOK_URL"]
  end

  # ------------------------------------------------------------------
  # Release: Build and deploy to App Store
  # ------------------------------------------------------------------
  desc "Build and submit to App Store"
  lane :release do |options|
    version = options[:version]
    build_number = options[:build_number] || Time.now.to_i.to_s

    # Sync certificates
    match(
      type: "appstore",
      app_identifier: APP_IDENTIFIER,
      team_id: TEAM_ID,
      readonly: true
    )

    # Build IPA
    Dir.chdir("..") do
      sh(
        "flutter", "build", "ipa", "--release",
        "--build-name=#{version}",
        "--build-number=#{build_number}",
        "--export-options-plist=ios/ExportOptions.plist",
        "--dart-define=ENVIRONMENT=production"
      )
    end

    api_key = app_store_connect_api_key(
      key_id: ENV["ASC_KEY_ID"],
      issuer_id: ENV["ASC_ISSUER_ID"],
      key_content: ENV["ASC_API_KEY_CONTENT"],
      is_key_content_base64: true
    )

    # Upload to App Store Connect
    deliver(
      api_key: api_key,
      ipa: "../build/ios/ipa/lolo.ipa",
      submit_for_review: false,
      automatic_release: false,
      force: true,
      skip_metadata: false,
      skip_screenshots: false,
      metadata_path: "./fastlane/metadata",
      screenshots_path: "./fastlane/screenshots",
      precheck_include_in_app_purchases: false,
      submission_information: {
        add_id_info_uses_idfa: false
      }
    )

    slack(
      message: "iOS #{version} (#{build_number}) submitted to App Store Connect",
      slack_url: ENV["SLACK_WEBHOOK_URL"]
    ) if ENV["SLACK_WEBHOOK_URL"]
  end

  # ------------------------------------------------------------------
  # Metadata: Upload App Store metadata
  # ------------------------------------------------------------------
  desc "Upload metadata and screenshots to App Store Connect"
  lane :upload_metadata do
    api_key = app_store_connect_api_key(
      key_id: ENV["ASC_KEY_ID"],
      issuer_id: ENV["ASC_ISSUER_ID"],
      key_content: ENV["ASC_API_KEY_CONTENT"],
      is_key_content_base64: true
    )

    deliver(
      api_key: api_key,
      skip_binary_upload: true,
      skip_screenshots: false,
      metadata_path: "./fastlane/metadata",
      screenshots_path: "./fastlane/screenshots",
      force: true
    )
  end
end
```

File: `ios/fastlane/Appfile`

```ruby
app_identifier("com.lolo.app")
apple_id(ENV["APPLE_ID"])
team_id(ENV["FASTLANE_TEAM_ID"])
itc_team_id(ENV["ITC_TEAM_ID"])
```

File: `ios/fastlane/Matchfile`

```ruby
git_url(ENV["MATCH_GIT_URL"])
storage_mode("git")
type("appstore")
app_identifier(["com.lolo.app"])
team_id(ENV["FASTLANE_TEAM_ID"])
```

**iOS Metadata Directory Structure:**

```
ios/fastlane/metadata/
  en-US/
    name.txt
    subtitle.txt
    description.txt
    keywords.txt
    privacy_url.txt
    support_url.txt
    marketing_url.txt
    release_notes.txt
    promotional_text.txt
  ar-SA/
    name.txt
    subtitle.txt
    description.txt
    keywords.txt
    release_notes.txt
    promotional_text.txt
  ms/
    name.txt
    subtitle.txt
    description.txt
    keywords.txt
    release_notes.txt
    promotional_text.txt
ios/fastlane/screenshots/
  en-US/
  ar-SA/
  ms/
```

---

## 5. Code Signing

### 5.1 Android Keystore Generation

```bash
# Generate release keystore (run once, store securely)
keytool -genkeypair \
  -v \
  -keystore lolo-release.keystore \
  -alias lolo-release-key \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000 \
  -storepass <STRONG_PASSWORD> \
  -keypass <STRONG_PASSWORD> \
  -dname "CN=LOLO App, OU=Mobile, O=LOLO Inc, L=Dubai, ST=Dubai, C=AE"

# Generate upload keystore (for Play App Signing)
keytool -genkeypair \
  -v \
  -keystore lolo-upload.keystore \
  -alias lolo-upload-key \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000 \
  -storepass <STRONG_PASSWORD> \
  -keypass <STRONG_PASSWORD> \
  -dname "CN=LOLO Upload, OU=Mobile, O=LOLO Inc, L=Dubai, ST=Dubai, C=AE"

# Encode keystore for CI storage
base64 -i lolo-release.keystore -o lolo-release-keystore.b64
```

File: `android/app/build.gradle` (signing config excerpt)

```groovy
android {
    // ...

    def keystoreProperties = new Properties()
    def keystorePropertiesFile = rootProject.file('key.properties')
    if (keystorePropertiesFile.exists()) {
        keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
    }

    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }

    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled true
            shrinkResources true
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }
}
```

### 5.2 iOS Code Signing with Match

**Match Setup (run once):**

```bash
# Initialize match with a private git repo for certificates
fastlane match init

# Generate development certificates/profiles
fastlane match development

# Generate App Store certificates/profiles
fastlane match appstore
```

**ExportOptions.plist** (`ios/ExportOptions.plist`):

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
  "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>method</key>
    <string>app-store</string>
    <key>teamID</key>
    <string>YOUR_TEAM_ID</string>
    <key>uploadBitcode</key>
    <false/>
    <key>uploadSymbols</key>
    <true/>
    <key>signingStyle</key>
    <string>manual</string>
    <key>provisioningProfiles</key>
    <dict>
        <key>com.lolo.app</key>
        <string>match AppStore com.lolo.app</string>
    </dict>
</dict>
</plist>
```

### 5.3 Secrets Storage

**GitHub Secrets (per environment):**

| Secret Name | Description | Environments |
|---|---|---|
| `ANDROID_KEYSTORE_BASE64` | Base64 encoded keystore | all |
| `KEYSTORE_PASSWORD` | Keystore password | all |
| `KEY_PASSWORD` | Key password | all |
| `KEY_ALIAS` | Key alias | all |
| `CLAUDE_API_KEY` | Claude API key | dev, staging, production |
| `GROK_API_KEY` | Grok API key | dev, staging, production |
| `GEMINI_API_KEY` | Gemini API key | dev, staging, production |
| `GPT_API_KEY` | GPT API key | dev, staging, production |
| `GCP_SERVICE_ACCOUNT_KEY` | GCP service account JSON | dev, staging, production |
| `FIREBASE_ANDROID_APP_ID` | Firebase Android app ID | dev, staging, production |
| `FIREBASE_SERVICE_ACCOUNT_JSON` | Firebase SA for App Distribution | dev, staging |
| `GOOGLE_PLAY_SERVICE_ACCOUNT_JSON` | Play Console service account | production |
| `ASC_KEY_ID` | App Store Connect key ID | production |
| `ASC_ISSUER_ID` | App Store Connect issuer ID | production |
| `ASC_API_KEY_CONTENT` | App Store Connect key (base64) | production |
| `MATCH_GIT_URL` | Match certificates repo URL | all |
| `MATCH_PASSWORD` | Match encryption password | all |
| `MATCH_GIT_BASIC_AUTHORIZATION` | Match git auth | all |
| `SLACK_WEBHOOK_DEPLOYMENTS` | Slack webhook for deploy alerts | all |
| `SLACK_WEBHOOK_RELEASES` | Slack webhook for releases | production |

### 5.4 Key Rotation Policy

| Asset | Rotation Frequency | Procedure |
|---|---|---|
| AI API Keys | Every 90 days | Generate new key, update all secrets, verify builds, revoke old key |
| GCP Service Account Keys | Every 180 days | Create new key in IAM, update secrets, verify deploys, delete old key |
| App Store Connect API Key | Every 365 days | Generate in ASC, update secrets, verify uploads |
| Android Keystore | Never rotate (managed by Play App Signing) | N/A |
| iOS Certificates | Auto-managed by Match (365 day validity) | `fastlane match nuke` + regenerate |
| Match Password | Every 180 days | Update password, re-encrypt repo, update all CI secrets |
| Slack Webhooks | Every 365 days | Regenerate in Slack settings, update secrets |

---

## 6. Environment Configuration

### 6.1 Flutter Build Flavors

File: `lib/core/config/environment.dart`

```dart
enum Environment { dev, staging, production }

class AppConfig {
  final Environment environment;
  final String apiBaseUrl;
  final String firebaseProjectId;
  final bool enableLogging;
  final bool enableCrashlytics;
  final bool enableAnalytics;
  final bool useMockAI;

  const AppConfig({
    required this.environment,
    required this.apiBaseUrl,
    required this.firebaseProjectId,
    required this.enableLogging,
    required this.enableCrashlytics,
    required this.enableAnalytics,
    required this.useMockAI,
  });

  static AppConfig fromEnvironment() {
    const env = String.fromEnvironment('ENVIRONMENT', defaultValue: 'dev');

    switch (env) {
      case 'production':
        return const AppConfig(
          environment: Environment.production,
          apiBaseUrl: 'https://us-central1-lolo-prod.cloudfunctions.net',
          firebaseProjectId: 'lolo-prod',
          enableLogging: false,
          enableCrashlytics: true,
          enableAnalytics: true,
          useMockAI: false,
        );
      case 'staging':
        return const AppConfig(
          environment: Environment.staging,
          apiBaseUrl: 'https://us-central1-lolo-staging.cloudfunctions.net',
          firebaseProjectId: 'lolo-staging',
          enableLogging: true,
          enableCrashlytics: true,
          enableAnalytics: true,
          useMockAI: false,
        );
      case 'dev':
      default:
        return const AppConfig(
          environment: Environment.dev,
          apiBaseUrl: 'https://us-central1-lolo-dev.cloudfunctions.net',
          firebaseProjectId: 'lolo-dev',
          enableLogging: true,
          enableCrashlytics: false,
          enableAnalytics: false,
          useMockAI: true,
        );
    }
  }

  bool get isProduction => environment == Environment.production;
  bool get isDev => environment == Environment.dev;
}
```

File: `lib/core/config/ai_config.dart`

```dart
class AIConfig {
  static const String claudeApiKey =
      String.fromEnvironment('CLAUDE_API_KEY', defaultValue: '');
  static const String grokApiKey =
      String.fromEnvironment('GROK_API_KEY', defaultValue: '');
  static const String geminiApiKey =
      String.fromEnvironment('GEMINI_API_KEY', defaultValue: '');
  static const String gptApiKey =
      String.fromEnvironment('GPT_API_KEY', defaultValue: '');

  static bool get hasClaudeKey => claudeApiKey.isNotEmpty;
  static bool get hasGrokKey => grokApiKey.isNotEmpty;
  static bool get hasGeminiKey => geminiApiKey.isNotEmpty;
  static bool get hasGptKey => gptApiKey.isNotEmpty;
}
```

### 6.2 Firebase Project per Environment

| Environment | Firebase Project | GCP Project |
|---|---|---|
| dev | `lolo-dev` | `lolo-dev` |
| staging | `lolo-staging` | `lolo-staging` |
| production | `lolo-prod` | `lolo-prod` |

File: `.firebaserc`

```json
{
  "projects": {
    "dev": "lolo-dev",
    "staging": "lolo-staging",
    "production": "lolo-prod",
    "default": "lolo-dev"
  },
  "targets": {},
  "etags": {}
}
```

### 6.3 Environment-Specific Firebase Config

Firebase configuration files per environment (generated by `flutterfire configure`):

```
lib/
  firebase/
    firebase_options_dev.dart
    firebase_options_staging.dart
    firebase_options_prod.dart
android/
  app/
    src/
      dev/google-services.json
      staging/google-services.json
      prod/google-services.json
ios/
  config/
    dev/GoogleService-Info.plist
    staging/GoogleService-Info.plist
    prod/GoogleService-Info.plist
```

### 6.4 Secret Management Strategy

```
+---------------------+-------------------------------+---------------------+
|       Layer         |         Tool                  |       Scope         |
+---------------------+-------------------------------+---------------------+
| CI/CD Build Time    | GitHub Secrets /              | API keys injected   |
|                     | Codemagic Env Vars            | via --dart-define   |
+---------------------+-------------------------------+---------------------+
| Backend Runtime     | GCP Secret Manager            | Cloud Functions     |
|                     |                               | access at runtime   |
+---------------------+-------------------------------+---------------------+
| Mobile Runtime      | Compiled into binary via      | No runtime secrets  |
|                     | --dart-define (obfuscated)    | exposure            |
+---------------------+-------------------------------+---------------------+
| Local Development   | .env files (gitignored)       | Developer machines  |
+---------------------+-------------------------------+---------------------+
```

File: `.env.example`

```bash
# Copy to .env and fill in values (do NOT commit .env)
ENVIRONMENT=dev

# AI Provider Keys
CLAUDE_API_KEY=sk-ant-...
GROK_API_KEY=xai-...
GEMINI_API_KEY=AI...
GPT_API_KEY=sk-...

# Firebase (auto-configured by flutterfire)
FIREBASE_PROJECT_ID=lolo-dev

# GCP
GCP_PROJECT_ID=lolo-dev
GCP_REGION=us-central1
```

---

## 7. Monitoring and Alerting Setup

### 7.1 Firebase Crashlytics Integration

File: `lib/main.dart` (Crashlytics setup excerpt)

```dart
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

Future<void> initCrashlytics() async {
  final config = AppConfig.fromEnvironment();

  if (config.enableCrashlytics) {
    // Pass all uncaught errors to Crashlytics
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    // Pass uncaught asynchronous errors to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    // Set custom keys for debugging
    await FirebaseCrashlytics.instance.setCustomKey('environment', config.environment.name);
    await FirebaseCrashlytics.instance.setCustomKey('ai_provider', 'multi');
  } else {
    // Disable in dev
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  }
}
```

### 7.2 Cloud Monitoring Alert Policies

File: `terraform/monitoring.tf` (see Section 8 for full Terraform)

```hcl
# Error rate alert - Cloud Functions
resource "google_monitoring_alert_policy" "function_error_rate" {
  display_name = "LOLO - Cloud Function Error Rate > 5%"
  project      = var.project_id
  combiner     = "OR"

  conditions {
    display_name = "Error rate exceeds 5%"
    condition_threshold {
      filter          = "resource.type = \"cloud_function\" AND metric.type = \"cloudfunctions.googleapis.com/function/execution_count\" AND metric.labels.status != \"ok\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0.05
      duration        = "300s"
      aggregations {
        alignment_period     = "300s"
        per_series_aligner   = "ALIGN_RATE"
        cross_series_reducer = "REDUCE_SUM"
        group_by_fields      = ["resource.label.function_name"]
      }
    }
  }

  notification_channels = [
    google_monitoring_notification_channel.slack_devops.name,
    google_monitoring_notification_channel.email_oncall.name,
  ]

  alert_strategy {
    auto_close = "1800s"
  }
}

# Latency alert - Cloud Functions
resource "google_monitoring_alert_policy" "function_latency" {
  display_name = "LOLO - Cloud Function Latency > 5s (p95)"
  project      = var.project_id
  combiner     = "OR"

  conditions {
    display_name = "p95 latency exceeds 5 seconds"
    condition_threshold {
      filter          = "resource.type = \"cloud_function\" AND metric.type = \"cloudfunctions.googleapis.com/function/execution_times\""
      comparison      = "COMPARISON_GT"
      threshold_value = 5000
      duration        = "300s"
      aggregations {
        alignment_period     = "300s"
        per_series_aligner   = "ALIGN_PERCENTILE_95"
        cross_series_reducer = "REDUCE_MAX"
        group_by_fields      = ["resource.label.function_name"]
      }
    }
  }

  notification_channels = [
    google_monitoring_notification_channel.slack_devops.name,
  ]
}

# Firestore usage alert
resource "google_monitoring_alert_policy" "firestore_reads" {
  display_name = "LOLO - Firestore Daily Reads > 80% Quota"
  project      = var.project_id
  combiner     = "OR"

  conditions {
    display_name = "Firestore reads approaching quota"
    condition_threshold {
      filter          = "resource.type = \"firestore_database\" AND metric.type = \"firestore.googleapis.com/document/read_count\""
      comparison      = "COMPARISON_GT"
      threshold_value = 40000
      duration        = "3600s"
      aggregations {
        alignment_period   = "3600s"
        per_series_aligner = "ALIGN_SUM"
      }
    }
  }

  notification_channels = [
    google_monitoring_notification_channel.email_oncall.name,
  ]
}

# Notification channels
resource "google_monitoring_notification_channel" "slack_devops" {
  display_name = "Slack - DevOps"
  project      = var.project_id
  type         = "slack"
  labels = {
    channel_name = "#alerts-devops"
  }
  sensitive_labels {
    auth_token = var.slack_auth_token
  }
}

resource "google_monitoring_notification_channel" "email_oncall" {
  display_name = "Email - On-Call"
  project      = var.project_id
  type         = "email"
  labels = {
    email_address = "oncall@lolo-app.com"
  }
}
```

### 7.3 Sentry Configuration for Backend

File: `functions/src/sentry.ts`

```typescript
import * as Sentry from "@sentry/node";

export function initSentry(): void {
  Sentry.init({
    dsn: process.env.SENTRY_DSN,
    environment: process.env.ENVIRONMENT || "dev",
    release: process.env.SENTRY_RELEASE || "unknown",
    tracesSampleRate: process.env.ENVIRONMENT === "production" ? 0.2 : 1.0,
    integrations: [
      Sentry.httpIntegration(),
    ],
    beforeSend(event) {
      // Strip sensitive data
      if (event.request?.headers) {
        delete event.request.headers["authorization"];
        delete event.request.headers["cookie"];
      }
      return event;
    },
  });
}

export function captureException(error: Error, context?: Record<string, unknown>): void {
  Sentry.withScope((scope) => {
    if (context) {
      scope.setExtras(context);
    }
    Sentry.captureException(error);
  });
}
```

### 7.4 Uptime Checks

File: `terraform/uptime.tf`

```hcl
# Health check for Cloud Functions
resource "google_monitoring_uptime_check_config" "api_health" {
  display_name = "LOLO API Health Check"
  project      = var.project_id
  timeout      = "10s"
  period       = "60s"

  http_check {
    path         = "/health"
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
      host       = "${var.region}-${var.project_id}.cloudfunctions.net"
    }
  }
}

# Uptime checks for AI provider endpoints
resource "google_monitoring_uptime_check_config" "claude_api" {
  display_name = "Claude API Reachability"
  project      = var.project_id
  timeout      = "10s"
  period       = "300s"

  http_check {
    path         = "/"
    port         = 443
    use_ssl      = true
    validate_ssl = true
  }

  monitored_resource {
    type = "uptime_url"
    labels = {
      project_id = var.project_id
      host       = "api.anthropic.com"
    }
  }
}

resource "google_monitoring_uptime_check_config" "gemini_api" {
  display_name = "Gemini API Reachability"
  project      = var.project_id
  timeout      = "10s"
  period       = "300s"

  http_check {
    path         = "/"
    port         = 443
    use_ssl      = true
    validate_ssl = true
  }

  monitored_resource {
    type = "uptime_url"
    labels = {
      project_id = var.project_id
      host       = "generativelanguage.googleapis.com"
    }
  }
}

resource "google_monitoring_uptime_check_config" "openai_api" {
  display_name = "OpenAI API Reachability"
  project      = var.project_id
  timeout      = "10s"
  period       = "300s"

  http_check {
    path         = "/"
    port         = 443
    use_ssl      = true
    validate_ssl = true
  }

  monitored_resource {
    type = "uptime_url"
    labels = {
      project_id = var.project_id
      host       = "api.openai.com"
    }
  }
}

resource "google_monitoring_uptime_check_config" "grok_api" {
  display_name = "Grok API Reachability"
  project      = var.project_id
  timeout      = "10s"
  period       = "300s"

  http_check {
    path         = "/"
    port         = 443
    use_ssl      = true
    validate_ssl = true
  }

  monitored_resource {
    type = "uptime_url"
    labels = {
      project_id = var.project_id
      host       = "api.x.ai"
    }
  }
}
```

---

## 8. Infrastructure as Code

### 8.1 Terraform Project Structure

```
terraform/
  environments/
    dev/
      main.tf
      terraform.tfvars
    staging/
      main.tf
      terraform.tfvars
    production/
      main.tf
      terraform.tfvars
  modules/
    gcp-project/
    cloud-sql/
    memorystore/
    cloud-cdn/
    cloud-armor/
    secret-manager/
    monitoring/
  main.tf
  variables.tf
  outputs.tf
  versions.tf
  backend.tf
```

File: `terraform/versions.tf`

```hcl
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 5.0"
    }
  }
}
```

File: `terraform/backend.tf`

```hcl
terraform {
  backend "gcs" {
    bucket = "lolo-terraform-state"
    prefix = "terraform/state"
  }
}
```

File: `terraform/variables.tf`

```hcl
variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "environment" {
  description = "Environment name (dev, staging, production)"
  type        = string
  validation {
    condition     = contains(["dev", "staging", "production"], var.environment)
    error_message = "Environment must be dev, staging, or production."
  }
}

variable "slack_auth_token" {
  description = "Slack auth token for monitoring notifications"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Cloud SQL database password"
  type        = string
  sensitive   = true
}

variable "claude_api_key" {
  description = "Anthropic Claude API key"
  type        = string
  sensitive   = true
}

variable "grok_api_key" {
  description = "xAI Grok API key"
  type        = string
  sensitive   = true
}

variable "gemini_api_key" {
  description = "Google Gemini API key"
  type        = string
  sensitive   = true
}

variable "gpt_api_key" {
  description = "OpenAI GPT API key"
  type        = string
  sensitive   = true
}
```

File: `terraform/main.tf`

```hcl
provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}

# -------------------------------------------------------------------
# Enable required APIs
# -------------------------------------------------------------------
resource "google_project_service" "apis" {
  for_each = toset([
    "cloudfunctions.googleapis.com",
    "firestore.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "secretmanager.googleapis.com",
    "sqladmin.googleapis.com",
    "redis.googleapis.com",
    "compute.googleapis.com",
    "monitoring.googleapis.com",
    "logging.googleapis.com",
    "cloudtrace.googleapis.com",
    "fcm.googleapis.com",
    "artifactregistry.googleapis.com",
  ])

  project = var.project_id
  service = each.key

  disable_dependent_services = false
  disable_on_destroy         = false
}

# -------------------------------------------------------------------
# Cloud SQL (PostgreSQL) - for analytics and structured data
# -------------------------------------------------------------------
resource "google_sql_database_instance" "lolo_db" {
  name             = "lolo-${var.environment}-db"
  database_version = "POSTGRES_15"
  region           = var.region
  project          = var.project_id

  deletion_protection = var.environment == "production" ? true : false

  settings {
    tier              = var.environment == "production" ? "db-custom-2-8192" : "db-f1-micro"
    availability_type = var.environment == "production" ? "REGIONAL" : "ZONAL"
    disk_autoresize   = true
    disk_size         = var.environment == "production" ? 50 : 10
    disk_type         = "PD_SSD"

    backup_configuration {
      enabled                        = true
      point_in_time_recovery_enabled = var.environment == "production"
      start_time                     = "03:00"
      backup_retention_settings {
        retained_backups = var.environment == "production" ? 30 : 7
      }
    }

    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.vpc.id
    }

    database_flags {
      name  = "log_min_duration_statement"
      value = "1000"
    }

    maintenance_window {
      day          = 7
      hour         = 4
      update_track = "stable"
    }

    insights_config {
      query_insights_enabled  = true
      record_application_tags = true
      record_client_address   = false
    }
  }

  depends_on = [google_project_service.apis]
}

resource "google_sql_database" "lolo_database" {
  name     = "lolo"
  instance = google_sql_database_instance.lolo_db.name
}

resource "google_sql_user" "lolo_user" {
  name     = "lolo_app"
  instance = google_sql_database_instance.lolo_db.name
  password = var.db_password
}

# -------------------------------------------------------------------
# Cloud Memorystore (Redis) - for caching and rate limiting
# -------------------------------------------------------------------
resource "google_redis_instance" "lolo_cache" {
  name           = "lolo-${var.environment}-cache"
  tier           = var.environment == "production" ? "STANDARD_HA" : "BASIC"
  memory_size_gb = var.environment == "production" ? 4 : 1
  region         = var.region
  project        = var.project_id

  redis_version = "REDIS_7_0"

  authorized_network = google_compute_network.vpc.id

  redis_configs = {
    maxmemory-policy = "allkeys-lru"
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

  depends_on = [google_project_service.apis]
}

# -------------------------------------------------------------------
# VPC Network
# -------------------------------------------------------------------
resource "google_compute_network" "vpc" {
  name                    = "lolo-${var.environment}-vpc"
  auto_create_subnetworks = false
  project                 = var.project_id
}

resource "google_compute_subnetwork" "subnet" {
  name          = "lolo-${var.environment}-subnet"
  ip_cidr_range = "10.0.0.0/24"
  region        = var.region
  network       = google_compute_network.vpc.id
  project       = var.project_id

  private_ip_google_access = true
}

resource "google_compute_global_address" "private_ip" {
  name          = "lolo-${var.environment}-private-ip"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.vpc.id
  project       = var.project_id
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.vpc.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip.name]
}

# -------------------------------------------------------------------
# Cloud Armor (DDoS / WAF)
# -------------------------------------------------------------------
resource "google_compute_security_policy" "lolo_waf" {
  name    = "lolo-${var.environment}-waf"
  project = var.project_id

  # Default: allow all traffic
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

  # Block known bad IPs
  rule {
    action   = "deny(403)"
    priority = 1000
    match {
      expr {
        expression = "evaluatePreconfiguredExpr('xss-v33-stable')"
      }
    }
    description = "Block XSS attacks"
  }

  rule {
    action   = "deny(403)"
    priority = 1001
    match {
      expr {
        expression = "evaluatePreconfiguredExpr('sqli-v33-stable')"
      }
    }
    description = "Block SQL injection attacks"
  }

  # Rate limiting
  rule {
    action   = "rate_based_ban"
    priority = 2000
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
      ban_duration_sec = 300
    }
    description = "Rate limit: 100 req/min per IP"
  }
}

# -------------------------------------------------------------------
# Secret Manager - AI API Keys
# -------------------------------------------------------------------
resource "google_secret_manager_secret" "claude_api_key" {
  secret_id = "claude-api-key"
  project   = var.project_id

  replication {
    auto {}
  }

  labels = {
    environment = var.environment
    provider    = "anthropic"
  }
}

resource "google_secret_manager_secret_version" "claude_api_key_version" {
  secret      = google_secret_manager_secret.claude_api_key.id
  secret_data = var.claude_api_key
}

resource "google_secret_manager_secret" "grok_api_key" {
  secret_id = "grok-api-key"
  project   = var.project_id

  replication {
    auto {}
  }

  labels = {
    environment = var.environment
    provider    = "xai"
  }
}

resource "google_secret_manager_secret_version" "grok_api_key_version" {
  secret      = google_secret_manager_secret.grok_api_key.id
  secret_data = var.grok_api_key
}

resource "google_secret_manager_secret" "gemini_api_key" {
  secret_id = "gemini-api-key"
  project   = var.project_id

  replication {
    auto {}
  }

  labels = {
    environment = var.environment
    provider    = "google"
  }
}

resource "google_secret_manager_secret_version" "gemini_api_key_version" {
  secret      = google_secret_manager_secret.gemini_api_key.id
  secret_data = var.gemini_api_key
}

resource "google_secret_manager_secret" "gpt_api_key" {
  secret_id = "gpt-api-key"
  project   = var.project_id

  replication {
    auto {}
  }

  labels = {
    environment = var.environment
    provider    = "openai"
  }
}

resource "google_secret_manager_secret_version" "gpt_api_key_version" {
  secret      = google_secret_manager_secret.gpt_api_key.id
  secret_data = var.gpt_api_key
}

resource "google_secret_manager_secret" "db_password" {
  secret_id = "db-password"
  project   = var.project_id

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "db_password_version" {
  secret      = google_secret_manager_secret.db_password.id
  secret_data = var.db_password
}

# IAM: Allow Cloud Functions to access secrets
resource "google_secret_manager_secret_iam_member" "functions_access" {
  for_each = toset([
    google_secret_manager_secret.claude_api_key.secret_id,
    google_secret_manager_secret.grok_api_key.secret_id,
    google_secret_manager_secret.gemini_api_key.secret_id,
    google_secret_manager_secret.gpt_api_key.secret_id,
    google_secret_manager_secret.db_password.secret_id,
  ])

  project   = var.project_id
  secret_id = each.value
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${var.project_id}@appspot.gserviceaccount.com"
}
```

File: `terraform/outputs.tf`

```hcl
output "cloud_sql_connection_name" {
  description = "Cloud SQL instance connection name"
  value       = google_sql_database_instance.lolo_db.connection_name
}

output "cloud_sql_private_ip" {
  description = "Cloud SQL private IP address"
  value       = google_sql_database_instance.lolo_db.private_ip_address
}

output "redis_host" {
  description = "Redis instance host"
  value       = google_redis_instance.lolo_cache.host
}

output "redis_port" {
  description = "Redis instance port"
  value       = google_redis_instance.lolo_cache.port
}

output "vpc_network_id" {
  description = "VPC network ID"
  value       = google_compute_network.vpc.id
}
```

File: `terraform/environments/dev/terraform.tfvars`

```hcl
project_id  = "lolo-dev"
region      = "us-central1"
environment = "dev"
```

File: `terraform/environments/production/terraform.tfvars`

```hcl
project_id  = "lolo-prod"
region      = "us-central1"
environment = "production"
```

---

## 9. Docker Configuration

### 9.1 Backend Dockerfile

File: `functions/Dockerfile`

```dockerfile
# -------------------------------------------------------------------
# LOLO Backend - Cloud Functions Development Container
# -------------------------------------------------------------------
FROM node:20-slim AS base

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    openjdk-17-jre-headless \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Firebase CLI
RUN npm install -g firebase-tools@latest

# Copy package files
COPY package.json package-lock.json ./

# Install dependencies
RUN npm ci

# Copy source code
COPY . .

# Build TypeScript
RUN npm run build

# Expose emulator ports
EXPOSE 5001 8080 9099 4000 9199

# Default command: start emulators
CMD ["firebase", "emulators:start", "--only", "functions,firestore,auth,storage"]
```

### 9.2 Docker Compose for Local Development

File: `docker-compose.yml`

```yaml
version: "3.9"

services:
  # -------------------------------------------------------------------
  # PostgreSQL - Local development database
  # -------------------------------------------------------------------
  postgres:
    image: postgres:15-alpine
    container_name: lolo-postgres
    restart: unless-stopped
    environment:
      POSTGRES_DB: lolo
      POSTGRES_USER: lolo_app
      POSTGRES_PASSWORD: lolo_dev_password
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./scripts/init-db.sql:/docker-entrypoint-initdb.d/init.sql
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U lolo_app -d lolo"]
      interval: 10s
      timeout: 5s
      retries: 5

  # -------------------------------------------------------------------
  # Redis - Local cache and rate limiting
  # -------------------------------------------------------------------
  redis:
    image: redis:7-alpine
    container_name: lolo-redis
    restart: unless-stopped
    command: redis-server --maxmemory 256mb --maxmemory-policy allkeys-lru
    ports:
      - "6379:6379"
    volumes:
      - redis_data:/data
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 5s
      retries: 5

  # -------------------------------------------------------------------
  # Firebase Emulators - Functions, Firestore, Auth, Storage
  # -------------------------------------------------------------------
  firebase-emulators:
    build:
      context: ./functions
      dockerfile: Dockerfile
    container_name: lolo-firebase-emulators
    restart: unless-stopped
    environment:
      - ENVIRONMENT=dev
      - FIRESTORE_EMULATOR_HOST=localhost:8080
      - FIREBASE_AUTH_EMULATOR_HOST=localhost:9099
      - FUNCTIONS_EMULATOR_HOST=localhost:5001
      - CLAUDE_API_KEY=${CLAUDE_API_KEY:-stub}
      - GROK_API_KEY=${GROK_API_KEY:-stub}
      - GEMINI_API_KEY=${GEMINI_API_KEY:-stub}
      - GPT_API_KEY=${GPT_API_KEY:-stub}
      - POSTGRES_HOST=postgres
      - POSTGRES_PORT=5432
      - POSTGRES_DB=lolo
      - POSTGRES_USER=lolo_app
      - POSTGRES_PASSWORD=lolo_dev_password
      - REDIS_HOST=redis
      - REDIS_PORT=6379
    ports:
      - "4000:4000"   # Emulator Suite UI
      - "5001:5001"   # Cloud Functions
      - "8080:8080"   # Firestore
      - "9099:9099"   # Auth
      - "9199:9199"   # Storage
    depends_on:
      postgres:
        condition: service_healthy
      redis:
        condition: service_healthy
    volumes:
      - ./functions/src:/app/src
      - firebase_data:/app/.firebase-data

  # -------------------------------------------------------------------
  # Adminer - Database admin UI (dev only)
  # -------------------------------------------------------------------
  adminer:
    image: adminer:latest
    container_name: lolo-adminer
    restart: unless-stopped
    ports:
      - "8081:8080"
    depends_on:
      - postgres
    profiles:
      - tools

  # -------------------------------------------------------------------
  # Redis Commander - Redis admin UI (dev only)
  # -------------------------------------------------------------------
  redis-commander:
    image: rediscommander/redis-commander:latest
    container_name: lolo-redis-commander
    restart: unless-stopped
    environment:
      REDIS_HOSTS: "local:redis:6379"
    ports:
      - "8082:8081"
    depends_on:
      - redis
    profiles:
      - tools

volumes:
  postgres_data:
    driver: local
  redis_data:
    driver: local
  firebase_data:
    driver: local
```

**Usage:**

```bash
# Start core services
docker-compose up -d

# Start with admin tools
docker-compose --profile tools up -d

# View logs
docker-compose logs -f firebase-emulators

# Stop all services
docker-compose down

# Stop and remove volumes (clean reset)
docker-compose down -v
```

---

## 10. Deployment Runbook

### 10.1 Pre-Deployment Checklist

**Before every production deployment, verify:**

```
PRE-DEPLOYMENT CHECKLIST
========================

Code Quality:
  [ ] All PR checks passing (lint, tests, build)
  [ ] Code review approved by 2+ reviewers
  [ ] No known critical bugs in release branch
  [ ] Test coverage >= 80% on changed files

Testing:
  [ ] QA sign-off on staging environment
  [ ] RTL layout verified for Arabic locale
  [ ] Bahasa Melayu strings reviewed by native speaker
  [ ] AI message generation tested with all 4 providers
  [ ] Push notifications tested (FCM) on both platforms
  [ ] Offline mode tested
  [ ] Deep links tested
  [ ] Performance profiling completed (startup < 3s)

Backend:
  [ ] Cloud Functions deployed to staging and smoke-tested
  [ ] Firestore security rules tested
  [ ] Database migration scripts tested (if applicable)
  [ ] Rate limiting verified
  [ ] AI provider failover tested

Infrastructure:
  [ ] All monitoring alerts configured and tested
  [ ] Crashlytics verified on staging
  [ ] Error budget sufficient (SLO > 99.5%)
  [ ] Rollback plan documented and tested

Compliance:
  [ ] No new permissions requested without review
  [ ] Privacy policy updated (if data collection changed)
  [ ] GDPR data handling verified
  [ ] No hardcoded secrets in codebase

Release:
  [ ] Version number bumped (pubspec.yaml)
  [ ] CHANGELOG.md updated
  [ ] Release notes written (EN, AR, MS)
  [ ] Screenshots updated (if UI changed)
  [ ] Tag created: vX.Y.Z
```

### 10.2 Rollback Procedures

#### Mobile App Rollback

```
MOBILE APP ROLLBACK PROCEDURE
==============================

Android (Google Play):
  1. Open Google Play Console > Release > Production
  2. Click "Manage" on the current release
  3. Click "Halt rollout" to stop the new version
  4. If needed, create a new release with the previous AAB
  5. Upload previous AAB as a new release (higher version code)
  6. Submit for review (usually fast-tracked)

  Timeline: 1-4 hours (Google review)

iOS (App Store):
  1. Open App Store Connect > App > App Store tab
  2. If still in review: reject the build
  3. If live: remove the current version from sale
  4. Create a new version with the previous IPA
  5. Submit for expedited review (request via Apple)

  Timeline: 4-24 hours (Apple review)

CRITICAL: Mobile rollbacks are slow. Prefer server-side
feature flags to disable broken features instantly.
```

#### Backend Rollback

```
BACKEND ROLLBACK PROCEDURE
============================

Cloud Functions:
  1. Identify the last known good commit SHA
  2. Run the rollback:

     # Option A: Redeploy from git
     git checkout <GOOD_COMMIT_SHA>
     cd functions && npm ci && npm run build
     firebase deploy --only functions --project lolo-prod

     # Option B: Rollback via Cloud Console
     - Open GCP Console > Cloud Functions
     - Select function > Revisions
     - Route 100% traffic to previous revision

  Timeline: 2-5 minutes

Firestore Rules:
  1. Rules are versioned in git
  2. Deploy previous rules version:

     git checkout <GOOD_COMMIT_SHA> -- firestore.rules
     firebase deploy --only firestore:rules --project lolo-prod

  Timeline: 1-2 minutes

Database Migrations:
  1. Run the down migration script:

     npm run migrate:down -- --to <PREVIOUS_VERSION>

  2. Verify data integrity
  3. Notify affected services

  Timeline: 5-30 minutes (depends on migration size)
```

### 10.3 Staged Rollout Strategy

```
STAGED ROLLOUT - MOBILE APP
=============================

Day 0: Internal Track
  - Deploy to internal testers (team only)
  - Smoke test all critical flows
  - Monitor Crashlytics for 4 hours

Day 1: Closed Beta (1%)
  - Promote to beta track
  - Enable for 1% of users
  - Monitor: crash rate, ANRs, API errors
  - Success criteria: crash-free rate > 99.5%

Day 2-3: Expanded Beta (10%)
  - Increase rollout to 10%
  - Monitor all dashboards for 48 hours
  - Check AI provider error rates
  - Check localization issues (AR, MS)

Day 4-5: Wider Rollout (50%)
  - Increase to 50%
  - Monitor for 48 hours
  - Check user reviews and ratings

Day 6-7: Full Rollout (100%)
  - Complete rollout to all users
  - Continue monitoring for 72 hours
  - Close the release milestone

ABORT CRITERIA (halt rollout immediately):
  - Crash-free rate drops below 99%
  - API error rate exceeds 5%
  - Any data loss or corruption detected
  - Authentication failures spike
  - AI provider complete outage (all 4 down)
```

### 10.4 Incident Response Procedure

```
INCIDENT RESPONSE PROCEDURE
==============================

Severity Levels:
  SEV-1 (Critical): App completely unusable, data loss,
                     security breach
  SEV-2 (High):     Major feature broken, >10% users affected
  SEV-3 (Medium):   Minor feature broken, workaround exists
  SEV-4 (Low):      Cosmetic issue, no functional impact

Response Times:
  SEV-1: Acknowledge within 15 minutes, resolve within 2 hours
  SEV-2: Acknowledge within 30 minutes, resolve within 4 hours
  SEV-3: Acknowledge within 2 hours, resolve within 24 hours
  SEV-4: Acknowledge within 24 hours, resolve in next sprint

Incident Flow:
  1. DETECT
     - Automated: monitoring alert fires
     - Manual: user report, QA discovery

  2. ACKNOWLEDGE
     - On-call engineer acknowledges in Slack #incidents
     - Post: "Investigating [SEVERITY] - [brief description]"

  3. TRIAGE
     - Assess severity level
     - Identify affected systems (mobile/backend/infra)
     - Determine blast radius (% users affected)

  4. COMMUNICATE
     - SEV-1/2: Notify engineering leads immediately
     - Update status page if user-facing
     - Post updates every 30 minutes (SEV-1) or 1 hour (SEV-2)

  5. MITIGATE
     - Apply immediate fix or rollback
     - Use feature flags to disable broken features
     - Route traffic away from failing services

  6. RESOLVE
     - Confirm fix deployed and verified
     - Post "Resolved" update in Slack
     - Update status page

  7. POST-MORTEM (within 48 hours for SEV-1/2)
     - Timeline of events
     - Root cause analysis
     - What went well / what went wrong
     - Action items with owners and deadlines
     - Document in shared incident log
```

### 10.5 On-Call Escalation

```
ON-CALL ESCALATION CHAIN
==========================

Level 1: On-Call Engineer (primary)
  - Rotation: weekly, Mon 09:00 to Mon 09:00
  - Tools: PagerDuty, Slack #incidents
  - Responsibility: first response, triage, basic rollbacks

Level 2: Engineering Lead
  - Escalate after: 30 min (SEV-1), 1 hour (SEV-2)
  - Responsibility: architectural decisions, cross-team coordination

Level 3: CTO / VP Engineering
  - Escalate after: 1 hour (SEV-1), 4 hours (SEV-2)
  - Responsibility: business impact assessment, external comms

External Escalation:
  - Firebase/GCP: Google Cloud Support (Premium tier)
  - AI Providers:
    - Claude: Anthropic support portal
    - GPT: OpenAI support
    - Gemini: Google AI support (via GCP)
    - Grok: xAI support

Contact Sheet (stored in 1Password):
  - Team phone numbers
  - Vendor support contacts
  - Emergency GCP project access
```

---

## Appendix A: GitHub Secrets Setup Checklist

Run these commands to configure all required secrets:

```bash
# Android signing
gh secret set ANDROID_KEYSTORE_BASE64 --env production < lolo-release-keystore.b64
gh secret set KEYSTORE_PASSWORD --env production
gh secret set KEY_PASSWORD --env production
gh secret set KEY_ALIAS --env production --body "lolo-release-key"

# AI API keys (per environment)
for ENV in dev staging production; do
  gh secret set CLAUDE_API_KEY --env $ENV
  gh secret set GROK_API_KEY --env $ENV
  gh secret set GEMINI_API_KEY --env $ENV
  gh secret set GPT_API_KEY --env $ENV
done

# Firebase
for ENV in dev staging production; do
  gh secret set GCP_SERVICE_ACCOUNT_KEY --env $ENV < gcp-sa-key-${ENV}.json
  gh secret set FIREBASE_ANDROID_APP_ID --env $ENV
done

gh secret set FIREBASE_SERVICE_ACCOUNT_JSON --env dev < firebase-sa-dev.json
gh secret set FIREBASE_SERVICE_ACCOUNT_JSON --env staging < firebase-sa-staging.json

# Google Play
gh secret set GOOGLE_PLAY_SERVICE_ACCOUNT_JSON --env production < play-sa.json

# App Store Connect
gh secret set ASC_KEY_ID --env production
gh secret set ASC_ISSUER_ID --env production
gh secret set ASC_API_KEY_CONTENT --env production

# iOS code signing (Match)
gh secret set MATCH_GIT_URL
gh secret set MATCH_PASSWORD
gh secret set MATCH_GIT_BASIC_AUTHORIZATION
gh secret set APPLE_TEAM_ID

# Slack
gh secret set SLACK_WEBHOOK_DEPLOYMENTS
gh secret set SLACK_WEBHOOK_RELEASES --env production
```

---

## Appendix B: CI/CD Pipeline Diagram

```
Developer Workflow:

  feature/* ──PR──> develop ──merge──> release/* ──tag──> main
       |                |                  |               |
       v                v                  v               v
   pr-check.yml   build-android.yml   build-android.yml  release.yml
   (lint,test,    build-ios.yml       build-ios.yml      (build both,
    format,       deploy-backend.yml  deploy-backend.yml  deploy to
    debug build)  (dev env)           (staging env)       stores,
                                                          tag GH
                                                          release)

  Environments:
  +--------+    +-----------+    +-------------+
  |  DEV   | -> |  STAGING  | -> | PRODUCTION  |
  +--------+    +-----------+    +-------------+
  Auto-deploy    Auto-deploy      Tag-triggered
  on develop     on release/*     on v* tag
  push           push             Manual promote
```

---

## Appendix C: Maintenance Schedule

| Task | Frequency | Owner |
|---|---|---|
| Rotate AI API keys | Every 90 days | DevOps |
| Rotate GCP service account keys | Every 180 days | DevOps |
| Update Flutter SDK | Monthly (minor), quarterly (major) | Mobile Lead |
| Update Node.js runtime | Quarterly | Backend Lead |
| Review Terraform state | Monthly | DevOps |
| Audit GitHub Secrets | Monthly | DevOps |
| Review Cloud Armor rules | Quarterly | Security + DevOps |
| Update Docker base images | Monthly | DevOps |
| Disaster recovery drill | Quarterly | DevOps + Engineering Lead |
| Dependency vulnerability scan | Weekly (automated via Dependabot) | DevOps |

---

*Document prepared by Carlos Rivera, DevOps Engineer*
*LOLO -- AI-Powered Relationship Intelligence*
*Sprint 1 Foundation -- February 2026*
