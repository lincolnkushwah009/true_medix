import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:true_medix/app/services/apiServives/apiservices.dart';

class LoginController extends GetxController {
  Logger logger = Logger();
  TextEditingController phoneController = TextEditingController();
  ApiServices apiServices = ApiServices();
  @override
  void onInit() {
    logger.i("LoginController Initialised...");
    super.onInit();
  }

  @override
  void onReady() {
    logger.i("LoginController Ready...");

    super.onReady();
  }

  @override
  void onClose() {
    logger.i("LoginController Closed...");

    super.onClose();
  }
}
