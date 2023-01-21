// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:true_medix/app/global/customermodel.dart';
import 'package:true_medix/app/utilities/appcolors.dart';
import 'app/routes/app_pages.dart';
import 'app/services/sessionmanager.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(statusBarColor: kPrimaryColor),
  );
  WidgetsFlutterBinding.ensureInitialized();
  SessionManager sessionManager = SessionManager();
  CustomerModel customerModel;
  customerModel = await sessionManager.getAuthToken();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Truemedix",
      initialRoute: customerModel.authId != null
          ? Routes.BOTTOMNAVBAR
          : Routes.LOGINWITHPASSWORD,
      getPages: AppPages.routes,
    ),
  );
}
