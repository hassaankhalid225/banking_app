import 'package:get/get.dart';
import 'app_routes.dart';
import 'app_bindings.dart';
import '../modules/auth/views/splash_screen.dart';
import '../modules/auth/views/passcode_screen.dart';
import '../modules/home/views/dashboard_screen.dart';

import '../modules/home/views/card_details_screen.dart';
import '../modules/home/views/messages_screen.dart';
import '../modules/home/views/chat_screen.dart';
import '../modules/home/views/transfer_screen.dart';
import '../modules/home/views/transfer_amount_screen.dart';
import '../modules/home/views/budget_screen.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: AuthBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: AppRoutes.passcode,
      page: () => const PasscodeScreen(),
      binding: AuthBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const DashboardScreen(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.cardDetails,
      page: () => const CardDetailsScreen(),
      binding: CardBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.messages,
      page: () => const MessagesScreen(),
      binding: MessagesBinding(),
    ),
    GetPage(
      name: AppRoutes.chat,
      page: () => const ChatScreen(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: AppRoutes.transfer,
      page: () => const TransferScreen(),
      binding: TransferBinding(),
    ),
    GetPage(
      name: AppRoutes.quickTransfer,
      page: () => const TransferAmountScreen(),
      binding: TransferBinding(),
    ),
    GetPage(
      name: AppRoutes.budget,
      page: () => const BudgetScreen(),
      binding: BudgetBinding(),
    ),
  ];
}
