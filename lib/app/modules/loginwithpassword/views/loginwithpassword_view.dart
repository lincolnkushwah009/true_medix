import 'dart:developer';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
                Padding(
                  padding: const EdgeInsets.only(left: 11, top: 30),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: SizedBox(
                        width: 22,
                        height: 18,
                        child: SvgPicture.asset("assets/back.svg"),
                      ),
                    ),
                  ),
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
                                      }
                                      if (!EmailValidator.validate(value)) {
                                        return value.contains("@") &&
                                                value.contains(".")
                                            ? controller
                                                    .validationMessageEmailPhone
                                                    .value =
                                                "Please Enter Valid Email"
                                            : "";
                                      }
                                      if (value.length < 10) {
                                        controller.validationMessageEmailPhone
                                                .value =
                                            "Phone can't be less than 10 Digits Valid Email";
                                        controller.update();

                                        return "";
                                      }
                                      if (value.length > 10) {
                                        return value.contains("@")
                                            ? null
                                            : controller
                                                    .validationMessageEmailPhone
                                                    .value =
                                                "Phone can't be greater than 10 Digits Valid Email";
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

                                        return "";
                                      }
                                      if (value.length < 6) {
                                        controller.validationMessagePassword
                                                .value =
                                            "Password can't be less than 6 characters";
                                        controller.update();

                                        return "";
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
                                  onTap: () async {
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
                                        controller.localStorage
                                            .storeUserDetails(
                                                value['customer']);
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
                                          Get.toNamed(Routes.BOTTOMNAVBAR);
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
