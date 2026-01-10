import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../../theme/app_theme.dart';
import '../../../routes/app_routes.dart';
import '../widgets/account_balance_header.dart';
import '../widgets/bank_card_widget.dart';
import '../widgets/service_grid.dart';
import '../widgets/loan_card.dart';
import '../widgets/notification_card.dart';
import '../widgets/currency_list.dart';
import '../widgets/collapsible_header.dart';

class DashboardScreen extends GetView<HomeController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.accentLime),
            );
          }

          return CustomScrollView(
            slivers: [
              // Custom App Bar
              SliverAppBar(
                floating: true,
                backgroundColor: AppColors.primaryBackground,
                elevation: 0,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: AppColors.secondaryBackground,
                    child: const Icon(
                      Icons.person,
                      color: AppColors.textPrimary,
                      size: 20,
                    ),
                  ),
                ),
                title: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Lou',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                      ),
                      TextSpan(
                        text: 'Bank',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.accentLime,
                            ),
                      ),
                    ],
                  ),
                ),
                centerTitle: true,
              ),

              // Content
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Balance Header
                    AccountBalanceHeader(
                      balance: controller.formattedTotalBalance,
                      onSearchTap: () {},
                    ),

                    const SizedBox(height: 16),

                    // Card Carousel
                    if (controller.cards.isEmpty)
                      Container(
                        height: 220,
                        alignment: Alignment.center,
                        child: const Text(
                          'No cards available',
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                      )
                    else
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: controller.cards.length,
                          itemBuilder: (context, index) {
                            final card = controller.cards[index];
                            return BankCardWidget(
                              card: card,
                              index: index,
                              onTap: () => Get.toNamed(
                                AppRoutes.cardDetails,
                                arguments: {
                                  'card': card,
                                  'index': index,
                                },
                              ),
                            );
                          },
                        ),
                      ),

                    const SizedBox(height: 24),

                    // Service Grid (FINANCE Section)
                    const ServiceGrid(),

                    const SizedBox(height: 8),

                    // Current Loans Section
                    const CollapsibleHeader(
                      title: 'CURRENT LOANS',
                      hasAddButton: true,
                    ),

                    const LoanCard(
                      accountNumber: '3874825',
                      expiryDate: '12/22/2023',
                      amount: '\$ 78,92',
                      rate: '3.5%',
                    ),

                    const SizedBox(height: 8),

                    // Notification Card (Promo Banner)
                    if (controller.showPromoBanner.value)
                      NotificationCard(
                        title: 'Start investing now!',
                        subtitle: 'Protected savings and investment plans',
                        onDismiss: controller.dismissPromoBanner,
                      ),

                    const SizedBox(height: 16),

                    // Currencies and Metals Section
                    const CollapsibleHeader(
                      title: 'CURRENCIES AND METALS',
                    ),

                    const CurrencyList(),

                    const SizedBox(height: 80), // Bottom padding for nav bar
                  ],
                ),
              ),
            ],
          );
        }),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Obx(
      () => BottomNavigationBar(
        currentIndex: controller.selectedBottomNavIndex.value,
        onTap: controller.onBottomNavTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.secondaryBackground,
        selectedItemColor: AppColors.accentLime,
        unselectedItemColor: AppColors.textSecondary,
        selectedFontSize: 12,
        unselectedFontSize: 12,
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
      ),
    );
  }
}
