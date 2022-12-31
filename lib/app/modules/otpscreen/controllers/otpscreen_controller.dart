import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:true_medix/app/services/apiServives/apiservices.dart';

class OtpscreenController extends GetxController {
  Logger logger = Logger();
  TextEditingController verifyCodeController = TextEditingController();
  RxString code = "".obs;
  ApiServices apiServices = ApiServices();
  @override
  void onInit() {
    logger.i("OtpscreenController Initialised...");
    super.onInit();
  }

  @override
  void onReady() {
    logger.i("OtpscreenController Ready...");

    super.onReady();
  }

  @override
  void onClose() {
    logger.i("OtpscreenController Closed...");

    super.onClose();
  }
}
