# LouBank - Development & Deployment Guide

## Running the Application

### Option 1: Android Device/Emulator (Recommended)

#### Prerequisites
- Android Studio installed
- Android SDK configured
- Android device or emulator running

#### Steps
```bash
# Check connected devices
flutter devices

# Run on Android
flutter run
```

### Option 2: iOS Device/Simulator (macOS only)

#### Prerequisites
- Xcode installed
- iOS Simulator or physical device

#### Steps
```bash
# Check connected devices
flutter devices

# Run on iOS
flutter run
```

### Option 3: Windows Desktop

#### Prerequisites
- Visual Studio 2022 with C++ desktop development workload
- Windows 10/11

#### Steps
```bash
# Check if Windows is available
flutter doctor

# Run on Windows
flutter run -d windows
```

### Option 4: Web Browser

```bash
# Run on Chrome
flutter run -d chrome
```

## Build Commands

### Debug Builds

```bash
# Android APK (debug)
flutter build apk --debug

# iOS (debug)
flutter build ios --debug

# Windows (debug)
flutter build windows --debug
```

### Release Builds

```bash
# Android APK (release)
flutter build apk --release

# Android App Bundle (for Play Store)
flutter build appbundle --release

# iOS (release)
flutter build ios --release

# Windows (release)
flutter build windows --release
```

## Testing

### Run All Tests
```bash
flutter test
```

### Run Specific Test
```bash
flutter test test/unit/controllers/home_controller_test.dart
```

### Run with Coverage
```bash
flutter test --coverage
```

## Code Quality

### Analyze Code
```bash
flutter analyze
```

### Format Code
```bash
flutter format lib/
```

### Check for Outdated Packages
```bash
flutter pub outdated
```

## Troubleshooting

### Issue: "Unable to find suitable Visual Studio toolchain"
**Solution**: 
1. Install Visual Studio 2022
2. Install "Desktop development with C++" workload
3. Run `flutter doctor` to verify

### Issue: Android build fails
**Solution**:
```bash
flutter clean
flutter pub get
flutter build apk
```

### Issue: iOS build fails
**Solution**:
```bash
cd ios
pod install
cd ..
flutter build ios
```

### Issue: Gradle build errors
**Solution**:
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

## Environment Setup

### Android Setup

1. **Install Android Studio**
   - Download from https://developer.android.com/studio
   - Install Android SDK
   - Create virtual device (AVD)

2. **Configure Flutter**
   ```bash
   flutter doctor --android-licenses
   flutter doctor
   ```

### iOS Setup (macOS only)

1. **Install Xcode**
   - Download from App Store
   - Install command line tools
   ```bash
   sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
   sudo xcodebuild -runFirstLaunch
   ```

2. **Install CocoaPods**
   ```bash
   sudo gem install cocoapods
   ```

### Windows Setup

1. **Install Visual Studio 2022**
   - Download from https://visualstudio.microsoft.com/
   - Select "Desktop development with C++"
   - Install

2. **Verify Setup**
   ```bash
   flutter doctor
   ```

## Performance Optimization

### 1. Enable Dart DevTools
```bash
flutter pub global activate devtools
flutter pub global run devtools
```

### 2. Profile App Performance
```bash
flutter run --profile
```

### 3. Analyze App Size
```bash
flutter build apk --analyze-size
```

### 4. Check for Memory Leaks
```bash
flutter run --profile
# Then use DevTools Memory tab
```

## Deployment

### Android (Google Play Store)

1. **Create Keystore**
   ```bash
   keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
   ```

2. **Configure Signing**
   - Edit `android/key.properties`
   - Update `android/app/build.gradle`

3. **Build App Bundle**
   ```bash
   flutter build appbundle --release
   ```

4. **Upload to Play Console**
   - Go to Google Play Console
   - Create new release
   - Upload `build/app/outputs/bundle/release/app-release.aab`

### iOS (App Store)

1. **Configure Xcode Project**
   - Open `ios/Runner.xcworkspace` in Xcode
   - Configure signing & capabilities
   - Set bundle identifier

2. **Build Archive**
   ```bash
   flutter build ios --release
   ```

3. **Upload to App Store Connect**
   - Open Xcode
   - Product → Archive
   - Distribute App

### Windows (Microsoft Store)

1. **Build MSIX Package**
   ```bash
   flutter pub add msix
   flutter pub run msix:create
   ```

2. **Upload to Partner Center**
   - Go to Microsoft Partner Center
   - Create new app submission
   - Upload MSIX package

## Continuous Integration

### GitHub Actions Example

```yaml
name: Flutter CI

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v2
    - uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.10.3'
    
    - run: flutter pub get
    - run: flutter analyze
    - run: flutter test
    - run: flutter build apk --release
```

## Monitoring & Analytics

### Firebase Setup

1. **Add Firebase to Project**
   ```bash
   flutter pub add firebase_core
   flutter pub add firebase_analytics
   ```

2. **Configure Firebase**
   - Create project in Firebase Console
   - Download `google-services.json` (Android)
   - Download `GoogleService-Info.plist` (iOS)

3. **Initialize in App**
   ```dart
   await Firebase.initializeApp();
   ```

### Crashlytics

```bash
flutter pub add firebase_crashlytics
```

## Best Practices

### 1. Version Control
- Use semantic versioning (1.0.0)
- Tag releases
- Write meaningful commit messages

### 2. Code Review
- Review all pull requests
- Run tests before merging
- Check code coverage

### 3. Documentation
- Update README for new features
- Document API changes
- Keep CHANGELOG updated

### 4. Security
- Never commit API keys
- Use environment variables
- Implement proper authentication

### 5. Performance
- Profile regularly
- Optimize images
- Lazy load data
- Cache appropriately

## Resources

### Official Documentation
- [Flutter Docs](https://flutter.dev/docs)
- [Dart Docs](https://dart.dev/guides)
- [GetX Docs](https://pub.dev/packages/get)

### Community
- [Flutter Discord](https://discord.gg/flutter)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/flutter)
- [Reddit r/FlutterDev](https://reddit.com/r/FlutterDev)

### Tools
- [Dart DevTools](https://dart.dev/tools/dart-devtools)
- [Flutter Inspector](https://flutter.dev/docs/development/tools/devtools/inspector)
- [Android Studio](https://developer.android.com/studio)
- [VS Code](https://code.visualstudio.com/)

## Support

For issues and questions:
- GitHub Issues: [Repository Issues](https://github.com/yourusername/loubank/issues)
- Email: support@loubank.com
- Documentation: See README.md

---

**Last Updated**: January 10, 2026  
**Version**: 1.0.0
