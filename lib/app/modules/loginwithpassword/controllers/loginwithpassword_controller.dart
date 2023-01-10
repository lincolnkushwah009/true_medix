import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:true_medix/app/services/apiServives/apiservices.dart';
import 'package:true_medix/app/services/localstorage.dart';

class LoginwithpasswordController extends GetxController {
  RxString validationMessageEmailPhone = "".obs;
  RxString validationMessagePassword = "".obs;

  TextEditingController emailPhoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ApiServices apiServices = ApiServices();
  LocalStorage localStorage = LocalStorage();
  @override
  void onInit() {
    log("LoginWithPassword init...");
    super.onInit();
  }
}
