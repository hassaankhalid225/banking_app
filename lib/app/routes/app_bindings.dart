import 'package:get/get.dart';
import '../modules/auth/controllers/splash_controller.dart';
import '../modules/auth/controllers/passcode_controller.dart';
import '../modules/home/controllers/home_controller.dart';
import '../modules/home/controllers/card_controller.dart';
import '../modules/home/controllers/messages_controller.dart';
import '../modules/home/controllers/chat_controller.dart';
import '../modules/home/controllers/transfer_controller.dart';
import '../modules/home/controllers/budget_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
    Get.lazyPut<PasscodeController>(() => PasscodeController());
  }
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}

class CardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CardController>(() => CardController());
  }
}

class MessagesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MessagesController>(() => MessagesController());
  }
}

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(() => ChatController());
  }
}

class TransferBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransferController>(() => TransferController());
  }
}

class BudgetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BudgetController>(() => BudgetController());
  }
}
