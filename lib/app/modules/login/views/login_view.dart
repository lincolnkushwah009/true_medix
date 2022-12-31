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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 70.0),
                    child: Image.asset(
                      "assets/authImage.png",
                      height: 260,
                      width: 300,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.52,
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
                        "Input Phone Number",
                        style: heading1Style,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text("Use phone number to sign in or sign up",
                          textAlign: TextAlign.center, style: heading2Style),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: Center(
                          child: Form(
                            key: formKey,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "";
                                } else {
                                  return null;
                                }
                              },
                              controller: controller.phoneController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                                contentPadding: EdgeInsets.only(top: 14),
                                hintText: 'Phone / Email',
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            context.loaderOverlay.show();
                            controller.apiServices
                                .loginWithOTP(
                                    phone:
                                        controller.phoneController.text.trim())
                                .then((value) {
                              log(value.data.toString());
                              log(value.statusCode.toString());
                              if (value.statusCode == 200) {
                                log(value.data['message'].toString());
                                ElegantNotification.success(
                                  title: const Text("Success"),
                                  description:
                                      Text(value.data['message'].toString()),
                                ).show(context);
                                Future.delayed(const Duration(seconds: 3), () {
                                  context.loaderOverlay.hide();
                                  Get.toNamed(Routes.OTPSCREEN,
                                      arguments: controller.phoneController.text
                                          .toString());
                                });
                              } else {
                                log(value.data['message']['email_mobile']
                                    .toString());
                                ElegantNotification.error(
                                        title: const Text("Oops"),
                                        description: Text(value.data['message']
                                                ['email_mobile']
                                            .toString()))
                                    .show(context);
                                context.loaderOverlay.hide();
                              }
                            }).onError((error, stackTrace) {
                              ElegantNotification.error(
                                title: const Text("Oops"),
                                description: const Text("Something went wrong"),
                              ).show(context);
                              context.loaderOverlay.hide();
                            });
                          } else {
                            formKey.currentState!.reset();
                            ElegantNotification.error(
                              title: const Text("Oops"),
                              description:
                                  const Text("Please check the fields"),
                            ).show(context);
                          }
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: kBtnColor,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: Center(
                            child: Text(
                              "SEND OTP",
                              style: btnStyle,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          Get.offNamed(Routes.LOGINWITHPASSWORD);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.password),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              "Login with Password Instead",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
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
