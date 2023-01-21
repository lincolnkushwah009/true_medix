import 'dart:developer';

import 'package:get/get.dart';

class SearchController extends GetxController {
  RxList searchProducts = [].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    log("SearchController Init...");
    super.onInit();
  }
}
