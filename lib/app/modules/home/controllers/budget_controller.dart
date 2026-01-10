import 'package:get/get.dart';

class BudgetController extends GetxController {
  final RxString selectedType = 'Analysis'.obs; // Analysis or Costs
  final RxString selectedPeriod = 'Week'.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is String) {
      selectedType.value = Get.arguments as String;
    }
  }

  void setType(String type) {
    selectedType.value = type;
  }
}
