import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:true_medix/app/modules/otpscreen/controllers/otpscreen_controller.dart';

import '../../../utilities/appcolors.dart';
import '../../../utilities/appstyles.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  ProfileController? controller;
  OtpscreenController? otpscreenController;
  @override
  void initState() {
    controller = Get.put<ProfileController>(ProfileController());
    otpscreenController = Get.put<OtpscreenController>(OtpscreenController());
    log("=========================");
    log(otpscreenController!.getAuthId);
    log("=========================");
    log("InitState API");
    initCallProfile();
    super.initState();
  }

  Future<void> initCallProfile() async {
    await getMyProfileDetails(otpscreenController!.getAuthId);
  }

  Future<void> getMyProfileDetails(String authId) async {
    log("Api Inprogress");
    try {
      var response = await http.get(
        Uri.parse(
            "https://www.hiyutech.in/truemedex/apis/v1/customers/profile?AuthId=$authId"),
      );
      log(response.body.toString());
      Map<String, dynamic> parsedData =
          jsonDecode(response.body) as Map<String, dynamic>;
      controller!.profileDetails.value = parsedData;
      log(controller!.profileDetails.toString());
      controller!.isLoading.value = false;
    } catch (e) {
      log(e.toString());
      throw "getMyProfile Failed...";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          'LOGO',
          style: iconTextStyle.copyWith(fontSize: 22),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Obx(() {
          return SingleChildScrollView(
            child: controller!.isLoading.value == true
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 160.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height - 103,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                            ),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.only(top: 90.0),
                              child: Column(
                                children: [
                                  Container(
                                    height: 59,
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                        color: Color(0XFF67B0D0)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 54.0, right: 27),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Name",
                                            style: profileTextStyle,
                                          ),
                                          Text(
                                            controller!
                                                .profileDetails['customer']
                                                    ['name']
                                                .toString(),
                                            style: profileTextStyle,
                                          ),
                                          Container(
                                            height: 24,
                                            width: 24,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: const Icon(
                                              Icons.edit,
                                              size: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Container(
                                    height: 124,
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                        color: Color(0XFF67B0D0)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 54.0, right: 27),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Address",
                                            style: profileTextStyle,
                                          ),
                                          const Spacer(),
                                          Text(
                                            "371, 5th Main Rd,\nSector 6, HSR Layout,\nBengaluru, Karnataka\n560068",
                                            style: profileTextStyle,
                                          ),
                                          Container(
                                            height: 24,
                                            width: 24,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: const Icon(
                                              Icons.edit,
                                              size: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Container(
                                    height: 59,
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                        color: Color(0XFF67B0D0)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 54.0, right: 27),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Phone",
                                            style: profileTextStyle,
                                          ),
                                          Text(
                                            controller!
                                                .profileDetails['customer']
                                                    ['mobile_no']
                                                .toString(),
                                            style: profileTextStyle,
                                          ),
                                          Container(
                                            height: 24,
                                            width: 24,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: const Icon(
                                              Icons.edit,
                                              size: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 55.0, right: 10, top: 40),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 51.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Profile",
                                style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                height: 103,
                                width: 103,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 2,
                                      color: Colors.grey,
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(51),
                                ),
                                child: Image.asset(
                                  "assets/account.png",
                                  width: 65,
                                  height: 65,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          );
        }),
      ),
    );
  }
}
