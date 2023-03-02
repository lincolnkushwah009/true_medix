import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:true_medix/app/global/customdialog.dart';
import 'package:true_medix/app/modules/profile/controllers/profile_controller.dart';
import 'package:true_medix/app/modules/uploadprescription/models/uploadprescriptionmodel.dart';

import '../../../services/apiServives/apiservices.dart';
import '../../../utilities/appcolors.dart';
import '../../../utilities/appstyles.dart';
import '../../bottomnavbar/views/bottomnavbar_view.dart';
import '../controllers/uploadprescription_controller.dart';

class UploadprescriptionView extends StatefulWidget {
  const UploadprescriptionView({Key? key}) : super(key: key);

  @override
  State<UploadprescriptionView> createState() => _UploadprescriptionViewState();
}

class _UploadprescriptionViewState extends State<UploadprescriptionView> {
  UploadprescriptionController? controller;
  ProfileController? profileController;

  @override
  void initState() {
    controller =
        Get.put<UploadprescriptionController>(UploadprescriptionController());
    profileController = Get.put<ProfileController>(ProfileController());
    profileController!.apiServices.getMyProfileDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          "Upload Prescription",
          style: iconTextStyle.copyWith(
              fontSize: 24,
              color: const Color(0XFF242424),
              fontWeight: FontWeight.w400),
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SvgPicture.asset("assets/back.svg"),
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.52,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 8.0, top: 8.0, left: 20),
                        child: Text(
                          "Prescription Guide",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/checked.png",
                              width: 20,
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 8.0, top: 8.0, left: 20),
                              child: Text(
                                "Upload Clear Image",
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/checked.png",
                              width: 20,
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 8.0, top: 8.0, left: 20),
                              child: Text(
                                "Doctor Details Required",
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/checked.png",
                              width: 20,
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 8.0, top: 8.0, left: 20),
                              child: Text(
                                "Date Of Prescription",
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/checked.png",
                              width: 20,
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 8.0, top: 8.0, left: 20),
                              child: Text(
                                "Patient Details",
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/checked.png",
                              width: 20,
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 8.0, top: 8.0, left: 20),
                              child: Text(
                                "Dosage Details",
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 8.0, top: 8.0, left: 20, right: 20),
                        child: Text(
                          "How It Works",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 20),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Image.asset(
                                  "assets/prescription.png",
                                  width: 20,
                                  height: 20,
                                ),
                                Text(
                                  "Upload",
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                const Icon(
                                  Icons.phone,
                                  size: 20,
                                ),
                                Text(
                                  "Service",
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                const Icon(
                                  Icons.assistant,
                                  size: 20,
                                ),
                                Text(
                                  "Phlebo",
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14.0, right: 14),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: kBtnColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Image.asset("assets/folder.png"),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14.0, right: 14),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final XFile? image = await controller!.picker
                          .pickImage(source: ImageSource.camera);

                      final bytes = File(image!.path).readAsBytesSync();
                      String base64Image =
                          "data:image/png;base64,${base64Encode(bytes)}";
                      setState(() {
                        controller!.base64ImageString.value = base64Image;
                      });
                      ApiServices()
                          .uploadPrescription(UploadPrescriptionModel(
                        name: profileController!.profileDetails.name,
                        mobile: profileController!.profileDetails.mobileNo,
                        prescription: controller!.base64ImageString.value,
                      ))
                          .then((value) {
                        CustomDialog().customDialog(
                          context,
                          btnTitle: "Continue",
                          height: 500,
                          image: "assets/successpay.svg",
                          isError: false,
                          onTap: () {
                            Get.offAll(
                              () => BottomnavbarView(
                                incomingIndex: 0,
                              ),
                            );
                          },
                          orderId: "+91 8055554468".toString(),
                          orderTitle: "Contact Us : ",
                          title: "Prescription Uploaded Successfully",
                          subTitle: value!['message'].toString(),
                          // subTitle:
                          //     "Your Prescription has been Received.\nYou will soon receive a call from TrueMedix Support Team",
                        );
                      }).onError((error, stackTrace) {
                        CustomDialog().customDialog(
                          context,
                          btnTitle: "Continue",
                          height: 500,
                          image: "assets/errorpay.png",
                          isError: true,
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          orderId: "+91 8055554468".toString(),
                          orderTitle: "Contact Us : ",
                          title: "Prescription Upload Failed",
                          subTitle: error.toString(),
                          // subTitle:
                          //     "Something went Wrong while Uploading Prescription.\nPlease Retry the Process",
                        );
                      });
                    },
                    child: Container(
                      width: 130,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                          color: Colors.white),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.camera),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Camera"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () async {
                      final XFile? image = await controller!.picker
                          .pickImage(source: ImageSource.gallery);

                      final bytes = File(image!.path).readAsBytesSync();
                      String base64Image =
                          "data:image/png;base64,${base64Encode(bytes)}";
                      setState(() {
                        controller!.base64ImageString.value = base64Image;
                      });
                      ApiServices()
                          .uploadPrescription(UploadPrescriptionModel(
                        name: profileController!.profileDetails.name,
                        mobile: profileController!.profileDetails.mobileNo,
                        prescription: controller!.base64ImageString.value,
                      ))
                          .then((value) {
                        CustomDialog().customDialog(
                          context,
                          btnTitle: "Continue",
                          height: 500,
                          image: "assets/successpay.svg",
                          isError: false,
                          onTap: () {
                            Get.offAll(
                              () => BottomnavbarView(
                                incomingIndex: 0,
                              ),
                            );
                          },
                          orderId: "+91 8055554468".toString(),
                          orderTitle: "Contact Us : ",
                          title: "Prescription Uploaded Successfully",
                          subTitle: value!['message'].toString(),
                          // subTitle:
                          //     "Your Prescription has been Received.\nYou will soon receive a call from TrueMedix Support Team",
                        );
                      }).onError((error, stackTrace) {
                        CustomDialog().customDialog(
                          context,
                          btnTitle: "Continue",
                          height: 500,
                          image: "assets/errorpay.png",
                          isError: true,
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          orderId: "+91 8055554468".toString(),
                          orderTitle: "Contact Us : ",
                          title: "Prescription Upload Failed",
                          subTitle: error.toString(),
                          // subTitle:
                          //     "Something went Wrong while Uploading Prescription.\nPlease Retry the Process",
                        );
                      });
                    },
                    child: Container(
                      width: 130,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                          color: kPrimaryColor),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.photo),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Gallery"),
                          ],
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
    );
  }
}
