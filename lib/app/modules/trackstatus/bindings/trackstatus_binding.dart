import 'package:get/get.dart';

import '../controllers/trackstatus_controller.dart';

class TrackstatusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrackstatusController>(
      () => TrackstatusController(),
    );
  }
}
