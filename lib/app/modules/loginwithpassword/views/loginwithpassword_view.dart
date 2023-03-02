import 'dart:developer';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:true_medix/app/modules/bottomnavbar/views/bottomnavbar_view.dart';
import 'package:true_medix/app/services/sessionmanager.dart';
import 'package:true_medix/app/utilities/appcolors.dart';
import 'package:true_medix/app/utilities/appstyles.dart';

import '../../../routes/app_pages.dart';
import '../controllers/loginwithpassword_controller.dart';

// ignore: must_be_immutable
class LoginwithpasswordView extends StatefulWidget {
  const LoginwithpasswordView({Key? key}) : super(key: key);

  @override
  State<LoginwithpasswordView> createState() => _LoginwithpasswordViewState();
}

class _LoginwithpasswordViewState extends State<LoginwithpasswordView> {
  LoginwithpasswordController? controller;
  @override
  void initState() {
    controller =
        Get.put<LoginwithpasswordController>(LoginwithpasswordController());
    super.initState();
  }

  var formKey = GlobalKey<FormState>();

  SessionManager sessionManager = SessionManager();

  @override
  Widget build(BuildContext context) {
    LoginwithpasswordController controller =
        Get.put<LoginwithpasswordController>(LoginwithpasswordController());

    return LoaderOverlay(
      useDefaultLoading: true,
      overlayColor: kPrimaryColor,
      overlayWholeScreen: true,
      switchInCurve: Curves.bounceIn,
      switchOutCurve: Curves.bounceOut,
      closeOnBackButton: true,
      disableBackButton: false,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0, bottom: 27),
                    child: Image.asset(
                      "assets/authImage.png",
                      height: 200,
                      width: 224,
                    ),
                  ),
                ),
                Container(
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
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 20, bottom: 47),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Login",
                            style: heading1Style,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Container(
                                height: 58,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        controller.validationMessageEmailPhone
                                                .value =
                                            "Email / Phone can't be Empty";
                                        controller.update();
                                        return "";
                                      } else {
                                        controller.validationMessageEmailPhone
                                            .value = "";
                                        controller.update();

                                        return null;
                                      }
                                    },
                                    controller: controller.emailPhoneController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding:
                                            const EdgeInsets.only(left: 23),
                                        hintText: 'Email / Phone',
                                        hintStyle: hintStyle),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
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
                                        controller.validationMessagePassword
                                            .value = "Password can't be Empty";
                                        controller.update();
                                        return controller
                                            .validationMessagePassword.value;
                                      } else {
                                        controller.validationMessagePassword
                                            .value = "";
                                        controller.update();
                                        return null;
                                      }
                                    },
                                    controller: controller.passwordController,
                                    keyboardType: TextInputType.text,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding:
                                            const EdgeInsets.only(left: 23),
                                        hintText: 'Password',
                                        hintStyle: hintStyle),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 47,
                              ),
                              GetBuilder<LoginwithpasswordController>(
                                  builder: (controller) {
                                return InkWell(
                                  splashColor: Colors.black,
                                  highlightColor: Colors.green,
                                  onTap: () async {
                                    log(controller.emailPhoneController.text
                                        .toString());
                                    log(controller.passwordController.text
                                        .toString());
                                    context.loaderOverlay.show();
                                    controller.update();
                                    if (formKey.currentState!.validate()) {
                                      context.loaderOverlay.show();
                                      controller.apiServices
                                          .loginWithPassword(
                                              emailMobile: controller
                                                  .emailPhoneController.text
                                                  .trim()
                                                  .toString(),
                                              password: controller
                                                  .passwordController.text
                                                  .trim()
                                                  .toString())
                                          .then((value) {
                                        log(value.toString());
                                        sessionManager
                                            .setAuthToken(value['customer']);
                                        log("=======================================");
                                        log(sessionManager
                                            .getAuthToken()
                                            .toString());
                                        log(value['customer'].toString());
                                        ElegantNotification.success(
                                          toastDuration:
                                              const Duration(seconds: 3),
                                          title: const Text("Success"),
                                          description: Text(value['message']),
                                        ).show(context);
                                        Future.delayed(
                                            const Duration(seconds: 3), () {
                                          context.loaderOverlay.hide();
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BottomnavbarView(
                                                      incomingIndex: 0),
                                            ),
                                          );
                                        });
                                      }).onError((error, stackTrace) {
                                        ElegantNotification.error(
                                          toastDuration:
                                              const Duration(seconds: 3),
                                          title: const Text("Oops"),
                                          description: const Text(
                                              "Authentication Failed"),
                                        ).show(context);
                                        context.loaderOverlay.hide();
                                      });
                                    } else {
                                      formKey.currentState!.reset();
                                      controller.update();
                                      ElegantNotification.error(
                                        toastDuration:
                                            const Duration(seconds: 3),
                                        title: const Text("Validation Error"),
                                        description: Text(
                                            "${controller.validationMessageEmailPhone.value}\n${controller.validationMessagePassword.value}"),
                                      ).show(context);
                                      context.loaderOverlay.hide();
                                    }
                                  },
                                  child: Container(
                                    height: 58,
                                    decoration: BoxDecoration(
                                      color: kBtnColor,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: Center(
                                      child: Text(
                                        "Submit",
                                        style: btnStyle,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                splashColor: Colors.black,
                                highlightColor: Colors.green,
                                onTap: () async {
                                  Get.offNamed(Routes.LOGIN);
                                },
                                child: Container(
                                  height: 58,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border:
                                        Border.all(color: kBtnColor, width: 1),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: Center(
                                    child: Text(
                                      "Login with OTP",
                                      style:
                                          btnStyle.copyWith(color: kBtnColor),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 54,
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
                                    child: Ink(
                                      child: Text(
                                        "Create New",
                                        style: TextStyle(
                                          color: kBtnColor,
                                        ),
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
                Container(
                  height: 100,
                  color: kPrimaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
