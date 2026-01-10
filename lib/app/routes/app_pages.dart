import 'package:get/get.dart';
import 'app_routes.dart';
import 'app_bindings.dart';
import '../modules/auth/views/splash_screen.dart';
import '../modules/auth/views/passcode_screen.dart';
import '../modules/home/views/home_screen.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: AuthBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: AppRoutes.passcode,
      page: () => const PasscodeScreen(),
      binding: AuthBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
  ];
}
