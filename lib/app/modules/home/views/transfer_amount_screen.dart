import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/transfer_controller.dart';
import '../../../theme/app_theme.dart';

class TransferAmountScreen extends GetView<TransferController> {
  const TransferAmountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final contact = Get.arguments;

    return Scaffold(
      backgroundColor: const Color(0xFF8B9E77), // Matching green background
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
          const SizedBox(height: 40),
          CircleAvatar(
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=${contact?.name ?? 'Maya'}'),
            radius: 32,
          ),
          const SizedBox(height: 12),
          Text(
            contact?.name ?? 'Maya',
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40),
          Obx(
            () => Text(
              '\$ ${controller.amount.value}',
              style: const TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 40),
          // Selected Card
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.secondaryBackground.withOpacity(0.5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(Icons.credit_card, color: Colors.white70, size: 20),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Visa', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                      Text('\$ 5,230.15', style: TextStyle(color: Colors.white70, fontSize: 11)),
                    ],
                  ),
                ),
                Text('** 6917', style: const TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),
          const Spacer(),
          // Numeric Keypad
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentLime,
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                  ),
                  child: const Text('Send', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
                ),
                const SizedBox(height: 32),
                _buildKeypad(),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildKeypad() {
    return Column(
      children: [
        _buildKeypadRow(['1', '2', '3']),
        const SizedBox(height: 24),
        _buildKeypadRow(['4', '5', '6']),
        const SizedBox(height: 24),
        _buildKeypadRow(['7', '8', '9']),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(width: 60),
            _buildKeypadButton('0'),
            SizedBox(
              width: 60,
              child: IconButton(
                icon: const Icon(Icons.backspace_outlined, color: Colors.white),
                onPressed: controller.onDeletePressed,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildKeypadRow(List<String> keys) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: keys.map((key) => _buildKeypadButton(key)).toList(),
    );
  }

  Widget _buildKeypadButton(String key) {
    return GestureDetector(
      onTap: () => controller.onNumberPressed(key),
      child: Container(
        width: 60,
        alignment: Alignment.center,
        child: Text(
          key,
          style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
