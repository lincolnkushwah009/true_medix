import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class BottomnavbarController extends GetxController {
  Logger logger = Logger();
  RxInt currentIndex = 0.obs;
  late PageController pageController;
  @override
  void onInit() {
    logger.i("BottomnavbarController Initiated");
    pageController = PageController();
    super.onInit();
  }

  @override
  void onReady() {
    logger.i("BottomnavbarController Ready");
    super.onReady();
  }

  @override
  void onClose() {
    logger.i("BottomnavbarController Closed");
    pageController.dispose();
    super.onClose();
  }
}
