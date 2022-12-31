import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:true_medix/app/services/localstorage.dart';
import 'package:true_medix/app/utilities/appcolors.dart';
import 'app/routes/app_pages.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(statusBarColor: kPrimaryColor),
  );

  instantiateGetStorage().then((value) {
    log("GetStorage Initialised Success....");
  }).onError((error, stackTrace) {
    log("GetStorage Initialised Failed....");
  });
  LocalStorage localStorage = LocalStorage();
  localStorage.getCustomer;
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}

Future<void> instantiateGetStorage() async {
  await GetStorage.init();
}
