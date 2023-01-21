import 'dart:developer';

import 'package:get/get.dart';
import 'package:true_medix/app/services/apiServives/apiservices.dart';

class PamentsummaryController extends GetxController {
  ApiServices apiServices = ApiServices();

  RxString paymentStatus = "ERROR".obs;
  @override
  void onInit() {
    log("PamentsummaryController Init...");
    super.onInit();
  }
}
