import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/budget_controller.dart';
import '../../../theme/app_theme.dart';

import '../controllers/home_controller.dart';
import '../../../routes/app_routes.dart';

class BudgetScreen extends GetView<BudgetController> {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 20),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'My budget',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.tune, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: Obx(() => Column(
        children: [
          const SizedBox(height: 24),
          _buildBalanceSection(),
          const SizedBox(height: 32),
          if (controller.selectedType.value == 'Analysis')
            _buildAnalysisGraph()
          else
            _buildCostsBarChart(),
          const SizedBox(height: 32),
          Expanded(child: _buildTransactionList(context)),
        ],
      )),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBalanceSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.secondaryBackground,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '\$1,345',
                style: TextStyle(color: AppColors.textPrimary, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                'September interest \$2,145',
                style: TextStyle(color: AppColors.textSecondary.withOpacity(0.5), fontSize: 11),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primaryBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'June, 2020',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisGraph() {
    return Container(
       height: 180,
       width: double.infinity,
       padding: const EdgeInsets.symmetric(horizontal: 20),
       child: Stack(
         children: [
           // Mock line chart path
           Center(
             child: CustomPaint(
               size: const Size(double.infinity, 120),
               painter: LineChartPainter(),
             ),
           ),
           // Tooltip
           Positioned(
             left: Get.width * 0.45,
             top: 20,
             child: Container(
               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
               decoration: BoxDecoration(
                 color: AppColors.secondaryBackground,
                 borderRadius: BorderRadius.circular(8),
                 boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
               ),
               child: Column(
                 children: [
                   const Text('- 21.34%', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                   Text('Sep 22', style: TextStyle(color: AppColors.textSecondary, fontSize: 10)),
                 ],
               ),
             ),
           ),
           // Dots at bottom
           Positioned(
             bottom: 0,
             left: 0,
             right: 0,
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: ['May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct'].map((m) => Text(m, style: TextStyle(color: AppColors.textSecondary.withOpacity(0.4), fontSize: 10))).toList(),
             ),
           )
         ],
       ),
    );
  }

  Widget _buildCostsBarChart() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('My costs', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
               Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.secondaryBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Text(controller.selectedPeriod.value, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                    const Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary, size: 16),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildBar(40, false),
              _buildBar(80, false),
              _buildBar(60, true), // Active
              _buildBar(100, false),
              _buildBar(50, false),
              _buildBar(70, false),
              _buildBar(30, false),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: ['Jan 12', 'Jan 13', 'Jan 14', 'Jan 15', 'Jan 16', 'Jan 17', 'Jan 18'].map((d) => Text(d, style: TextStyle(color: AppColors.textSecondary.withOpacity(0.4), fontSize: 10))).toList(),
          )
        ],
      ),
    );
  }

  Widget _buildBar(double height, bool isActive) {
    return Container(
      width: 4,
      height: height,
      decoration: BoxDecoration(
        color: isActive ? AppColors.accentLime : AppColors.textSecondary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildTransactionList(BuildContext context) {
    return Container(
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
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 24, 24, 16),
            child: Text(
              'June 15, 2020',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildTransactionItem('Webflow', 'Outgoing transfer', '-\$45', Colors.blue),
                _buildTransactionItem('Sketch', 'Annual withdrawal of funds', '-\$79', Colors.orange),
                _buildTransactionItem('Youtube', 'Annual withdrawal of funds', '-\$15', Colors.red),
                _buildTransactionItem('Unsplash', 'Annual withdrawal of funds', '-\$9', Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(String title, String subtitle, String amount, Color iconColor) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(color: iconColor.withOpacity(0.1), shape: BoxShape.circle),
        child: Icon(Icons.adjust, color: iconColor, size: 20),
      ),
      title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: TextStyle(color: AppColors.textSecondary.withOpacity(0.5), fontSize: 12)),
      trailing: Text(amount, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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

class LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.textSecondary.withOpacity(0.2)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.2, size.height * 0.1, size.width * 0.4, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.6, size.height * 1.0, size.width * 0.8, size.height * 0.3);
    path.lineTo(size.width, size.height * 0.5);

    canvas.drawPath(path, paint);
    
    // Draw active point
    final activePaint = Paint()..color = AppColors.accentLime..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.75), 4, activePaint);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.75), 8, Paint()..color = activePaint.color.withOpacity(0.2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
