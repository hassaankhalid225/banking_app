import 'package:flutter/material.dart';
import '../../../data/models/card_model.dart';

class BankCardWidget extends StatelessWidget {
  final CardModel card;
  final int index;
  final VoidCallback? onTap;

  const BankCardWidget({
    super.key,
    required this.card,
    required this.index,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Define the specific gradients from the design
    final List<LinearGradient> gradients = [
      // 1. White/Greyish (Salary)
      const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFF0F4F7), Color(0xFFD3DEE5)],
      ),
      // 2. Yellow/Lime (Savings)
      const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFFCFFDE), Color(0xFFF2FF59)],
      ),
      // 3. Lilac/Purple (Other)
      const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFEADBFF), Color(0xFFD0BCFF)],
      ),
    ];

    // Cycle through gradients
    final gradient = gradients[index % gradients.length];

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 145,
        height: 170, // Slightly shorter height
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(28), // Larger radius
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Visa Logo
             Text(
              'VISA',
              style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    fontSize: 20,
                    letterSpacing: 1,
                    fontFamily: 'Inter', // Ensuring font consistency
                  ),
            ),
            
            // Middle Section (Label + Amount)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  card.cardType, // e.g., "Salary", "Savings account"
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.black87,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '\$ ${card.cardLimit.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                ),
              ],
            ),
            
            // Masked Number
            Text(
              '** ${card.cardNumber.substring(card.cardNumber.length - 4)}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    letterSpacing: 1.5,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
