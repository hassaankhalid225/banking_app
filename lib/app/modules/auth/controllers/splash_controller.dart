import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../../../data/services/storage_service.dart';

class SplashController extends GetxController {
  final StorageService _storageService = StorageService();

  @override
  void onReady() {
    super.onReady();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    try {
      // Wait for 2 seconds to show splash screen
      await Future.delayed(const Duration(seconds: 2));

      // Check if user is logged in
      if (_storageService.isLoggedIn) {
        // Navigate to passcode screen
        Get.offAllNamed(AppRoutes.passcode);
      } else {
        // Navigate to passcode screen (for now, always go to passcode)
        Get.offAllNamed(AppRoutes.passcode);
      }
    } catch (e) {
      // If there's an error, still navigate to passcode
      debugPrint('Error in splash navigation: $e');
      Get.offAllNamed(AppRoutes.passcode);
    }
  }
}
