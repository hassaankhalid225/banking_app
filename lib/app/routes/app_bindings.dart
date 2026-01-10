import 'package:get/get.dart';
import '../modules/auth/controllers/splash_controller.dart';
import '../modules/auth/controllers/passcode_controller.dart';
import '../modules/home/controllers/home_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
    Get.lazyPut<PasscodeController>(() => PasscodeController());
  }
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
