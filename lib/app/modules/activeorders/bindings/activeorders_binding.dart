import 'package:get/get.dart';

import '../controllers/activeorders_controller.dart';

class ActiveordersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActiveordersController>(
      () => ActiveordersController(),
    );
  }
}
