import 'package:get/get.dart';

import '../controllers/orderhistory_controller.dart';

class OrderhistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderhistoryController>(
      () => OrderhistoryController(),
    );
  }
}
