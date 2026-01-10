import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/app_theme.dart';
import '../../../routes/app_routes.dart';

class ServiceButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Color? iconColor;

  const ServiceButton({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 115,
        decoration: BoxDecoration(
          color: AppColors.secondaryBackground,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                color: iconColor ?? AppColors.textPrimary,
                size: 24,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceGrid extends StatelessWidget {
  const ServiceGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'FINANCE',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  fontSize: 11,
                ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ServiceButton(
                  icon: Icons.star,
                  label: 'My bonuses',
                  iconColor: AppColors.accentLime,
                  onTap: () => Get.toNamed(AppRoutes.messages),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ServiceButton(
                  icon: Icons.account_balance_wallet,
                  label: 'My budget',
                  iconColor: const Color(0xFF80DEEA), // Light blue icon
                  onTap: () => Get.toNamed(AppRoutes.budget, arguments: 'Costs'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ServiceButton(
                  icon: Icons.bar_chart,
                  label: 'Finance\nanalysis',
                  iconColor: const Color(0xFFCE93D8), // Lilac icon
                  onTap: () => Get.toNamed(AppRoutes.budget, arguments: 'Analysis'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
