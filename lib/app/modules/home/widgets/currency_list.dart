import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class CurrencyRow extends StatelessWidget {
  final String name;
  final String symbol;
  final String buyValue;
  final String sellValue;
  final IconData icon;
  final bool isCircularIcon;

  const CurrencyRow({
    super.key,
    required this.name,
    required this.symbol,
    required this.buyValue,
    required this.sellValue,
    required this.icon,
    this.isCircularIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.secondaryBackground,
              shape: isCircularIcon ? BoxShape.circle : BoxShape.rectangle,
              borderRadius: isCircularIcon ? null : BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: isCircularIcon ? AppColors.textPrimary : const Color(0xFF80DEEA),
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              buyValue,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              sellValue,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class CurrencyList extends StatelessWidget {
  const CurrencyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Table Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            children: [
              const SizedBox(width: 56),
              Expanded(
                flex: 3,
                child: Text(
                  'Currencie',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 10,
                      ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Buy',
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 10,
                      ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Sell',
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 10,
                      ),
                ),
              ),
            ],
          ),
        ),
        // Currencies
        const CurrencyRow(
          name: 'USD',
          symbol: '\$',
          buyValue: '\$ 78,92',
          sellValue: '\$ 78,92',
          icon: Icons.attach_money,
        ),
        const CurrencyRow(
          name: 'EUR',
          symbol: '€',
          buyValue: '\$ 78,92',
          sellValue: '\$ 78,92',
          icon: Icons.euro,
        ),
        const SizedBox(height: 16),
        // Metals Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            children: [
              const SizedBox(width: 56),
              Expanded(
                flex: 3,
                child: Text(
                  'Metals',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 10,
                      ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Buy',
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 10,
                      ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Sell',
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 10,
                      ),
                ),
              ),
            ],
          ),
        ),
        // Metals
        const CurrencyRow(
          name: 'Gold',
          symbol: 'Au',
          buyValue: '\$ 78,92',
          sellValue: '\$ 78,92',
          icon: Icons.grid_view_rounded,
          isCircularIcon: false,
        ),
        const CurrencyRow(
          name: 'Silver',
          symbol: 'Ag',
          buyValue: '\$ 78,92',
          sellValue: '\$ 78,92',
          icon: Icons.grid_view_rounded,
          isCircularIcon: false,
        ),
      ],
    );
  }
}
