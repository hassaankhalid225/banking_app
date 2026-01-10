import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/passcode_controller.dart';
import '../widgets/numeric_keypad.dart';
import '../widgets/passcode_dots.dart';
import '../../../theme/app_theme.dart';

class PasscodeScreen extends GetView<PasscodeController> {
  const PasscodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 60),
            
            // Logo
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Lou',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                  ),
                  TextSpan(
                    text: 'Bank',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: AppColors.accentLime,
                        ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 60),
            
            // Title
            Text(
              'Enter Passcode',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            
            const SizedBox(height: 40),
            
            // Passcode Dots
            Obx(() => PasscodeDots(
                  length: controller.passcodeLength,
                  filledCount: controller.passcode.value.length,
                )),
            
            const SizedBox(height: 16),
            
            // Error Message
            Obx(() => controller.errorMessage.value.isNotEmpty
                ? Text(
                    controller.errorMessage.value,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.error,
                        ),
                  )
                : const SizedBox(height: 20)),
            
            const Spacer(),
            
            // Numeric Keypad
            Obx(() => NumericKeypad(
                  onNumberPressed: controller.onNumberPressed,
                  onDeletePressed: controller.onDeletePressed,
                  onBiometricPressed: controller.onBiometricPressed,
                  showBiometric: controller.canUseBiometric.value,
                )),
            
            const SizedBox(height: 24),
            
            // Can't sign in link
            TextButton(
              onPressed: controller.onCantSignIn,
              child: Text(
                'Can\'t sign in?',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.accentLime,
                    ),
              ),
            ),
            
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
