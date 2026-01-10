# LouBank - Troubleshooting Guide

## Issue: Splash Screen Doesn't Navigate

### ✅ Fixed Issues

1. **Controller Initialization**: Changed from `onInit()` to `onReady()` to ensure proper initialization timing
2. **Error Handling**: Added try-catch block to handle any navigation errors
3. **Controller Reference**: Added `Get.find<SplashController>()` in SplashScreen to ensure controller is initialized
4. **Loading Indicator**: Added visual feedback during the 2-second splash delay

### How It Works Now

1. **App Starts** → `main.dart` initializes StorageService
2. **Splash Screen Loads** → Shows LouBank logo with loading indicator
3. **Controller Initializes** → `SplashController.onReady()` is called
4. **2-Second Delay** → Shows splash screen for 2 seconds
5. **Navigation** → Automatically navigates to Passcode screen

### Testing Steps

1. **Hot Restart the App**:
   ```bash
   # In terminal where flutter run is active, press:
   R (capital R for hot restart)
   ```

2. **Or Stop and Restart**:
   ```bash
   # Press 'q' to quit
   # Then run again:
   flutter run
   ```

3. **Expected Behavior**:
   - See LouBank logo with "Become a Lover of the bank"
   - See lime-colored loading indicator
   - After 2 seconds, automatically navigate to Passcode screen
   - See numeric keypad

### If Still Not Working

#### Option 1: Check Console Output
Look for any error messages in the console. The app will print:
```
Error in splash navigation: [error details]
```

#### Option 2: Clean Build
```bash
flutter clean
flutter pub get
flutter run
```

#### Option 3: Check Device/Emulator
Make sure you have a device connected:
```bash
flutter devices
```

#### Option 4: Run on Different Platform
```bash
# Try web browser
flutter run -d chrome

# Or Android
flutter run -d android

# Or iOS (macOS only)
flutter run -d ios
```

### Debug Mode

To see detailed logs:
```bash
flutter run --verbose
```

### Common Issues

#### Issue: "No connected devices"
**Solution**: 
- Start an Android emulator
- Connect a physical device
- Use Chrome: `flutter run -d chrome`

#### Issue: "Build failed"
**Solution**:
```bash
flutter clean
flutter pub get
flutter run
```

#### Issue: "GetX controller not found"
**Solution**: The bindings are now properly set up. Make sure you're using the latest code.

#### Issue: White/blank screen
**Solution**: 
- Wait 2 seconds for navigation
- Check console for errors
- Hot restart the app (press 'R')

### Verification Checklist

- [ ] StorageService initialized in main.dart
- [ ] SplashController uses onReady() instead of onInit()
- [ ] SplashScreen calls Get.find<SplashController>()
- [ ] AuthBinding is set in app_pages.dart
- [ ] AppRoutes.passcode route exists
- [ ] PasscodeScreen is properly imported

### Navigation Flow

```
main.dart
  ↓
StorageService.init()
  ↓
LouBankApp (GetMaterialApp)
  ↓
initialRoute: AppRoutes.splash
  ↓
SplashScreen (with AuthBinding)
  ↓
SplashController.onReady()
  ↓
Future.delayed(2 seconds)
  ↓
Get.offAllNamed(AppRoutes.passcode)
  ↓
PasscodeScreen (with AuthBinding)
```

### Quick Test

Run this command to verify the app builds correctly:
```bash
flutter analyze
```

Expected output: No errors (only info about debugPrint is acceptable)

### Still Having Issues?

1. **Check the terminal output** for error messages
2. **Hot restart** the app (press 'R' in terminal)
3. **Verify device is connected**: `flutter devices`
4. **Try a different platform**: `flutter run -d chrome`
5. **Check Flutter doctor**: `flutter doctor`

### Success Indicators

✅ Splash screen appears with logo  
✅ Loading indicator shows (lime color)  
✅ After 2 seconds, passcode screen appears  
✅ Numeric keypad is visible  
✅ No error messages in console  

---

**Last Updated**: January 10, 2026  
**Status**: Navigation Fixed ✅
