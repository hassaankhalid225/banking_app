import 'package:get/get.dart';
import '../../../data/models/contact_model.dart';
import '../../../data/services/mock_data_service.dart';

class TransferController extends GetxController {
  final RxList<ContactModel> contacts = <ContactModel>[].obs;
  final RxList<ContactModel> recentContacts = <ContactModel>[].obs;
  final RxBool isLoading = true.obs;
  
  final Rx<ContactModel?> selectedContact = Rx<ContactModel?>(null);
  final RxString amount = '0'.obs;

  @override
  void onInit() {
    super.onInit();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(milliseconds: 500));
      
      final mockData = MockDataService.getAllMockData();
      final allContacts = List<ContactModel>.from(mockData['contacts']);
      
      contacts.value = allContacts;
      recentContacts.value = allContacts.take(4).toList();
      
    } catch (e) {
      print('Error loading contacts: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void onNumberPressed(String number) {
    if (amount.value == '0') {
      amount.value = number;
    } else {
      amount.value += number;
    }
  }

  void onDeletePressed() {
    if (amount.value.length > 1) {
      amount.value = amount.value.substring(0, amount.value.length - 1);
    } else {
      amount.value = '0';
    }
  }
}
