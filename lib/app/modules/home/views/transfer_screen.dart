import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/transfer_controller.dart';
import '../../../theme/app_theme.dart';
import '../../../routes/app_routes.dart';

class TransferScreen extends GetView<TransferController> {
  const TransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8B9E77), // Moss green background as in design
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Transfer',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          const Text(
            'Balance',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 8),
          const Text(
            '\$ 7,896',
            style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryBackground,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Padding(
                    padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFC0E0D0).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Send money to',
                            style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ...controller.recentContacts.map((contact) => _buildContactAvatar(contact)),
                              _buildAddContact(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Contacts',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Obx(
                      () => controller.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              itemCount: controller.contacts.length,
                              itemBuilder: (context, index) {
                                final contact = controller.contacts[index];
                                return _buildContactItem(contact);
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
    );
  }

  Widget _buildContactAvatar(dynamic contact) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.quickTransfer, arguments: contact),
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=${contact.name}'),
            radius: 20,
          ),
          const SizedBox(height: 8),
          Text(
            contact.name.split(' ')[0],
            style: const TextStyle(color: AppColors.textPrimary, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildAddContact() {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.secondaryBackground,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.add, color: AppColors.textPrimary, size: 20),
        ),
        const SizedBox(height: 8),
        const Text(
          'Send',
          style: TextStyle(color: AppColors.textPrimary, fontSize: 11),
        ),
      ],
    );
  }

  Widget _buildContactItem(dynamic contact) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=${contact.name}'),
        radius: 20,
      ),
      title: Text(
        contact.name,
        style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      subtitle: Text(
        'I return the debt', // Static for design matching
        style: TextStyle(color: AppColors.textSecondary.withOpacity(0.5), fontSize: 12),
      ),
      trailing: Text(
        '18 Feb', // Static for design matching
        style: TextStyle(color: AppColors.textSecondary.withOpacity(0.5), fontSize: 12),
      ),
      onTap: () => Get.toNamed(AppRoutes.quickTransfer, arguments: contact),
    );
  }
}
