import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class LoginController extends GetxController {
  Logger logger = Logger();
  TextEditingController phoneController = TextEditingController();
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
