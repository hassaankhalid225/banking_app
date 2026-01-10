import 'package:get/get.dart';
import '../../../data/models/message_model.dart';
import '../../../data/services/mock_data_service.dart';

class MessagesController extends GetxController {
  final RxList<MessageModel> messages = <MessageModel>[].obs;
  final RxBool isLoading = true.obs;
  final RxString selectedCategory = 'Actions'.obs;

  @override
  void onInit() {
    super.onInit();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(milliseconds: 500));
      
      final mockData = MockDataService.getAllMockData();
      messages.value = List<MessageModel>.from(mockData['messages']);
      
    } catch (e) {
      print('Error loading messages: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void setCategory(String category) {
    selectedCategory.value = category;
  }
}
