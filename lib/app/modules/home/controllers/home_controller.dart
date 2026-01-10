import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../data/models/account_model.dart';
import '../../../data/models/card_model.dart';
import '../../../data/models/transaction_model.dart';
import '../../../data/services/mock_data_service.dart';
import '../../../data/services/storage_service.dart';
import '../../../routes/app_routes.dart';

class HomeController extends GetxController {
  final StorageService _storageService = StorageService();

  final RxList<AccountModel> accounts = <AccountModel>[].obs;
  final RxList<CardModel> cards = <CardModel>[].obs;
  final RxList<TransactionModel> recentTransactions = <TransactionModel>[].obs;

  final Rx<AccountModel?> selectedAccount = Rx<AccountModel?>(null);
  final RxBool isLoading = true.obs;
  final RxBool showPromoBanner = true.obs;
  final RxInt selectedBottomNavIndex = 0.obs;

  @override
  void onReady() {
    super.onReady();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      isLoading.value = true;

      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      // Load mock data
      final mockData = MockDataService.getAllMockData();
      accounts.value = List<AccountModel>.from(mockData['accounts']);
      cards.value = List<CardModel>.from(mockData['cards']);

      final allTransactions = List<TransactionModel>.from(mockData['transactions']);
      recentTransactions.value = allTransactions.take(5).toList();

      // Set selected account
      final savedAccountId = _storageService.selectedAccountId;
      if (savedAccountId != null) {
        selectedAccount.value = accounts.firstWhereOrNull(
          (account) => account.id == savedAccountId,
        );
      }

      selectedAccount.value ??= accounts.firstWhereOrNull(
        (account) => account.isPrimary,
      );
      selectedAccount.value ??= accounts.firstOrNull;

      debugPrint(
        'HomeController: Loaded ${accounts.length} accounts, ${cards.length} cards, ${recentTransactions.length} transactions',
      );
    } catch (e) {
      debugPrint('Error loading data: $e');
      // Failsafe: Populate with dummy cards if verify load fails
       cards.value = MockDataService.getMockCards();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshData() async {
    await _loadData();
  }

  void selectAccount(AccountModel account) {
    selectedAccount.value = account;
    _storageService.setSelectedAccountId(account.id);
  }

  void dismissPromoBanner() {
    showPromoBanner.value = false;
  }

  void onBottomNavTap(int index) {
    if (selectedBottomNavIndex.value == index) return;

    if (index == 0) {
      selectedBottomNavIndex.value = 0;
      Get.until((route) => route.settings.name == AppRoutes.home);
    } else {
      selectedBottomNavIndex.value = index;
      if (index == 3) {
        _navigateOrSwitch(AppRoutes.messages);
      } else if (index == 1) {
        // Assuming Shop/Budget goes to Budget for now
        _navigateOrSwitch(AppRoutes.budget, arguments: 'Costs');
      } else if (index == 2) {
         // Cards logic - usually stay on home or custom view
         // For now, if we are not on home, go home
         Get.until((route) => route.settings.name == AppRoutes.home);
      }
    }
  }

  void _navigateOrSwitch(String routeName, {dynamic arguments}) {
    if (Get.currentRoute == AppRoutes.home) {
      Get.toNamed(routeName, arguments: arguments);
    } else {
      Get.offNamed(routeName, arguments: arguments);
    }
  }

  double get totalBalance {
    if (accounts.isEmpty) return 0.0;
    return accounts.fold(0.0, (sum, account) => sum + account.balance);
  }

  List<CardModel> get selectedAccountCards {
    if (selectedAccount.value == null) return [];
    return cards
        .where((card) => card.accountId == selectedAccount.value!.id)
        .toList();
  }

  String get formattedBalance {
    final balance = selectedAccount.value?.balance ?? 0.0;
    return '\$${balance.toStringAsFixed(2)}';
  }

  String get formattedTotalBalance {
    return '\$${totalBalance.toStringAsFixed(2)}';
  }
}
