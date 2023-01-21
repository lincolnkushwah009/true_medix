import 'dart:developer';

import 'package:get/get.dart';
import 'package:true_medix/app/services/apiServives/apiservices.dart';

class ActiveordersController extends GetxController {
  ApiServices apiServices = ApiServices();
  RxMap statusListData = {}.obs;

  Future<Map<dynamic, dynamic>> initStatusList() async {
    statusListData.value = await apiServices.getStatusList();
    update();
    log(statusListData.toString());
    return statusListData;
  }

  @override
  void onInit() {
    log("ActiveordersController Init...");
    initStatusList();
    super.onInit();
  }
}
