import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class PasscodeDots extends StatelessWidget {
  final int length;
  final int filledCount;

  const PasscodeDots({
    super.key,
    required this.length,
    required this.filledCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        length,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index < filledCount
                  ? AppColors.accentLime
                  : AppColors.cardBorder,
            ),
          ),
        ),
      ),
    );
  }
}
