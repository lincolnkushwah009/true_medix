import 'package:get/get.dart';

import '../controllers/pastorders_controller.dart';

class PastordersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PastordersController>(
      () => PastordersController(),
    );
  }
}
