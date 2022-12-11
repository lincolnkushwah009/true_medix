import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:true_medix/app/services/apiServives/apiservices.dart';

class OtpscreenController extends GetxController {
  Logger logger = Logger();
  TextEditingController verifyCodeController = TextEditingController();
  RxString code = "".obs;
  ApiServices apiServices = ApiServices();
  Rx<GetStorage> authIdGetStorage = GetStorage().obs;
  String authIdGetStorageKey = "AUTHID";
  RxString authId = "".obs;

  void storeUserDetails(String value) async {
    await authIdGetStorage.value
        .write(authIdGetStorageKey, value)
        .then((value) {
      log("AUTHID STORED SUCCESSFULLY....");
    }).onError((error, stackTrace) {
      log("AUTHID STORED FAILED....");
    });
    log(authIdGetStorage.value.read(authIdGetStorageKey));
  }

  String get getAuthId {
    authId.value = authIdGetStorage.value.read(authIdGetStorageKey).toString();
    return authId.value;
  }

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
