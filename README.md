# LouBank - Modern Flutter Banking Application

![LouBank Logo](assets/images/logo.png)

## Overview

LouBank is a comprehensive, modern mobile banking application built with Flutter and GetX. It features a sleek dark theme with lime accent colors, providing users with a complete banking experience including account management, card controls, budgeting tools, peer-to-peer transfers, and in-app messaging.

## Features

### ✅ Implemented (Phase 1)

#### Authentication
- ✅ Splash screen with animated logo
- ✅ Passcode entry with numeric keypad
- ✅ Biometric authentication support (fingerprint/face ID)
- ✅ Haptic feedback on keypad interactions
- ✅ Session management with auto-logout

#### Dashboard/Home
- ✅ Total balance display with account information
- ✅ Quick access cards (VISA/Mastercard previews)
- ✅ Account selector
- ✅ Dismissible promotional banner
- ✅ Recent transactions list (last 5)
- ✅ Pull-to-refresh functionality
- ✅ Bottom navigation bar (5 tabs)

#### Data & Services
- ✅ Complete data models (User, Account, Card, Transaction, Budget, Contact, Message)
- ✅ Mock data service with realistic data
- ✅ Local storage service using GetStorage
- ✅ 60+ mock transactions across 6 months
- ✅ 12+ mock contacts
- ✅ 6+ budget categories

#### UI/UX
- ✅ Dark theme with lime accent (#D4F752)
- ✅ Google Fonts integration (Inter)
- ✅ Gradient card backgrounds
- ✅ Smooth animations and transitions
- ✅ Responsive design

### 🚧 To Be Implemented (Phase 2-12)

#### Cards Module
- ⏳ Card details screen with full card display
- ⏳ Card controls (freeze, set limits, report lost)
- ⏳ Transaction filtering and categorization
- ⏳ Spending analytics per card

#### Budget/Analytics Module
- ⏳ Budget creation and management
- ⏳ Visual bar charts for spending
- ⏳ Category-based budget tracking
- ⏳ Budget alerts and notifications
- ⏳ Spending insights

#### Transfer Module
- ⏳ Internal transfers (between own accounts)
- ⏳ External transfers (to other users)
- ⏳ Contact-based quick transfers
- ⏳ QR code transfer
- ⏳ Scheduled and recurring transfers
- ⏳ Transfer history with filtering

#### Messages/Chat Module
- ⏳ Peer-to-peer messaging
- ⏳ Send money through chat
- ⏳ Group creation for split payments
- ⏳ Message notifications
- ⏳ Read receipts

#### Profile/Settings Module
- ⏳ User profile management
- ⏳ Security settings
- ⏳ Notification preferences
- ⏳ Linked accounts management
- ⏳ Help & support
- ⏳ About & legal information

## Technical Stack

- **Framework**: Flutter 3.10.3+
- **State Management**: GetX 4.7.3
- **Local Storage**: GetStorage 2.1.1
- **Charts**: FL Chart 0.69.0
- **Biometric Auth**: local_auth 2.3.0
- **Fonts**: Google Fonts 6.3.3
- **Date Formatting**: intl 0.19.0
- **Image Caching**: cached_network_image 3.4.1
- **Animations**: Lottie 3.3.2, Shimmer 3.0.0
- **QR Code**: qr_flutter 4.1.0

## Project Structure

```
lib/
├── app/
│   ├── data/
│   │   ├── models/              # Data models
│   │   │   ├── user_model.dart
│   │   │   ├── account_model.dart
│   │   │   ├── card_model.dart
│   │   │   ├── transaction_model.dart
│   │   │   ├── budget_model.dart
│   │   │   ├── message_model.dart
│   │   │   └── contact_model.dart
│   │   └── services/            # Services
│   │       ├── mock_data_service.dart
│   │       └── storage_service.dart
│   ├── modules/
│   │   ├── auth/               # Authentication module
│   │   │   ├── controllers/
│   │   │   ├── views/
│   │   │   └── widgets/
│   │   └── home/               # Dashboard module
│   │       ├── controllers/
│   │       ├── views/
│   │       └── widgets/
│   ├── routes/                 # App routes
│   │   ├── app_routes.dart
│   │   ├── app_pages.dart
│   │   └── app_bindings.dart
│   ├── theme/                  # Theme configuration
│   │   └── app_theme.dart
│   └── widgets/                # Shared widgets
├── main.dart
└── app.dart
```

## Getting Started

### Prerequisites

- Flutter SDK 3.10.3 or higher
- Dart SDK 3.10.3 or higher
- Android Studio / VS Code with Flutter extensions
- Android SDK (for Android development)
- Xcode (for iOS development, macOS only)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/loubank.git
   cd loubank
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Default Credentials

For testing purposes, the app accepts any 4-digit passcode. The default passcode is:
- **Passcode**: `1234`

## Configuration

### Theme Customization

The app theme can be customized in `lib/app/theme/app_theme.dart`:

```dart
class AppColors {
  static const Color primaryBackground = Color(0xFF1A1A1A);
  static const Color secondaryBackground = Color(0xFF2A2A2A);
  static const Color accentLime = Color(0xFFD4F752);
  // ... more colors
}
```

### Mock Data

Mock data is generated in `lib/app/data/services/mock_data_service.dart`. You can customize:
- Number of accounts (default: 3)
- Number of cards per account (default: 2)
- Number of transactions (default: 60)
- Number of contacts (default: 12)
- Budget categories (default: 6)

## Development

### Running in Debug Mode

```bash
flutter run --debug
```

### Building for Production

**Android:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

### Running Tests

```bash
flutter test
```

### Code Analysis

```bash
flutter analyze
```

## Architecture

### State Management (GetX)

The app uses GetX for state management, providing:
- **Reactive State**: Using `.obs` and `Obx()` for reactive UI updates
- **Dependency Injection**: Using `Get.lazyPut()` and bindings
- **Navigation**: Using `Get.toNamed()` and `Get.offAllNamed()`

### Modular Structure

Each feature is organized as a module with:
- **Controllers**: Business logic and state management
- **Views**: UI screens
- **Widgets**: Reusable UI components

### Data Flow

1. User interacts with UI (View)
2. View calls Controller method
3. Controller updates state
4. UI automatically rebuilds (reactive)

## Design Specifications

### Color Palette

- **Primary Background**: #1A1A1A (Very dark gray/black)
- **Secondary Background**: #2A2A2A (Dark gray)
- **Accent**: #D4F752 (Lime/yellow-green)
- **Text Primary**: #FFFFFF (White)
- **Text Secondary**: #B0B0B0 (Light gray)
- **Success**: #4CAF50 (Green)
- **Error**: #F44336 (Red)

### Typography

- **Font Family**: Inter (Google Fonts)
- **Headers**: Bold, 24-28sp
- **Subheaders**: Semi-bold, 18-20sp
- **Body**: Regular, 14-16sp
- **Captions**: Regular, 12-14sp

### Component Specifications

- **Border Radius**: 16dp (cards), 24dp (buttons)
- **Elevation**: 0 (flat design)
- **Padding**: 16-24dp
- **Touch Targets**: Minimum 48x48dp

## Roadmap

### Phase 1 (Completed) ✅
- Project setup and configuration
- Authentication module
- Dashboard/Home module
- Core data models and services

### Phase 2 (In Progress) 🚧
- Cards module implementation
- Transaction filtering and details

### Phase 3 (Planned) 📋
- Budget/Analytics module
- Visual charts and insights

### Phase 4 (Planned) 📋
- Transfer module
- QR code transfers

### Phase 5 (Planned) 📋
- Messages/Chat module
- In-app transfers

### Phase 6 (Planned) 📋
- Profile/Settings module
- User preferences

### Phase 7 (Planned) 📋
- Notifications system
- Push notifications

### Phase 8 (Planned) 📋
- Testing and optimization
- Performance improvements

### Phase 9 (Planned) 📋
- Documentation and deployment
- App store preparation

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Design inspiration from modern banking apps
- Flutter community for excellent packages
- GetX team for the amazing state management solution

## Support

For support, email support@loubank.com or open an issue in the GitHub repository.

## Screenshots

### Splash Screen
![Splash Screen](screenshots/splash.png)

### Passcode Entry
![Passcode](screenshots/passcode.png)

### Dashboard
![Dashboard](screenshots/dashboard.png)

---

**Made with ❤️ using Flutter**
#   b a n k i n g _ a p p  
 