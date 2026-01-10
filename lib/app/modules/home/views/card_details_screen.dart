import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../controllers/card_controller.dart';
import '../../../theme/app_theme.dart';
import '../widgets/detailed_card_widget.dart';
import '../widgets/transaction_list_item.dart';

class CardDetailsScreen extends GetView<CardController> {
  const CardDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.secondaryBackground,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back_ios_new, size: 16),
          ),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Your cards',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.selectedCard.value == null) {
          return const Center(child: Text('No card selected'));
        }

        final card = controller.selectedCard.value!;

        return Column(
          children: [
            const SizedBox(height: 20),
            // Card Section
            DetailedCardWidget(
              card: card,
              index: controller.cardIndex.value,
            ),
            const SizedBox(height: 16),
            // Page Indicator dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: controller.cardIndex.value == 0
                        ? AppColors.accentLime
                        : AppColors.textSecondary.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: controller.cardIndex.value == 1
                        ? AppColors.accentLime
                        : AppColors.textSecondary.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: controller.cardIndex.value >= 2
                        ? AppColors.accentLime
                        : AppColors.textSecondary.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Transactions Section
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.secondaryBackground.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Transactions',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.cardBackground,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                const Text(
                                  'Filter',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 16,
                                  color: AppColors.textSecondary,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: controller.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : ListView(
                              padding: const EdgeInsets.only(bottom: 20),
                              children: [
                                _buildDateHeader('Today'),
                                ...controller.cardTransactions
                                    .take(2)
                                    .map((txn) => TransactionListItem(transaction: txn)),
                                _buildDateHeader('June 13th'),
                                ...controller.cardTransactions
                                    .skip(2)
                                    .take(2)
                                    .map((txn) => TransactionListItem(transaction: txn)),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildDateHeader(String date) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      child: Text(
        date,
        style: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    final homeController = Get.find<HomeController>();
    return Obx(() => BottomNavigationBar(
      currentIndex: homeController.selectedBottomNavIndex.value,
      onTap: homeController.onBottomNavTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.secondaryBackground,
      selectedItemColor: AppColors.accentLime,
      unselectedItemColor: AppColors.textSecondary,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag),
          label: 'Shop',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.credit_card),
          label: 'Cards',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.access_time_filled),
          label: 'History',
        ),
      ],
    ));
  }
}
