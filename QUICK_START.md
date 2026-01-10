# LouBank - Quick Start Guide

## 🚀 Get Started in 5 Minutes

### Step 1: Install Dependencies
```bash
cd banking_app
flutter pub get
```

### Step 2: Run the App
```bash
flutter run
```

### Step 3: Test the App

1. **Splash Screen**: Wait 2 seconds for the splash screen
2. **Passcode Entry**: Enter any 4-digit passcode (default: `1234`)
3. **Dashboard**: Explore the home screen with:
   - Total balance display
   - Quick access cards
   - Recent transactions
   - Bottom navigation

## 📱 App Navigation

### Bottom Navigation Bar (5 Tabs)

1. **Home** 🏠
   - View total balance
   - Quick access to cards
   - Recent transactions
   
2. **Notifications** 🔔
   - Coming soon
   
3. **Cards** 💳
   - Coming soon
   
4. **Budget** 📊
   - Coming soon
   
5. **More** ⋮
   - Coming soon

## 🔐 Authentication

### Passcode Entry
- Enter 4-digit passcode
- Use biometric authentication (if enabled)
- Tap "Can't sign in?" for help

### Default Passcode
```
1234
```

## 💡 Features to Try

### 1. View Balance
- See your total balance on the home screen
- View individual account balances

### 2. Quick Access Cards
- Tap on card previews to view details (coming soon)
- See masked card numbers

### 3. Recent Transactions
- View last 5 transactions
- See transaction amounts (green for credit, red for debit)
- View transaction dates

### 4. Pull to Refresh
- Pull down on the home screen to refresh data

### 5. Dismiss Promo Banner
- Tap the X button to dismiss the promotional banner

## 🎨 UI Elements

### Color Scheme
- **Background**: Dark (#1A1A1A)
- **Accent**: Lime (#D4F752)
- **Text**: White/Light Gray

### Typography
- **Font**: Inter (Google Fonts)
- **Sizes**: 12-40sp

## 🔧 Customization

### Change Passcode
Edit `lib/app/data/services/storage_service.dart`:
```dart
String? get passcode => read<String>(keyPasscode) ?? '1234';
```

### Modify Mock Data
Edit `lib/app/data/services/mock_data_service.dart`:
```dart
static List<AccountModel> getMockAccounts() {
  // Add or modify accounts here
}
```

### Update Theme Colors
Edit `lib/app/theme/app_theme.dart`:
```dart
class AppColors {
  static const Color accentLime = Color(0xFFD4F752); // Change this
}
```

## 🐛 Troubleshooting

### Issue: App won't build
**Solution**: Run `flutter clean && flutter pub get`

### Issue: Biometric not working
**Solution**: Enable biometric authentication in device settings

### Issue: White screen on launch
**Solution**: Wait for splash screen (2 seconds)

### Issue: Can't enter passcode
**Solution**: Tap on the number buttons in the keypad

## 📚 Next Steps

1. **Explore the Code**
   - Check out `lib/app/modules/` for feature modules
   - Review `lib/app/data/models/` for data structures

2. **Implement New Features**
   - Follow the implementation plan in `.agent/workflows/IMPLEMENTATION_PLAN.md`
   - Start with the Cards module

3. **Customize the App**
   - Update colors in `app_theme.dart`
   - Add your own mock data
   - Create new screens

## 🎯 Development Tips

### Hot Reload
Press `r` in the terminal to hot reload changes

### Hot Restart
Press `R` in the terminal to hot restart the app

### Debug Mode
```bash
flutter run --debug
```

### Release Mode
```bash
flutter run --release
```

## 📖 Documentation

- **Full Documentation**: See `README.md`
- **Implementation Plan**: See `.agent/workflows/IMPLEMENTATION_PLAN.md`
- **API Reference**: Coming soon

## 🤝 Need Help?

- Open an issue on GitHub
- Check the README for detailed information
- Review the implementation plan

---

**Happy Coding! 🎉**
