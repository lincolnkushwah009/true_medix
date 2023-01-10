// ignore_for_file: unnecessary_getters_setters

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:true_medix/app/services/apiServives/apiservices.dart';

class RegisterController extends GetxController {
  //APISERVICE INSTANCE
  ApiServices apiServices = ApiServices();

  //Response Map
  RxMap accountResponse = {}.obs;

  //Loading Variables, Getters and Setters
  RxBool _accountCreatLoading = false.obs;
  set accountCreatLoading(RxBool loadingVal) {
    _accountCreatLoading = loadingVal;
    update();
  }

  RxBool get accountCreatLoading {
    return _accountCreatLoading;
  }

  //Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //Strings for Validation
  RxString validationMessageName = "".obs;
  RxString validationMessageEmail = "".obs;
  RxString validationMessagePhone = "".obs;
  RxString validationMessagePassword = "".obs;

  @override
  void onInit() {
    log("Registration Init...");
    super.onInit();
  }
}
