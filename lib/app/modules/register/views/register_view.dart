// ignore_for_file: use_build_context_synchronously, prefer_const_constructors
import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:true_medix/app/modules/loginwithpassword/views/loginwithpassword_view.dart';
import 'package:true_medix/app/modules/register/model/registermodel.dart';
import 'package:true_medix/app/utilities/appcolors.dart';
import 'package:true_medix/app/utilities/appstyles.dart';
import '../../../routes/app_pages.dart';
import '../controllers/register_controller.dart';

// ignore: must_be_immutable
class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  var formRegisterKey = GlobalKey<FormState>();
  RegisterController? controller;
  String countryCode = "🇮🇳";

  @override
  void initState() {
    controller = Get.put<RegisterController>(RegisterController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: true,
      overlayColor: kPrimaryColor,
      overlayWholeScreen: true,
      switchInCurve: Curves.bounceIn,
      switchOutCurve: Curves.bounceOut,
      closeOnBackButton: false,
      disableBackButton: true,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Register",
                            style: heading1Style,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8, right: 8),
                        child: Form(
                          key: formRegisterKey,
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
                                        controller!.validationMessageName
                                            .value = "Name can't be Empty";
                                        return "";
                                      } else {
                                        controller!
                                            .validationMessageName.value = "";
                                        controller!.update();
                                        return null;
                                      }
                                    },
                                    controller: controller!.nameController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(left: 23),
                                      hintText: "Name",
                                      hintStyle: hintStyle,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 17,
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
                                        controller!.validationMessageEmail
                                            .value = "Email can't be Empty";
                                        return "";
                                      }
                                      if (!EmailValidator.validate(value)) {
                                        controller!.validationMessageEmail
                                            .value = "Please Enter Valid Email";
                                        return "";
                                      } else {
                                        controller!
                                            .validationMessageEmail.value = "";
                                        controller!.update();
                                        return null;
                                      }
                                    },
                                    controller: controller!.emailController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(left: 23),
                                      hintText: 'Email',
                                      hintStyle: hintStyle,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 17,
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
                                        controller!.validationMessagePhone
                                            .value = "Phone can't be Empty";
                                        return "";
                                      }
                                      if (value.length < 10) {
                                        controller!
                                                .validationMessagePhone.value =
                                            "Phone can't be less than 10 digits";
                                        return "";
                                      }
                                      if (value.length > 10) {
                                        controller!
                                                .validationMessagePhone.value =
                                            "Phone can't be greater than 10 digits";
                                        return "";
                                      } else {
                                        controller!
                                            .validationMessagePhone.value = "";
                                        controller!.update();
                                        return null;
                                      }
                                    },
                                    controller: controller!.phoneController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(left: 23),
                                      hintText: 'Phone',
                                      hintStyle: hintStyle,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 17,
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
                                        controller!.validationMessagePassword
                                            .value = "Password can't be Empty";
                                        return "";
                                      }
                                      if (value.length < 6) {
                                        controller!.validationMessagePassword
                                                .value =
                                            "Password can't be less than 6 characters";
                                        return "";
                                      } else {
                                        controller!.validationMessagePassword
                                            .value = "";
                                        controller!.update();
                                        return null;
                                      }
                                    },
                                    controller: controller!.passwordController,
                                    keyboardType: TextInputType.text,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(left: 23),
                                      hintText: 'Password',
                                      hintStyle: hintStyle,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 35,
                              ),
                              GetBuilder<RegisterController>(
                                  builder: (controller) {
                                return InkWell(
                                  onTap: () async {
                                    controller.accountCreatLoading = true.obs;
                                    context.loaderOverlay.show();
                                    if (formRegisterKey.currentState!
                                        .validate()) {
                                      log(controller.nameController.value.text
                                          .toString());
                                      log(controller.emailController.value.text
                                          .toString());
                                      log(controller.phoneController.value.text
                                          .toString());
                                      log(controller
                                          .passwordController.value.text
                                          .toString());
                                      await controller.apiServices
                                          .registerAccount(
                                        RegisterModel(
                                          name: controller
                                              .nameController.value.text
                                              .trim()
                                              .toString(),
                                          email: controller
                                              .emailController.value.text
                                              .trim()
                                              .toString(),
                                          mobileNo: controller
                                              .phoneController.value.text
                                              .trim()
                                              .toString(),
                                          password: controller
                                              .passwordController.value.text
                                              .trim()
                                              .toString(),
                                        ),
                                      )
                                          .then((value) {
                                        controller.accountResponse.value =
                                            value;
                                        controller.accountCreatLoading =
                                            false.obs;
                                        controller.update();
                                        ElegantNotification.success(
                                          toastDuration: Duration(seconds: 2),
                                          title: const Text("Success"),
                                          description: Text(controller
                                              .accountResponse['message']),
                                        ).show(context);
                                        context.loaderOverlay.hide();
                                        Future.delayed(Duration(seconds: 1),
                                            () {
                                          Get.to(() => LoginwithpasswordView());
                                        });
                                      }).onError((error, stackTrace) {
                                        log(controller.accountResponse['email']
                                            .toString());
                                        log(controller
                                            .accountResponse['mobile_no']
                                            .toString());
                                        ElegantNotification.error(
                                          toastDuration: Duration(seconds: 2),
                                          title: const Text("Error"),
                                          description: controller
                                                              .accountResponse[
                                                          'email'] ==
                                                      null &&
                                                  controller.accountResponse[
                                                          'mobile_no'] ==
                                                      null
                                              ? Text(
                                                  "Email / Phone Already Taken")
                                              : controller.accountResponse[
                                                          'mobile_no'] ==
                                                      null
                                                  ? Text(
                                                      "${controller.accountResponse['email']}")
                                                  : Text(
                                                      "${controller.accountResponse['mobile_no']}"),
                                        ).show(context);
                                        controller.accountCreatLoading =
                                            false.obs;
                                        controller.update();
                                        context.loaderOverlay.hide();
                                      });
                                    } else {
                                      formRegisterKey.currentState!.reset();
                                      ElegantNotification.error(
                                        toastDuration: Duration(seconds: 2),
                                        title: const Text("Validation Error"),
                                        description: Text(
                                            "${controller.validationMessageName.value}\n${controller.validationMessageEmail.value}\n${controller.validationMessagePhone.value}\n${controller.validationMessagePassword.value}"),
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
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
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
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Already  have an account?",
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
                                      "Login",
                                      style: TextStyle(
                                        color: kBtnColor,
                                      ),
                                    ),
                                  ),
                                ],
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
