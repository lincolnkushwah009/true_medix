import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:true_medix/app/services/apiServives/apiservices.dart';

class LoginController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  ApiServices apiServices = ApiServices();
  RxBool isloading = false.obs;
  @override
  void onInit() {
    log("LoginController Init...");
    super.onInit();
  }
}
