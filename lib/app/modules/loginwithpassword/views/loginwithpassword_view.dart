import 'dart:developer';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:true_medix/app/utilities/appcolors.dart';
import 'package:true_medix/app/utilities/appstyles.dart';

import '../../../routes/app_pages.dart';
import '../controllers/loginwithpassword_controller.dart';

// ignore: must_be_immutable
class LoginwithpasswordView extends GetView<LoginwithpasswordController> {
  LoginwithpasswordView({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
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
                  height: MediaQuery.of(context).size.height * 0.7,
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
                        padding: const EdgeInsets.all(20.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Login",
                            style: heading1Style,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              width: MediaQuery.of(context).size.width * 0.85,
                              child: Center(
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Email / Phone can't be Empty";
                                    }
                                    if (!EmailValidator.validate(value)) {
                                      return value.contains("@") &&
                                              value.contains(".")
                                          ? controller.validationMessage.value =
                                              "Please Enter Valid Email"
                                          : "";
                                    }
                                    if (value.length < 10) {
                                      controller.validationMessage.value =
                                          "Phone can't be less than 10 Digits Valid Email";
                                      return "";
                                    }
                                    if (value.length > 10) {
                                      return value.contains("@")
                                          ? null
                                          : controller.validationMessage.value =
                                              "Phone can't be greater than 10 Digits Valid Email";
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: controller.emailPhoneController,
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Colors.black,
                                    ),
                                    contentPadding: EdgeInsets.only(top: 14),
                                    hintText: 'Email / Phone',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              width: MediaQuery.of(context).size.width * 0.85,
                              child: Center(
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      controller!.validationMessage.value =
                                          "Password can't be Empty";
                                      return "";
                                    }
                                    if (value.length < 6) {
                                      controller!.validationMessage.value =
                                          "Password can't be less than 6 characters";
                                      return "";
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: controller.passwordController,
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Icons.password,
                                      color: Colors.black,
                                    ),
                                    contentPadding: EdgeInsets.only(top: 14),
                                    hintText: 'Password',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            GetBuilder<LoginwithpasswordController>(
                                builder: (controller) {
                              return InkWell(
                                onTap: () async {
                                  context.loaderOverlay.show();
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
                                      controller.localStorage
                                          .storeUserDetails(value['customer']);
                                      log(value['customer'].toString());
                                      ElegantNotification.success(
                                        title: const Text("Success"),
                                        description: Text(value['message']),
                                      ).show(context);
                                      Future.delayed(const Duration(seconds: 3),
                                          () {
                                        context.loaderOverlay.hide();
                                        Get.toNamed(Routes.BOTTOMNAVBAR);
                                      });
                                    }).onError((error, stackTrace) {
                                      ElegantNotification.error(
                                        title: const Text("Oops"),
                                        description:
                                            const Text("Authentication Failed"),
                                      ).show(context);
                                      context.loaderOverlay.hide();
                                    });
                                  } else {
                                    formKey.currentState!.reset();
                                    ElegantNotification.error(
                                      toastDuration: const Duration(seconds: 2),
                                      title: const Text("Validation Error"),
                                      description: Text(
                                          controller.validationMessage.value),
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
                                      "Login",
                                      style: btnStyle,
                                    ),
                                  ),
                                ),
                              );
                            }),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don't have an Account,",
                                  style: TextStyle(color: Colors.black),
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.offNamed(Routes.REGISTER);
                                  },
                                  child: const Text(
                                    "Create Now",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                Get.offNamed(Routes.LOGIN);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.phone),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "Login with OTP Instead",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
