// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:true_medix/app/routes/app_pages.dart';
import 'package:true_medix/app/utilities/appcolors.dart';
import 'package:true_medix/app/utilities/appstyles.dart';

import '../controllers/login_controller.dart';

// ignore: must_be_immutable
class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    LoginController controller = Get.put<LoginController>(LoginController());
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
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50.0, bottom: 27),
                    child: Image.asset(
                      "assets/authImage.png",
                      height: 200,
                      width: 224,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Align(
                      child: Container(
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
                              "Login with OTP",
                              style: heading1Style,
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            Text("Use  Phone number to sign in or Sign Up",
                                textAlign: TextAlign.center,
                                style: heading2Style),
                            const SizedBox(
                              height: 32,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 58,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      child: Center(
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "";
                                            } else {
                                              return null;
                                            }
                                          },
                                          controller:
                                              controller.phoneController,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 23),
                                              hintText: 'Phone / Email',
                                              hintStyle: hintStyle),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 36,
                                    ),
                                    InkWell(
                                      splashColor: Colors.black,
                                      highlightColor: Colors.green,
                                      onTap: () async {
                                        if (formKey.currentState!.validate()) {
                                          context.loaderOverlay.show();
                                          controller.apiServices
                                              .loginWithOTP(
                                                  phone: controller
                                                      .phoneController.text
                                                      .trim())
                                              .then((value) {
                                            log(value.data.toString());
                                            log(value.statusCode.toString());
                                            if (value.statusCode == 200) {
                                              log(value.data['message']
                                                  .toString());
                                              ElegantNotification.success(
                                                title: const Text("Success"),
                                                description: Text(value
                                                    .data['message']
                                                    .toString()),
                                              ).show(context);
                                              Future.delayed(
                                                  const Duration(seconds: 3),
                                                  () {
                                                context.loaderOverlay.hide();
                                                Get.toNamed(Routes.OTPSCREEN,
                                                    arguments: controller
                                                        .phoneController.text
                                                        .toString());
                                              });
                                            } else {
                                              log(value.data['message']
                                                      ['email_mobile']
                                                  .toString());
                                              ElegantNotification.error(
                                                      title: const Text("Oops"),
                                                      description: Text(value
                                                          .data['message']
                                                              ['email_mobile']
                                                          .toString()))
                                                  .show(context);
                                              context.loaderOverlay.hide();
                                            }
                                          }).onError((error, stackTrace) {
                                            ElegantNotification.error(
                                              title: const Text("Oops"),
                                              description: const Text(
                                                  "Something went wrong"),
                                            ).show(context);
                                            context.loaderOverlay.hide();
                                          });
                                        } else {
                                          formKey.currentState!.reset();
                                          ElegantNotification.error(
                                            title: const Text("Oops"),
                                            description: const Text(
                                                "Please check the fields"),
                                          ).show(context);
                                        }
                                      },
                                      child: Container(
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: kBtnColor,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.85,
                                        child: Center(
                                          child: Text(
                                            "Send OTP",
                                            style: btnStyle,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            InkWell(
                              splashColor: Colors.black,
                              highlightColor: Colors.green,
                              onTap: () async {
                                Get.offNamed(Routes.LOGINWITHPASSWORD);
                              },
                              child: Container(
                                height: 58,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border:
                                      Border.all(color: kBtnColor, width: 1),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Center(
                                  child: Text(
                                    "Login with Password",
                                    style: btnStyle.copyWith(color: kBtnColor),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 93,
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
                                  splashColor: Colors.black,
                                  highlightColor: Colors.green,
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
                            Container(
                              height: 115,
                              color: kPrimaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
