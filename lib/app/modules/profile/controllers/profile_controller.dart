import 'dart:developer';

import 'package:get/get.dart';
import 'package:true_medix/app/services/apiServives/apiservices.dart';

class ProfileController extends GetxController {
  ApiServices apiServices = ApiServices();
  RxBool isLoading = true.obs;
  RxMap profileDetails = {}.obs;
  @override
  void onInit() async {
    log("ProfileController init");
    super.onInit();
  }
}
