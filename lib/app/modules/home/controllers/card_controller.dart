import 'package:get/get.dart';
import '../../../data/models/card_model.dart';
import '../../../data/models/transaction_model.dart';
import '../../../data/services/mock_data_service.dart';

class CardController extends GetxController {
  final Rx<CardModel?> selectedCard = Rx<CardModel?>(null);
  final RxList<TransactionModel> cardTransactions = <TransactionModel>[].obs;
  final RxBool isLoading = true.obs;

  final RxInt cardIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map<String, dynamic>) {
      selectedCard.value = args['card'] as CardModel?;
      cardIndex.value = args['index'] as int? ?? 0;
    } else if (args is CardModel) {
      selectedCard.value = args;
      cardIndex.value = 0;
    }

    if (selectedCard.value != null) {
      _loadCardTransactions(selectedCard.value!.id);
    }
  }

  Future<void> _loadCardTransactions(String cardId) async {
    try {
      isLoading.value = true;
      // Simulate delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      final mockData = MockDataService.getAllMockData();
      final allTransactions = List<TransactionModel>.from(mockData['transactions']);
      
      // For dummy purpose, showing some transactions
      cardTransactions.value = allTransactions.take(10).toList();
      
    } catch (e) {
      print('Error loading card transactions: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
