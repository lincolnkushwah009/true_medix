import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
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
  @override
  void initState() {
    controller = Get.put<ProfileController>(ProfileController());
    controller!.initGetMyProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              return Stack(
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
                                        controller!.profileDetails.mobileNo
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
                    padding:
                        const EdgeInsets.only(left: 55.0, right: 10, top: 40),
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
              );
            }
          }),
        ),
      ),
    );
  }
}
