import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shimmer/shimmer.dart';
import 'package:true_medix/app/modules/addaddress/views/addaddress_view.dart';
import '../../../utilities/appcolors.dart';
import '../../../utilities/appstyles.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  ProfileController? controller;
  var formKey = GlobalKey<FormState>();
  String countryCode = "🇮🇳";
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
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          automaticallyImplyLeading: false,
          title: Text(
            'LOGO',
            style: iconTextStyle.copyWith(fontSize: 22),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          centerTitle: false,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: GetBuilder<ProfileController>(builder: (controller) {
              if (controller.profileLoading.value) {
                return Shimmer.fromColors(
                    baseColor: Colors.grey.withOpacity(0.25),
                    highlightColor: Colors.white.withOpacity(0.6),
                    child: Center(
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 160.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height - 103,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                ),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.only(top: 90.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 59,
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                            color: Color(0XFF67B0D0)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 54.0, right: 27),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Name",
                                                style: profileTextStyle,
                                              ),
                                              Text(
                                                controller.profileDetails.name
                                                    .toString(),
                                                style: profileTextStyle,
                                              ),
                                              Container(
                                                height: 24,
                                                width: 24,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: const Icon(
                                                  Icons.edit,
                                                  size: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Container(
                                        height: 59,
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                            color: Color(0XFF67B0D0)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 54.0, right: 27),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Email",
                                                style: profileTextStyle,
                                              ),
                                              SizedBox(
                                                width: 90,
                                                child: Text(
                                                  controller
                                                      .profileDetails.email
                                                      .toString(),
                                                  maxLines: 4,
                                                  style: profileTextStyle,
                                                ),
                                              ),
                                              Container(
                                                height: 24,
                                                width: 24,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: const Icon(
                                                  Icons.edit,
                                                  size: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Container(
                                        height: 59,
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                            color: Color(0XFF67B0D0)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 54.0, right: 27),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Phone",
                                                style: profileTextStyle,
                                              ),
                                              Text(
                                                controller
                                                    .profileDetails.mobileNo
                                                    .toString(),
                                                style: profileTextStyle,
                                              ),
                                              Container(
                                                height: 24,
                                                width: 24,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: const Icon(
                                                  Icons.edit,
                                                  size: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 55.0, right: 10, top: 40),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 51.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Profile",
                                    style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    height: 103,
                                    width: 103,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          blurRadius: 2,
                                          color: Colors.grey,
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(51),
                                    ),
                                    child: Image.asset(
                                      "assets/account.png",
                                      width: 65,
                                      height: 65,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ));
              } else {
                return Column(
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 100.0),
                          child: Container(
                            height:
                                MediaQuery.of(context).size.height * 0.5 - 103,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30)),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.only(top: 35.0),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 59,
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                          color: Color(0XFF67B0D0)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 54.0, right: 27),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Name",
                                              style: profileTextStyle,
                                            ),
                                            Text(
                                              controller!.profileDetails.name
                                                  .toString(),
                                              style: profileTextStyle,
                                            ),
                                            Container(
                                              height: 24,
                                              width: 24,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: const Icon(
                                                Icons.edit,
                                                size: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Container(
                                      height: 59,
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                          color: Color(0XFF67B0D0)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 54.0, right: 27),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Email",
                                              style: profileTextStyle,
                                            ),
                                            SizedBox(
                                              width: 90,
                                              child: Text(
                                                controller!.profileDetails.email
                                                    .toString(),
                                                maxLines: 4,
                                                style: profileTextStyle,
                                              ),
                                            ),
                                            Container(
                                              height: 24,
                                              width: 24,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: const Icon(
                                                Icons.edit,
                                                size: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Container(
                                      height: 59,
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                          color: Color(0XFF67B0D0)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 54.0, right: 27),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Phone",
                                              style: profileTextStyle,
                                            ),
                                            Text(
                                              controller!
                                                  .profileDetails.mobileNo
                                                  .toString(),
                                              style: profileTextStyle,
                                            ),
                                            Container(
                                              height: 24,
                                              width: 24,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: const Icon(
                                                Icons.edit,
                                                size: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 10, top: 0),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 21.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Profile",
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const Spacer(),
                                Stack(
                                  children: [
                                    Container(
                                      height: 103,
                                      width: 103,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                            blurRadius: 2,
                                            color: Colors.grey,
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(51),
                                      ),
                                      child: Image.asset(
                                        "assets/account.png",
                                        width: 65,
                                        height: 65,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      left: -10,
                                      top: -75,
                                      child: Tooltip(
                                        message: "Upload Photo",
                                        child: IconButton(
                                          onPressed: () async {
                                            showModalBottomSheet(
                                                context: context,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                builder: (context) {
                                                  return Container(
                                                    width: double.infinity,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.4,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15.0),
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
                                                                fontSize: 24),
                                                          ),
                                                          const SizedBox(
                                                            height: 30,
                                                          ),
                                                          InkWell(
                                                            onTap: () async {
                                                              final XFile?
                                                                  image =
                                                                  await controller
                                                                      .picker
                                                                      .pickImage(
                                                                          source:
                                                                              ImageSource.gallery);
                                                              log(image
                                                                  .toString());
                                                            },
                                                            child: Container(
                                                              height: 60,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    kBtnColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
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
                                                                      size: 40,
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 20,
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
                                                            onTap: () async {
                                                              final XFile?
                                                                  photo =
                                                                  await controller
                                                                      .picker
                                                                      .pickImage(
                                                                          source:
                                                                              ImageSource.camera);
                                                              log(photo
                                                                  .toString());
                                                            },
                                                            child: Container(
                                                              height: 60,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    kBtnColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
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
                                                                      size: 40,
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 20,
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
                                          icon: const Icon(
                                            Icons.camera_alt,
                                            size: 30,
                                            color: Colors.black,
                                          ),
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
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text(
                            "Address Book",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 230,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(30),
                              ),
                              color: kPrimaryColor),
                          child: FutureBuilder(
                              future: controller.apiServices.getAddress(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.black,
                                    ),
                                  );
                                }
                                if (snapshot.data!.isEmpty) {
                                  return const Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 20.0),
                                      child: Text(
                                        "No Addresses Found\nClick on + Button below to Add Address",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  );
                                } else {
                                  return ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                              height: 220,
                                              child: Card(
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(12.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: const [
                                                              Text(
                                                                "Name:",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              SizedBox(
                                                                height: 3,
                                                              ),
                                                              Text(
                                                                "DOB:",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              SizedBox(
                                                                height: 3,
                                                              ),
                                                              Text(
                                                                "Age:",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              SizedBox(
                                                                height: 3,
                                                              ),
                                                              Text(
                                                                "Gender:",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              SizedBox(
                                                                height: 3,
                                                              ),
                                                              Text(
                                                                "Address:",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              SizedBox(
                                                                height: 3,
                                                              ),
                                                              Text(
                                                                "Phone:",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              SizedBox(
                                                                height: 3,
                                                              ),
                                                              Text(
                                                                "Email:",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(12.0),
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                controller
                                                                    .getAddressDetails[
                                                                        index]
                                                                    .name
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              const SizedBox(
                                                                height: 3,
                                                              ),
                                                              Text(
                                                                controller
                                                                    .getAddressDetails[
                                                                        index]
                                                                    .dob
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              const SizedBox(
                                                                height: 3,
                                                              ),
                                                              Text(
                                                                controller
                                                                    .getAddressDetails[
                                                                        index]
                                                                    .age
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              const SizedBox(
                                                                height: 3,
                                                              ),
                                                              Text(
                                                                controller
                                                                    .getAddressDetails[
                                                                        index]
                                                                    .gender
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              const SizedBox(
                                                                height: 3,
                                                              ),
                                                              Text(
                                                                controller
                                                                    .getAddressDetails[
                                                                        index]
                                                                    .address
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              const SizedBox(
                                                                height: 3,
                                                              ),
                                                              Text(
                                                                controller
                                                                    .getAddressDetails[
                                                                        index]
                                                                    .mobileNo
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              const SizedBox(
                                                                height: 3,
                                                              ),
                                                              Text(
                                                                controller
                                                                    .getAddressDetails[
                                                                        index]
                                                                    .email
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              const SizedBox(
                                                                height: 3,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(),
                                                  ],
                                                ),
                                              )),
                                        );
                                      },
                                      itemCount:
                                          controller.getAddressDetails.length);
                                }
                              }),
                        ),
                      ],
                    ),
                  ],
                );
              }
            }),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          tooltip: "Add Addresses",
          backgroundColor: kPrimaryColor,
          onPressed: () {
            Get.to(() => const AddaddressView());
          },
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
