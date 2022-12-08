// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:true_medix/app/utilities/appcolors.dart';
import 'package:true_medix/app/utilities/appstyles.dart';

import '../../../services/apiResponse/apiresponse.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    LoginController controller = Get.put<LoginController>(LoginController());
    return Scaffold(
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
                    height: 312,
                    width: 300,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
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
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Center(
                        child: TextFormField(
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
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () async {
                        ApiResponse responseData = await controller.apiServices
                            .loginWithOTP(
                                phone: controller.phoneController.text);
                        log(responseData.data.toString());
                        log(responseData.statusCode.toString());
                        if (responseData.statusCode == 200) {
                          log(responseData.data['message'].toString());
                          ElegantNotification.success(
                            title: const Text("Success"),
                            description:
                                Text(responseData.data['message'].toString()),
                          ).show(context);
                        } else {
                          log(responseData.data['message']['email_mobile']
                              .toString());
                          ElegantNotification.error(
                                  title: const Text("Oops"),
                                  description: Text(responseData.data['message']
                                          ['email_mobile']
                                      .toString()))
                              .show(context);
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
