import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../controllers/messages_controller.dart';
import '../../../theme/app_theme.dart';
import '../../../routes/app_routes.dart';

class MessagesScreen extends GetView<MessagesController> {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: const NetworkImage('https://i.pravatar.cc/150?u=john'),
            radius: 18,
          ),
        ),
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.secondaryBackground,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
            decoration: InputDecoration(
              hintText: 'Name or number of phone',
              hintStyle: TextStyle(color: AppColors.textSecondary.withOpacity(0.5), fontSize: 14),
              prefixIcon: Icon(Icons.search, color: AppColors.textSecondary.withOpacity(0.5), size: 20),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Dialogues',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
            ),
          ),
          const SizedBox(height: 16),
          // Categories
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _buildCategory('Actions'),
                _buildCategory('Channels'),
                _buildCategory('Podcasts'),
                IconButton(
                  icon: const Icon(Icons.tune, color: AppColors.textSecondary, size: 20),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Quick Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildQuickAction(Icons.star_rounded, 'Transfer\nmoney', AppColors.accentLime),
              _buildQuickAction(Icons.account_balance_wallet, 'Lou\nBonuses', const Color(0xFF80DEEA)),
              _buildQuickAction(Icons.grid_view_rounded, 'Lou\nAssets', const Color(0xFFCE93D8)),
            ],
          ),
          const SizedBox(height: 32),
          // Messages List
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.secondaryBackground.withOpacity(0.3),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                    child: Text(
                      'Messages',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                            fontSize: 20,
                          ),
                    ),
                  ),
                  Expanded(
                    child: Obx(
                      () => controller.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              itemCount: controller.messages.length,
                              itemBuilder: (context, index) {
                                final message = controller.messages[index];
                                return _buildMessageItem(message);
                              },
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildCategory(String title) {
    return Obx(() {
      final isSelected = controller.selectedCategory.value == title;
      return GestureDetector(
        onTap: () => controller.setCategory(title),
        child: Container(
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.accentLime : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: isSelected ? null : Border.all(color: AppColors.textSecondary.withOpacity(0.3)),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.black : AppColors.textSecondary,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      );
    });
  }

  Widget _buildQuickAction(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: Colors.black87, size: 28),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 11,
            height: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildMessageItem(dynamic message) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=${message.senderId}'),
        radius: 24,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            message.senderId,
            style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            '18 Feb', // Static for design matching
            style: TextStyle(color: AppColors.textSecondary.withOpacity(0.5), fontSize: 12),
          ),
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              message.message,
              style: TextStyle(color: AppColors.textSecondary.withOpacity(0.7), fontSize: 13),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (message.senderId == 'LouBank')
            const Icon(Icons.done_all, color: Colors.blue, size: 16),
        ],
      ),
      onTap: () => Get.toNamed(AppRoutes.chat, arguments: message),
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
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Shop'),
        BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: 'Cards'),
        BottomNavigationBarItem(icon: Icon(Icons.chat_bubble), label: 'Chat'),
        BottomNavigationBarItem(icon: Icon(Icons.access_time_filled), label: 'History'),
      ],
    ));
  }
}
