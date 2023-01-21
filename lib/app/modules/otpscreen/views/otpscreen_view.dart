// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:true_medix/app/services/sessionmanager.dart';

import '../../../routes/app_pages.dart';
import '../../../utilities/appcolors.dart';
import '../../../utilities/appstyles.dart';
import '../../bottomnavbar/views/bottomnavbar_view.dart';
import '../controllers/otpscreen_controller.dart';

class OtpscreenView extends GetView<OtpscreenController> {
  OtpscreenView({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    OtpscreenController controller =
        Get.put<OtpscreenController>(OtpscreenController());
    SessionManager sessionManager = SessionManager();
    String phone = Get.arguments ?? '';
    return LoaderOverlay(
      useDefaultLoading: true,
      overlayColor: kPrimaryColor,
      overlayWholeScreen: true,
      switchInCurve: Curves.bounceIn,
      switchOutCurve: Curves.bounceOut,
      closeOnBackButton: false,
      disableBackButton: true,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 30,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0.0, bottom: 27),
                    child: Image.asset(
                      "assets/authImage.png",
                      height: 200,
                      width: 224,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.632,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Enter OTP",
                        style: heading1Style,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text("Enter OTP number to Sign In",
                          textAlign: TextAlign.center, style: heading2Style),
                      const SizedBox(
                        height: 50,
                      ),
                      Form(
                        key: formKey,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 31.0, right: 31),
                                child: PinCodeTextField(
                                  showCursor: true,
                                  cursorColor: kPrimaryColor,
                                  length: 6,
                                  obscureText: true,
                                  animationType: AnimationType.scale,
                                  validator: ((value) {
                                    if (value!.isEmpty) {
                                      return "";
                                    } else {
                                      return null;
                                    }
                                  }),
                                  pinTheme: PinTheme(
                                    inactiveColor: Colors.transparent,
                                    inactiveFillColor: Colors.white,
                                    selectedFillColor: Colors.white,
                                    selectedColor: Colors.cyan,
                                    activeColor: Colors.cyan,
                                    disabledColor: Colors.cyan,
                                    errorBorderColor: Colors.red,
                                    shape: PinCodeFieldShape.box,
                                    borderRadius: BorderRadius.circular(10),
                                    fieldHeight: 50,
                                    fieldWidth: 50,
                                    activeFillColor: Colors.white,
                                  ),
                                  // animationDuration:
                                  //     const Duration(milliseconds: 300),
                                  backgroundColor: Colors.transparent,
                                  enableActiveFill: true,
                                  controller: controller.verifyCodeController,
                                  onCompleted: (v) {
                                    if (kDebugMode) {
                                      print(
                                          "Verification Code Completed: ${controller.verifyCodeController.text}");
                                    }
                                  },
                                  onChanged: (codeValue) {
                                    if (kDebugMode) {
                                      print(
                                          "Verification Code ---> : ${controller.verifyCodeController.text}");
                                    }
                                    controller.code.value = codeValue;
                                  },
                                  beforeTextPaste: (text) {
                                    if (kDebugMode) {
                                      print("Verification Code paste $text");
                                    }
                                    return false;
                                  },
                                  appContext: context,
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              InkWell(
                                onTap: () async {
                                  if (formKey.currentState!.validate()) {
                                    context.loaderOverlay.show();
                                    log(controller.code.toString());
                                    log(phone);
                                    controller.apiServices
                                        .loginOTPVerify(
                                            otp: controller.code.toString(),
                                            phone: phone)
                                        .then((value) {
                                      log(value.data.toString());
                                      sessionManager
                                          .setAuthToken(value.data['customer']);
                                      log(value.statusCode.toString());
                                      if (value.statusCode == 200) {
                                        log(value.data['customer'].toString());
                                        ElegantNotification.success(
                                          title: const Text("Success"),
                                          description:
                                              Text(value.data['message']),
                                        ).show(context);
                                        Future.delayed(
                                            const Duration(seconds: 3), () {
                                          context.loaderOverlay.hide();
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BottomnavbarView(
                                                incomingIndex: 0,
                                              ),
                                            ),
                                          );
                                        });
                                      } else {
                                        ElegantNotification.error(
                                          title: const Text("Oops"),
                                          description:
                                              Text(value.data['message']),
                                        ).show(context);
                                        context.loaderOverlay.hide();
                                      }
                                    }).onError((error, stackTrace) {
                                      ElegantNotification.error(
                                        title: const Text("Oops"),
                                        description:
                                            const Text("Something went wrong"),
                                      ).show(context);
                                      context.loaderOverlay.hide();
                                    });
                                  } else {
                                    context.loaderOverlay.show();
                                    ElegantNotification.error(
                                      title: const Text("Oops"),
                                      description:
                                          const Text("Please check the fields"),
                                    ).show(context);
                                    context.loaderOverlay.hide();
                                  }
                                },
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: kBtnColor,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  child: Center(
                                    child: Text(
                                      "Submit",
                                      style: btnStyle,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 153,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Don’t have an account?",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  const SizedBox(
                                    width: 18,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.offNamed(Routes.REGISTER);
                                    },
                                    child: Text(
                                      "Create New",
                                      style: TextStyle(
                                        color: kBtnColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 31,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
