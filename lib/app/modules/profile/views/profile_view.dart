import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:shimmer/shimmer.dart';
import 'package:true_medix/app/modules/bottomnavbar/views/bottomnavbar_view.dart';
import 'package:true_medix/app/modules/profile/model/updateprofilemodel.dart';
import 'package:true_medix/app/services/apiServives/apiservices.dart';
import '../../../utilities/appcolors.dart';
import '../../../utilities/appstyles.dart';
import '../../addaddress/views/addaddress_view.dart';
import '../controllers/profile_controller.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  ProfileController? controller;
  var formKeyEdit = GlobalKey<FormState>();
  String? name;
  String? password;
  String base64ImageString = "";
  int radioGroupValue = 0;
  @override
  void initState() {
    controller = Get.put<ProfileController>(ProfileController());
    controller!.initGetMyProfile();
    controller!.initGetAddressDetails();
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
        body: SafeArea(
          child: ListView(
            children: [
              GetBuilder<ProfileController>(builder: (controller) {
                return FutureBuilder(
                    future: controller.apiServices.getMyProfileDetails(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.withOpacity(0.25),
                          highlightColor: Colors.white.withOpacity(0.6),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 200,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(25),
                                    bottomRight: Radius.circular(25),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 17.0, left: 24),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "My Profile",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 24,
                                              color: const Color(0XFF424242),
                                            ),
                                          ),
                                          const Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 16.0),
                                            child: Tooltip(
                                              message: "Edit Profile Details",
                                              child: IconButton(
                                                  onPressed: () {},
                                                  icon: SvgPicture.asset(
                                                    "assets/edit.svg",
                                                    width: 20,
                                                    height: 20,
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 11,
                                      ),
                                      Center(
                                        child: Stack(
                                          children: [
                                            Container(
                                              height: 111,
                                              width: 111,
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        "assets/gallery.png"),
                                                  )),
                                            ),
                                            Positioned(
                                              right: -04,
                                              top: -10,
                                              child: IconButton(
                                                onPressed: () {},
                                                icon: Image.asset(
                                                    "assets/gallery.png"),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 18.0, top: 29, right: 18),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Name",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: const Color(0XFF000000),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Container(
                                      height: 46,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: const Color(0XFFBBEFFD),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0,
                                            top: 11,
                                            bottom: 11,
                                            right: 20),
                                        child: Row(
                                          children: [
                                            Text(
                                              "",
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: const Color(0XFF242422),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    Text(
                                      "Mobile",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: const Color(0XFF000000),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Container(
                                      height: 46,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: const Color(0XFFBBEFFD),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0,
                                            top: 11,
                                            bottom: 11,
                                            right: 20),
                                        child: Row(
                                          children: [
                                            Text(
                                              "",
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: const Color(0XFF242422),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    Text(
                                      "Email",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: const Color(0XFF000000),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Container(
                                      height: 46,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: const Color(0XFFBBEFFD),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0,
                                            top: 11,
                                            bottom: 11,
                                            right: 20),
                                        child: Row(
                                          children: [
                                            Text(
                                              "",
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: const Color(0XFF242422),
                                              ),
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
                        );
                      }
                      if (snapshot.data == null) {
                        return Center(
                          child: Image.asset("assets/oops.png"),
                        );
                      } else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 200,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Color(0XFFBBEFFD),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(25),
                                  bottomRight: Radius.circular(25),
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 17.0, left: 12),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "My Profile",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 24,
                                            color: const Color(0XFF424242),
                                          ),
                                        ),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 16.0),
                                          child: Tooltip(
                                            message: "Edit Profile Details",
                                            child: IconButton(
                                                onPressed: () {
                                                  showDialog(
                                                      barrierDismissible: true,
                                                      context: context,
                                                      builder: (context) {
                                                        return Stack(
                                                          children: [
                                                            BackdropFilter(
                                                              filter: ImageFilter
                                                                  .blur(
                                                                      sigmaX: 5,
                                                                      sigmaY:
                                                                          5),
                                                              child: Container(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.5),
                                                              ),
                                                            ),
                                                            Dialog(
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              child: SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    1,
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.5,
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 8.0,
                                                                      right:
                                                                          8.0),
                                                                  child: Center(
                                                                    child: Form(
                                                                      key:
                                                                          formKeyEdit,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(top: 20.0),
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                              "Update Profile Deatils",
                                                                              style: GoogleFonts.poppins(
                                                                                fontWeight: FontWeight.w600,
                                                                                fontSize: 19,
                                                                                color: const Color(0XFF424242),
                                                                              ),
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 45,
                                                                            ),
                                                                            Container(
                                                                              height: 58,
                                                                              decoration: BoxDecoration(
                                                                                color: Colors.white,
                                                                                border: Border.all(color: Colors.black),
                                                                                borderRadius: BorderRadius.circular(25),
                                                                              ),
                                                                              width: MediaQuery.of(context).size.width,
                                                                              child: Center(
                                                                                child: TextFormField(
                                                                                  validator: (value) {
                                                                                    if (value!.isEmpty) {
                                                                                      controller.nameValidationMessage.value = "The Name field is required.";
                                                                                      controller.update();
                                                                                      return "";
                                                                                    } else {
                                                                                      controller.nameValidationMessage.value = "";
                                                                                      controller.update();
                                                                                      return null;
                                                                                    }
                                                                                  },
                                                                                  controller: controller.nameController,
                                                                                  keyboardType: TextInputType.text,
                                                                                  decoration: InputDecoration(border: InputBorder.none, contentPadding: const EdgeInsets.only(left: 23), hintText: 'Name', hintStyle: hintStyle),
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
                                                                                border: Border.all(color: Colors.black),
                                                                                borderRadius: BorderRadius.circular(30),
                                                                              ),
                                                                              width: MediaQuery.of(context).size.width,
                                                                              child: Center(
                                                                                child: TextFormField(
                                                                                  controller: controller.passwordController,
                                                                                  keyboardType: TextInputType.text,
                                                                                  obscureText: true,
                                                                                  decoration: InputDecoration(border: InputBorder.none, contentPadding: const EdgeInsets.only(left: 23), hintText: 'Password', hintStyle: hintStyle),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 47,
                                                                            ),
                                                                            GetBuilder<ProfileController>(builder:
                                                                                (controller) {
                                                                              return InkWell(
                                                                                splashColor: Colors.black,
                                                                                highlightColor: Colors.green,
                                                                                onTap: () async {
                                                                                  controller.update();
                                                                                  if (formKeyEdit.currentState!.validate()) {
                                                                                    controller.apiServices
                                                                                        .updateProfile(UpdateProfileModel(
                                                                                      id: controller.profileDetails.id.toString(),
                                                                                      name: controller.nameController.text.trim().toString(),
                                                                                      password: controller.passwordController.text.trim().toString(),
                                                                                      profileImg: "",
                                                                                    ))
                                                                                        .then((value) {
                                                                                      ElegantNotification.success(
                                                                                        toastDuration: const Duration(seconds: 3),
                                                                                        title: const Text("Success"),
                                                                                        description: const Text("Profile Updated Successfully"),
                                                                                      ).show(context);
                                                                                      controller.nameController.clear();
                                                                                      controller.passwordController.clear();

                                                                                      Navigator.of(context).pushReplacement(
                                                                                        MaterialPageRoute(
                                                                                          builder: (context) => BottomnavbarView(incomingIndex: 3),
                                                                                        ),
                                                                                      );
                                                                                    }).onError((error, stackTrace) {
                                                                                      ElegantNotification.error(
                                                                                        toastDuration: const Duration(seconds: 3),
                                                                                        title: const Text("Oops"),
                                                                                        description: const Text("Something Went Wrong"),
                                                                                      ).show(context);
                                                                                      context.loaderOverlay.hide();
                                                                                    });
                                                                                  } else {
                                                                                    formKeyEdit.currentState!.reset();
                                                                                    controller.update();
                                                                                    ElegantNotification.error(
                                                                                      toastDuration: const Duration(seconds: 3),
                                                                                      title: const Text("Validation Error"),
                                                                                      description: const Text("Name Field is Mandatory"),
                                                                                    ).show(context);
                                                                                    context.loaderOverlay.hide();
                                                                                  }
                                                                                },
                                                                                child: Container(
                                                                                  height: 40,
                                                                                  decoration: BoxDecoration(
                                                                                    color: kBtnColor,
                                                                                    borderRadius: BorderRadius.circular(30),
                                                                                  ),
                                                                                  width: MediaQuery.of(context).size.width * 0.6,
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
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      });
                                                },
                                                icon: SvgPicture.asset(
                                                  "assets/edit.svg",
                                                  width: 20,
                                                  height: 20,
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 11,
                                    ),
                                    Center(
                                      child: Stack(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: kBtnColor,
                                            radius: 50,
                                            backgroundImage: NetworkImage(
                                                snapshot.data!.profileImg
                                                    .toString()),
                                          ),
                                          Positioned(
                                            right: -12,
                                            top: -15,
                                            child: IconButton(
                                              onPressed: () {
                                                showModalBottomSheet(
                                                    context: context,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                    ),
                                                    builder: (context) {
                                                      return Container(
                                                        width: double.infinity,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.4,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const Text(
                                                                "Please Select the Image Source:",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                    fontSize:
                                                                        24),
                                                              ),
                                                              const SizedBox(
                                                                height: 30,
                                                              ),
                                                              InkWell(
                                                                splashColor:
                                                                    Colors
                                                                        .black,
                                                                highlightColor:
                                                                    Colors
                                                                        .green,
                                                                onTap:
                                                                    () async {
                                                                  final XFile?
                                                                      image =
                                                                      await controller
                                                                          .picker
                                                                          .pickImage(
                                                                              source: ImageSource.gallery);

                                                                  final bytes = File(
                                                                          image!
                                                                              .path)
                                                                      .readAsBytesSync();
                                                                  String
                                                                      base64Image =
                                                                      "data:image/png;base64,${base64Encode(bytes)}";
                                                                  setState(() {
                                                                    base64ImageString =
                                                                        base64Image;
                                                                  });
                                                                  ApiServices()
                                                                      .updateProfile(UpdateProfileModel(
                                                                          id: snapshot
                                                                              .data!
                                                                              .id,
                                                                          name: snapshot
                                                                              .data!
                                                                              .name,
                                                                          password:
                                                                              "",
                                                                          profileImg:
                                                                              base64ImageString))
                                                                      .then(
                                                                          (value) {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return AlertDialog(
                                                                          title:
                                                                              const Text("Profile Picture"),
                                                                          content:
                                                                              const Text("Profile Picture Updated Successfully"),
                                                                          actions: [
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                Get.offAll(
                                                                                  () => BottomnavbarView(
                                                                                    incomingIndex: 3,
                                                                                  ),
                                                                                );
                                                                              },
                                                                              child: const Text("Continue"),
                                                                            ),
                                                                          ],
                                                                        );
                                                                      },
                                                                    );
                                                                  }).onError((error,
                                                                          stackTrace) {
                                                                    showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) {
                                                                          return const AlertDialog(
                                                                            title:
                                                                                Text("Profile Picture"),
                                                                            content:
                                                                                Text("Profile Picture not Updated"),
                                                                          );
                                                                        });
                                                                  });
                                                                },
                                                                child: Ink(
                                                                  height: 60,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color:
                                                                        kBtnColor,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            25),
                                                                  ),
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.85,
                                                                  child: Center(
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        const Icon(
                                                                          Icons
                                                                              .photo,
                                                                          size:
                                                                              40,
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              20,
                                                                        ),
                                                                        Text(
                                                                          "Upload from Gallery",
                                                                          style:
                                                                              btnStyle,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 40,
                                                              ),
                                                              InkWell(
                                                                splashColor:
                                                                    Colors
                                                                        .black,
                                                                highlightColor:
                                                                    Colors
                                                                        .green,
                                                                onTap:
                                                                    () async {
                                                                  final XFile?
                                                                      photo =
                                                                      await controller
                                                                          .picker
                                                                          .pickImage(
                                                                              source: ImageSource.camera);

                                                                  final bytes = File(
                                                                          photo!
                                                                              .path)
                                                                      .readAsBytesSync();
                                                                  String
                                                                      base64Image =
                                                                      "data:image/png;base64,${base64Encode(bytes)}";
                                                                  setState(() {
                                                                    base64ImageString =
                                                                        base64Image;
                                                                  });
                                                                  ApiServices()
                                                                      .updateProfile(UpdateProfileModel(
                                                                          id: snapshot
                                                                              .data!
                                                                              .id,
                                                                          name: snapshot
                                                                              .data!
                                                                              .name,
                                                                          password:
                                                                              "",
                                                                          profileImg:
                                                                              base64ImageString))
                                                                      .then(
                                                                          (value) {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return AlertDialog(
                                                                          title:
                                                                              const Text("Profile Picture"),
                                                                          content:
                                                                              const Text("Profile Picture Updated Successfully"),
                                                                          actions: [
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                Get.offAll(
                                                                                  () => BottomnavbarView(
                                                                                    incomingIndex: 3,
                                                                                  ),
                                                                                );
                                                                              },
                                                                              child: const Text("Continue"),
                                                                            ),
                                                                          ],
                                                                        );
                                                                      },
                                                                    );
                                                                  }).onError((error,
                                                                          stackTrace) {
                                                                    showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) {
                                                                          return const AlertDialog(
                                                                            title:
                                                                                Text("Profile Picture"),
                                                                            content:
                                                                                Text("Profile Picture not Updated"),
                                                                          );
                                                                        });
                                                                  });
                                                                  setState(() {
                                                                    base64ImageString =
                                                                        base64Image;
                                                                  });

                                                                  log("Image BASE64 : $base64Image");
                                                                },
                                                                child: Ink(
                                                                  height: 60,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color:
                                                                        kBtnColor,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            25),
                                                                  ),
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.85,
                                                                  child: Center(
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        const Icon(
                                                                          Icons
                                                                              .camera_alt_rounded,
                                                                          size:
                                                                              40,
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              20,
                                                                        ),
                                                                        Text(
                                                                          "Capture from Camera",
                                                                          style:
                                                                              btnStyle,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              },
                                              icon: Image.asset(
                                                "assets/gallery.png",
                                                width: 22,
                                                height: 22,
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
                            const SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 18.0, top: 0, right: 18),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: const Color(0XFF000000),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                    height: 46,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: const Color(0XFFBBEFFD),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0,
                                          top: 11,
                                          bottom: 11,
                                          right: 20),
                                      child: Row(
                                        children: [
                                          Text(
                                            snapshot.data!.name.toString(),
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: const Color(0XFF242422),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  Text(
                                    "Mobile",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: const Color(0XFF000000),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                    height: 46,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: const Color(0XFFBBEFFD),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0,
                                          top: 11,
                                          bottom: 11,
                                          right: 20),
                                      child: Row(
                                        children: [
                                          Text(
                                            "+91 ${snapshot.data!.mobileNo.toString()}",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: const Color(0XFF242422),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  Text(
                                    "Email",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: const Color(0XFF000000),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                    height: 46,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: const Color(0XFFBBEFFD),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0,
                                          top: 11,
                                          bottom: 11,
                                          right: 20),
                                      child: Row(
                                        children: [
                                          Text(
                                            snapshot.data!.email.toString(),
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: const Color(0XFF242422),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                    });
              }),
              GetBuilder<ProfileController>(builder: (context) {
                return FutureBuilder(
                    future: controller!.apiServices.getAddress(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.withOpacity(0.25),
                          highlightColor: Colors.white.withOpacity(0.6),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 24,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Text(
                                  "Address Book",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: const Color(0XFF000000),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 110,
                                child: ListView.builder(
                                    itemCount:
                                        controller!.getAddressDetails.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 17, left: 0),
                                        child: Container(
                                          height: 47,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Row(
                                            children: [
                                              Radio<int>(
                                                  value: index,
                                                  fillColor:
                                                      MaterialStateProperty.all(
                                                          Colors.black),
                                                  activeColor: Colors.black,
                                                  groupValue: radioGroupValue,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      radioGroupValue = val!;
                                                    });
                                                  }),
                                              Text(
                                                "",
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  color:
                                                      const Color(0XFF242424),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => AddaddressView());
                                },
                                child: Center(
                                  child: Container(
                                    height: 40,
                                    width: 170,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: kBtnColor,
                                    ),
                                    child: Center(
                                        child: Text(
                                      'Add Address',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    )),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 60,
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                            ],
                          ),
                        );
                      }
                      if (snapshot.data == null) {
                        return Center(
                          child: Image.asset("assets/oops.png"),
                        );
                      }
                      if (snapshot.data!.isEmpty) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 24,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                "Address Book",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: const Color(0XFF000000),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "No Addresses Found",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: const Color(0XFF000000),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      "Click on Add Address to Add Address",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: const Color(0XFF000000),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 60,
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(() => AddaddressView());
                              },
                              child: Center(
                                child: Container(
                                  height: 40,
                                  width: 170,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: kBtnColor,
                                  ),
                                  child: Center(
                                      child: Text(
                                    'Add Address',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  )),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 60,
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                          ],
                        );
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 24,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              "Address Book",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: const Color(0XFF000000),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: controller!.getAddressDetails.isEmpty
                                ? 80
                                : controller!.getAddressDetails.length * 80,
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller!.getAddressDetails.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 17, left: 16),
                                    child: Container(
                                      height: 47,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        children: [
                                          InkWell(
                                            splashColor: Colors.black,
                                            highlightColor: Colors.green,
                                            onTap: () {
                                              MapsLauncher.launchCoordinates(
                                                  double.parse(controller!
                                                      .getAddressDetails[index]
                                                      .googleLat!
                                                      .toString()),
                                                  double.parse(controller!
                                                      .getAddressDetails[index]
                                                      .googleLng!
                                                      .toString()));
                                            },
                                            child: InkWell(
                                              splashColor: Colors.black,
                                              highlightColor: Colors.green,
                                              child: Ink(
                                                child: Tooltip(
                                                  message:
                                                      "See Location on Google Maps",
                                                  child: SvgPicture.asset(
                                                    "assets/gps.svg",
                                                    color:
                                                        const Color(0XFF00B9C9),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Flexible(
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              child: Text(
                                                "${controller!.getAddressDetails[index].id.toString()} ${controller!.getAddressDetails[index].city.toString()}\n${controller!.getAddressDetails[index].address.toString()}",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  color:
                                                      const Color(0XFF242424),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                            splashColor: Colors.black,
                                            highlightColor: Colors.green,
                                            onTap: () {},
                                            child: Tooltip(
                                              message: "Delete Address",
                                              child: IconButton(
                                                onPressed: () async {
                                                  controller!.apiServices
                                                      .deleteCustomerAddress(
                                                          controller!
                                                              .getAddressDetails[
                                                                  index]
                                                              .id!
                                                              .toString())
                                                      .then((value) {
                                                    controller!
                                                        .initGetMyProfile();
                                                    controller!.update();
                                                    ElegantNotification.success(
                                                      description: const Text(
                                                          "Address Deleted Successfully"),
                                                      title:
                                                          const Text("Address"),
                                                    ).show(context);
                                                    Navigator.of(context)
                                                        .pushReplacement(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            BottomnavbarView(
                                                                incomingIndex:
                                                                    3),
                                                      ),
                                                    );
                                                  }).onError(
                                                          (error, stackTrace) {
                                                    ElegantNotification.error(
                                                      description: const Text(
                                                          "Something Went Wrong"),
                                                      title:
                                                          const Text("Address"),
                                                    ).show(context);
                                                  });
                                                },
                                                icon: const Icon(Icons.delete),
                                                color: const Color(0XFF00B9C9),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          InkWell(
                            splashColor: Colors.black,
                            highlightColor: Colors.green,
                            onTap: () {
                              Get.to(() => AddaddressView());
                            },
                            child: Center(
                              child: Container(
                                height: 40,
                                width: 170,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: kBtnColor,
                                ),
                                child: Center(
                                    child: Text(
                                  'Add Address',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                )),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                        ],
                      );
                    });
              }),
            ],
          ),
        ),
      ),
    );
  }
}
