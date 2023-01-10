// ignore_for_file: prefer_final_fields, constant_identifier_names

import 'dart:developer';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:true_medix/app/modules/profile/model/getaddressmodel.dart';
import 'package:true_medix/app/modules/profile/model/profilemodel.dart';
import 'package:true_medix/app/services/apiServives/apiservices.dart';

class ProfileController extends GetxController {
  ApiServices apiServices = ApiServices();
  RxBool _profileLoading = false.obs;
  RxBool _getAddressLoading = false.obs;

  ProfileModel _profileDetails = ProfileModel();
  List<GetAddressModel> _getAddressDetails = [];
  final ImagePicker picker = ImagePicker();

  set profileLoading(RxBool loadingVal) {
    _profileLoading = loadingVal;
    update();
  }

  set getAddressLoading(RxBool loadingVal) {
    _getAddressLoading = loadingVal;
    update();
  }

  RxBool get profileLoading => _profileLoading;
  RxBool get getAddressLoading => _getAddressLoading;

  ProfileModel get profileDetails => _profileDetails;
  List<GetAddressModel> get getAddressDetails => _getAddressDetails;

  Future<void> initGetMyProfile() async {
    profileLoading = true.obs;
    _profileDetails = await apiServices.getMyProfileDetails();
    profileDetails;
    profileLoading = false.obs;
    update();
  }

  Future<void> initGetAddressDetails() async {
    _getAddressLoading = true.obs;
    _getAddressDetails = await apiServices.getAddress();
    getAddressDetails;
    getAddressLoading = false.obs;
    update();
  }

  @override
  void onInit() async {
    log("ProfileController init");
    initGetMyProfile();
    initGetAddressDetails();
    super.onInit();
  }

  @override
  void onClose() {
    log("ProfileController onClose");
    super.onClose();
  }
}
