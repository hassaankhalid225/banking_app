import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../../theme/app_theme.dart';
import '../widgets/balance_card.dart';
import '../widgets/quick_access_card.dart';
import '../widgets/transaction_list_item.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: SafeArea(
        child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.accentLime,
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.refreshData,
          color: AppColors.accentLime,
          child: CustomScrollView(
            slivers: [
              // App Bar
              SliverAppBar(
                floating: true,
                backgroundColor: AppColors.primaryBackground,
                elevation: 0,
                title: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Lou',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                      ),
                      TextSpan(
                        text: 'Bank',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.accentLime,
                            ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.account_circle_outlined),
                    onPressed: () {},
                  ),
                ],
              ),

              // Content
              SliverPadding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Balance Card
                    BalanceCard(
                      balance: controller.formattedTotalBalance,
                      accountNumber: controller.selectedAccount.value?.accountNumber ?? '',
                    ),

                    const SizedBox(height: 24),

                    // Quick Access Cards
                    _buildQuickAccessSection(),

                    const SizedBox(height: 24),

                    // Promo Banner
                    if (controller.showPromoBanner.value) ...[
                      _buildPromoBanner(context),
                      const SizedBox(height: 24),
                    ],

                    // Recent Transactions
                    _buildRecentTransactionsSection(context),
                  ]),
                ),
              ),
            ],
          ),
        );
        }),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildQuickAccessSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = MediaQuery.of(context).size.width;
            final crossAxisCount = screenWidth > 600 ? 3 : 2;
            final childAspectRatio = screenWidth > 600 ? 1.8 : 1.5;
            
            final items = <Widget>[];
            
            // Add cards
            items.addAll(
              controller.selectedAccountCards.take(2).map(
                (card) => QuickAccessCard(
                  title: card.cardType,
                  balance: '\$${card.cardLimit.toStringAsFixed(2)}',
                  cardNumber: card.maskedCardNumber,
                  isCard: true,
                ),
              ),
            );
            
            // Add additional account if available
            if (controller.accounts.length > 1 && items.length < 4) {
              items.add(
                QuickAccessCard(
                  title: controller.accounts[1].accountType,
                  balance: '\$${controller.accounts[1].balance.toStringAsFixed(2)}',
                  cardNumber: controller.accounts[1].accountNumber,
                  isCard: false,
                ),
              );
            }
            
            return GridView.count(
              crossAxisCount: crossAxisCount,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: childAspectRatio,
              children: items,
            );
          },
        ),
      ],
    );
  }

  Widget _buildPromoBanner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondaryBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Start investing now!',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Grow your wealth with our investment plans',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 20),
            onPressed: controller.dismissPromoBanner,
          ),
        ],
      ),
    );
  }

  Widget _buildRecentTransactionsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Transactions',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('See all'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...controller.recentTransactions.map(
          (transaction) => TransactionListItem(transaction: transaction),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return Obx(() => BottomNavigationBar(
          currentIndex: controller.selectedBottomNavIndex.value,
          onTap: controller.onBottomNavTap,
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.secondaryBackground,
          selectedItemColor: AppColors.accentLime,
          unselectedItemColor: AppColors.textSecondary,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_outlined),
              activeIcon: Icon(Icons.notifications),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.credit_card_outlined),
              activeIcon: Icon(Icons.credit_card),
              label: 'Cards',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart_outline),
              activeIcon: Icon(Icons.pie_chart),
              label: 'Budget',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              activeIcon: Icon(Icons.menu_open),
              label: 'More',
            ),
          ],
        ));
  }
}
