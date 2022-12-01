import 'package:get/get.dart';

import '../controllers/navigationbar_controller.dart';

class NavigationbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomnavbarController>(
      () => BottomnavbarController(),
    );
  }
}
