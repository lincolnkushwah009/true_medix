import 'dart:developer';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadprescriptionController extends GetxController {
  final ImagePicker picker = ImagePicker();
  RxString base64ImageString = "".obs;
  @override
  void onInit() {
    log("UploadprescriptionController Init....");
    super.onInit();
  }
}
