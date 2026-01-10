import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class CollapsibleHeader extends StatelessWidget {
  final String title;
  final bool hasAddButton;
  final VoidCallback? onAddPressed;

  const CollapsibleHeader({
    super.key,
    required this.title,
    this.hasAddButton = false,
    this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.textSecondary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      fontSize: 11,
                    ),
              ),
            ],
          ),
          if (hasAddButton)
            GestureDetector(
              onTap: onAddPressed,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: AppColors.secondaryBackground,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add,
                  color: AppColors.textSecondary,
                  size: 16,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
