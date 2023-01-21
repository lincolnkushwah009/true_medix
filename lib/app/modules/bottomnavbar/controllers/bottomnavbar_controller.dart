import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomnavbarController extends GetxController {
  RxInt currentIndex = 0.obs;
  late PageController pageController;
  @override
  void onInit() {
    log("BottomnavbarController Initiated");
    pageController = PageController();
    super.onInit();
  }

  @override
  void onReady() {
    log("BottomnavbarController Ready");
    super.onReady();
  }

  @override
  void onClose() {
    log("BottomnavbarController Closed");
    pageController.dispose();
    super.onClose();
  }
}
