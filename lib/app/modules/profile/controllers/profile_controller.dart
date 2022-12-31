// ignore_for_file: prefer_final_fields

import 'dart:developer';

import 'package:get/get.dart';
import 'package:true_medix/app/modules/profile/model/profilemodel.dart';
import 'package:true_medix/app/services/apiServives/apiservices.dart';

class ProfileController extends GetxController {
  ApiServices apiServices = ApiServices();
  RxBool _profileLoading = false.obs;
  ProfileModel _profileDetails = ProfileModel();

  set profileLoading(RxBool loadingVal) {
    _profileLoading = loadingVal;
    update();
  }

  RxBool get profileLoading => _profileLoading;

  ProfileModel get profileDetails => _profileDetails;

  Future<void> initGetMyProfile() async {
    profileLoading = true.obs;
    log("Profile API in Progress");
    _profileDetails = await apiServices.getMyProfileDetails();
    profileDetails;
    profileLoading = false.obs;
    log(profileLoading.toString());
    update();
  }

  @override
  void onInit() async {
    log("ProfileController init");
    initGetMyProfile();
    super.onInit();
  }

  @override
  void onClose() {
    log("ProfileController onClose");
    super.onClose();
  }
}
