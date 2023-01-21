import 'dart:developer';

import 'package:get/get.dart';

import '../../../services/apiServives/apiservices.dart';

class PastordersController extends GetxController {
  ApiServices apiServices = ApiServices();
  RxMap statusListData = {}.obs;
  RxList pastOrdersData = [].obs;

  initStatusList() async {
    statusListData.value = await apiServices.getStatusList();
    log(statusListData.toString());
  }

  @override
  void onInit() {
    log("ActiveordersController Init...");
    initStatusList();
    super.onInit();
  }
}
