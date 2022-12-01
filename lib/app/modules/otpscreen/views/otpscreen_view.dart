import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../routes/app_pages.dart';
import '../../../utilities/appcolors.dart';
import '../../../utilities/appstyles.dart';
import '../controllers/otpscreen_controller.dart';

class OtpscreenView extends GetView<OtpscreenController> {
  const OtpscreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    OtpscreenController controller =
        Get.put<OtpscreenController>(OtpscreenController());
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
                      "Input OTP",
                      style: heading1Style,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text("Enter OTP number to sign in or sign up",
                        textAlign: TextAlign.center, style: heading2Style),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: PinCodeTextField(
                          showCursor: true,
                          cursorColor: kPrimaryColor,
                          length: 4,
                          obscureText: true,
                          animationType: AnimationType.scale,
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
                            fieldWidth: 40,
                            activeFillColor: Colors.white,
                          ),
                          animationDuration: const Duration(milliseconds: 300),
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
                            /*if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  but you can show anything you want here, like your pop up saying wrong paste format or etc*/
                            return false;
                          },
                          appContext: context,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(Routes.BOTTOMNAVBAR);
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
                            "NEXT",
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
