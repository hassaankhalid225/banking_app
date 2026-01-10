import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class QuickAccessCard extends StatelessWidget {
  final String title;
  final String balance;
  final String cardNumber;
  final bool isCard;

  const QuickAccessCard({
    super.key,
    required this.title,
    required this.balance,
    required this.cardNumber,
    this.isCard = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: isCard
            ? LinearGradient(
                colors: title.contains('VISA')
                    ? AppColors.visaGradient
                    : AppColors.mastercardGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : LinearGradient(
                colors: AppColors.accountGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (isCard)
                Icon(
                  title.contains('VISA')
                      ? Icons.credit_card
                      : Icons.credit_card,
                  size: 20,
                  color: Colors.white.withValues(alpha: 0.8),
                ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                balance,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                isCard ? cardNumber : '****$cardNumber',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
