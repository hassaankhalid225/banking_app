import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import '../../../routes/app_routes.dart';
import '../../../data/services/storage_service.dart';

class PasscodeController extends GetxController {
  final StorageService _storageService = StorageService();
  final LocalAuthentication _localAuth = LocalAuthentication();

  final RxString passcode = ''.obs;
  final RxBool isLoading = false.obs;
  final RxBool canUseBiometric = false.obs;
  final RxString errorMessage = ''.obs;

  final int passcodeLength = 4;

  @override
  void onInit() {
    super.onInit();
    _checkBiometricAvailability();
  }

  Future<void> _checkBiometricAvailability() async {
    try {
      final bool canAuthenticateWithBiometrics =
          await _localAuth.canCheckBiometrics;
      final bool canAuthenticate =
          canAuthenticateWithBiometrics || await _localAuth.isDeviceSupported();
      canUseBiometric.value =
          canAuthenticate && _storageService.biometricEnabled;
    } catch (e) {
      canUseBiometric.value = false;
    }
  }

  void onNumberPressed(String number) {
    if (passcode.value.length < passcodeLength) {
      passcode.value += number;
      HapticFeedback.lightImpact();

      if (passcode.value.length == passcodeLength) {
        _verifyPasscode();
      }
    }
  }

  void onDeletePressed() {
    if (passcode.value.isNotEmpty) {
      passcode.value = passcode.value.substring(0, passcode.value.length - 1);
      HapticFeedback.lightImpact();
      errorMessage.value = '';
    }
  }

  Future<void> onBiometricPressed() async {
    try {
      final bool didAuthenticate = await _localAuth.authenticate(
        localizedReason: 'Please authenticate to access your account',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      if (didAuthenticate) {
        _navigateToHome();
      }
    } catch (e) {
      errorMessage.value = 'Biometric authentication failed';
    }
  }

  Future<void> _verifyPasscode() async {
    isLoading.value = true;

    // Simulate verification delay
    await Future.delayed(const Duration(milliseconds: 500));

    // For demo purposes, accept any 4-digit passcode
    // In production, verify against stored passcode
    final storedPasscode = _storageService.passcode ?? '1234';

    if (passcode.value == storedPasscode) {
      await _storageService.setLoggedIn(true);
      _navigateToHome();
    } else {
      errorMessage.value = 'Incorrect passcode';
      passcode.value = '';
      HapticFeedback.heavyImpact();
    }

    isLoading.value = false;
  }

  void _navigateToHome() {
    Get.offAllNamed(AppRoutes.home);
  }

  void onCantSignIn() {
    // Navigate to password recovery
    Get.snackbar(
      'Help',
      'Password recovery feature coming soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
