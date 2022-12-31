// ignore_for_file: use_build_context_synchronously, prefer_const_constructors
import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

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
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 70.0),
                    child: Image.asset(
                      "assets/authImage.png",
                      height: 200,
                      width: 300,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.8,
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
                            "Create Account",
                            style: heading1Style,
                          ),
                        ),
                      ),
                      Form(
                        key: formRegisterKey,
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
                                      controller!.validationMessage.value =
                                          "Name can't be Empty";
                                      return "";
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: controller!.nameController,
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Colors.black,
                                    ),
                                    contentPadding: EdgeInsets.only(top: 14),
                                    hintText: "Name",
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
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
                                      return "Email can't be Empty";
                                    }
                                    if (!EmailValidator.validate(value)) {
                                      controller!.validationMessage.value =
                                          "Please Enter Valid Email";
                                      return "";
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: controller!.emailController,
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Colors.black,
                                    ),
                                    contentPadding: EdgeInsets.only(top: 14),
                                    hintText: 'Email',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
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
                                          "Phone can't be Empty";
                                      return "";
                                    }
                                    if (value.length < 10) {
                                      controller!.validationMessage.value =
                                          "Phone can't be less than 10 digits";
                                      return "";
                                    }
                                    if (value.length > 10) {
                                      controller!.validationMessage.value =
                                          "Phone can't be greater than 10 digits";
                                      return "";
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: controller!.phoneController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: IconButton(
                                      onPressed: () {
                                        showCountryPicker(
                                          context: context,
                                          countryListTheme:
                                              CountryListThemeData(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  bottomSheetHeight:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.6),
                                          showPhoneCode: true,
                                          onSelect: (Country country) {
                                            setState(() {
                                              log(country.flagEmoji.toString());
                                              countryCode = country.flagEmoji;
                                            });
                                          },
                                        );
                                      },
                                      icon: Text(countryCode),
                                    ),
                                    contentPadding: EdgeInsets.only(top: 14),
                                    hintText: 'Phone',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
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
                                  controller: controller!.passwordController,
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
                                    log(controller.passwordController.value.text
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
                                      controller.accountResponse.value = value;
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
                                      Future.delayed(Duration(seconds: 1), () {
                                        Get.to(() => LoginwithpasswordView());
                                      });
                                    }).onError((error, stackTrace) {
                                      log("pppppppppp");
                                      log(controller.accountResponse['email']
                                          .toString());
                                      log("QQQQQQQQQQ");
                                      log(controller
                                          .accountResponse['mobile_no']
                                          .toString());
                                      ElegantNotification.error(
                                        toastDuration: Duration(seconds: 2),
                                        title: const Text("Error"),
                                        description: controller.accountResponse[
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
                                      "Create",
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
                                  "Already have an Account,",
                                  style: TextStyle(color: Colors.black),
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.offNamed(Routes.LOGINWITHPASSWORD);
                                  },
                                  child: const Text(
                                    "Login Now",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline),
                                  ),
                                ),
                              ],
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
