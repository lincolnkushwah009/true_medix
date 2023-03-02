// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:elegant_notification/elegant_notification.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';

import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:true_medix/app/modules/profile/controllers/profile_controller.dart';
import 'package:true_medix/app/modules/profile/model/addressmodel.dart';
import 'package:true_medix/app/modules/profile/model/getaddressmodel.dart';
import 'package:true_medix/app/utilities/appcolors.dart';

import '../../../utilities/appstyles.dart';
import '../../bottomnavbar/views/bottomnavbar_view.dart';
import '../controllers/addaddress_controller.dart';

class AddaddressView extends StatefulWidget {
  AddaddressView({this.getAddressModel, this.isEdit = false, Key? key})
      : super(key: key);
  GetAddressModel? getAddressModel;
  bool isEdit;

  @override
  State<AddaddressView> createState() => _AddaddressViewState();
}

class _AddaddressViewState extends State<AddaddressView> {
  AddaddressController? controller;
  ProfileController? profileController;
  var formKey = GlobalKey<FormState>();
  bool isGoogleDropdownClosed = true;
  String? selCountry;
  String? selState;
  // List<dynamic> countryStateCityPinList = [];
  // String countryStateCityPin = "";
  String? selAge;
  String? selGender;
  String? selDOB;
  bool isWhatsApp = false;
  List<Location> locations = [];

  @override
  void initState() {
    controller = Get.put<AddaddressController>(AddaddressController());
    profileController = Get.put<ProfileController>(ProfileController());
    widget.isEdit == true ? updateAddressForm() : () {};

    controller!.goolePlacesController.addListener(() {
      if (controller!.sessionToken.value == "") {
        controller!.sessionToken.value = controller!.uuid.v4();
        log(controller!.sessionToken.value.toString());
        controller!.update();
      }
    });
    super.initState();
  }

  void updateAddressForm() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      controller!.nameController.text = widget.getAddressModel!.name!;
      locations = await locationFromAddress(
          widget.getAddressModel!.address!.toString());
      selAge = widget.getAddressModel!.age!.toString().split(" ")[0].toString();
      selGender = widget.getAddressModel!.gender! ?? "male";
      selDOB = widget.getAddressModel!.dob!;
      controller!.emailController.text = widget.getAddressModel!.email!;
      controller!.phoneController.text = widget.getAddressModel!.mobileNo!;
      controller!.goolePlacesController.text = widget.getAddressModel!.address!;
      selCountry = widget.getAddressModel!.country!;
      selState = widget.getAddressModel!.state;
      controller!.pincodeController.text = widget.getAddressModel!.pincode!;
      isWhatsApp =
          widget.getAddressModel!.whatsapp!.toString() == "1" ? true : false;
    });
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
      disableBackButton: false,
      child: Scaffold(
          backgroundColor: kCardBackgroundColor,
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            automaticallyImplyLeading: false,
            title: Text(
              widget.isEdit ? 'Update Address' : "Add Address",
              style: iconTextStyle.copyWith(
                  fontSize: 24,
                  color: const Color(0XFF242424),
                  fontWeight: FontWeight.w400),
            ),
            leading: InkWell(
              splashColor: Colors.black,
              highlightColor: Colors.green,
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
            child: SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 27,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Container(
                            height: 58,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            width: MediaQuery.of(context).size.width * 0.85,
                            child: Center(
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    controller!.validationMessageName.value =
                                        "Name can't be Empty";
                                    controller!.update();
                                    return null;
                                  } else {
                                    controller!.validationMessageName.value =
                                        "";
                                    controller!.update();
                                    return null;
                                  }
                                },
                                controller: controller!.nameController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                      const EdgeInsets.only(left: 23),
                                  hintText: "Name",
                                  hintStyle: hintStyle,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GetBuilder<AddaddressController>(
                              builder: (controller) {
                            return Container(
                              height: 58,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              width: MediaQuery.of(context).size.width * 0.85,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20.0),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButtonFormField(
                                            isExpanded: true,
                                            borderRadius: BorderRadius.zero,
                                            onChanged: (newValue) {
                                              setState(() {
                                                selAge = newValue.toString();
                                              });
                                            },
                                            validator: ((value) {
                                              value = (value ?? "");
                                              if (value.isEmpty) {
                                                controller.validationMessageAge
                                                    .value = "Select Age";
                                                return "";
                                              } else {
                                                controller.validationMessageAge
                                                    .value = "";
                                                controller.update();
                                                return null;
                                              }
                                            }),
                                            decoration:
                                                InputDecoration.collapsed(
                                                    hintText: "Select Age",
                                                    hintStyle: hintStyle),
                                            value: selAge,
                                            items: List.generate(
                                                    150,
                                                    (index) =>
                                                        (index + 1).toString())
                                                .toList()
                                                .map((e) {
                                              return DropdownMenuItem(
                                                value: e,
                                                child: Text(
                                                  e.toString(),
                                                ),
                                              );
                                            }).toList()),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          const SizedBox(
                            height: 20,
                          ),
                          GetBuilder<AddaddressController>(
                              builder: (controller) {
                            return Container(
                              height: 58,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              width: MediaQuery.of(context).size.width * 0.85,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20.0),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButtonFormField(
                                            isExpanded: true,
                                            borderRadius: BorderRadius.zero,
                                            decoration:
                                                InputDecoration.collapsed(
                                                    hintText: "Select Gender",
                                                    hintStyle: hintStyle),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selGender = newValue.toString();
                                              });
                                            },
                                            validator: ((value) {
                                              value = (value ?? "");
                                              if (value.isEmpty) {
                                                controller
                                                    .validationMessageGender
                                                    .value = "Select Gender";
                                                return "";
                                              } else {
                                                controller
                                                    .validationMessageGender
                                                    .value = "";
                                                controller.update();
                                                return null;
                                              }
                                            }),
                                            value: selGender,
                                            items: ["male", "female", "other"]
                                                .map((e) {
                                              return DropdownMenuItem(
                                                value: e,
                                                child: Text(
                                                  e.toString(),
                                                ),
                                              );
                                            }).toList()),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          const SizedBox(
                            height: 20,
                          ),
                          GetBuilder<AddaddressController>(
                              builder: (controller) {
                            return GestureDetector(
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                ).then((value) {
                                  setState(() {
                                    selDOB = value
                                        .toString()
                                        .split(" ")[0]
                                        .toString();
                                  });
                                });
                              },
                              child: Container(
                                height: 58,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                width: MediaQuery.of(context).size.width * 0.85,
                                child: TextFormField(
                                  enabled: false,
                                  controller: controller.dobController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.only(
                                          left: 23, top: 5),
                                      hintText: selDOB ?? "Select DOB",
                                      hintStyle: hintStyle),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      controller.validationMessageDob.value =
                                          "Selct DOB ";
                                      controller.update();
                                      return null;
                                    } else {
                                      controller.validationMessageDob.value =
                                          "";
                                      controller.update();
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            );
                          }),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 58,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            width: MediaQuery.of(context).size.width * 0.85,
                            child: Center(
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    controller!.validationMessageEmail.value =
                                        "Email can't be Empty";
                                    controller!.update();
                                    return null;
                                  }
                                  if (!EmailValidator.validate(value)) {
                                    controller!.validationMessageEmail.value =
                                        "Please Enter Valid Email";
                                    controller!.update();
                                    return null;
                                  } else {
                                    controller!.validationMessageEmail.value =
                                        "";
                                    controller!.update();
                                    return null;
                                  }
                                },
                                controller: controller!.emailController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding:
                                        const EdgeInsets.only(left: 23),
                                    hintText: 'Email',
                                    hintStyle: hintStyle),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 58,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            width: MediaQuery.of(context).size.width * 0.85,
                            child: Center(
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    controller!.validationMessagePhone.value =
                                        "Phone can't be Empty";
                                    controller!.update();
                                    return "";
                                  }
                                  if (value.length < 10) {
                                    controller!.validationMessagePhone.value =
                                        "Phone can't be less than 10 digits";
                                    controller!.update();
                                    return "";
                                  }
                                  if (value.length > 10) {
                                    controller!.validationMessagePhone.value =
                                        "Phone can't be greater than 10 digits";
                                    controller!.update();
                                    return "";
                                  } else {
                                    controller!.validationMessagePhone.value =
                                        "";
                                    controller!.update();
                                    return null;
                                  }
                                },
                                controller: controller!.phoneController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding:
                                        const EdgeInsets.only(left: 23),
                                    hintText: 'Phone',
                                    hintStyle: hintStyle),
                              ),
                            ),
                          ),
                          Container(
                            height: 58,
                            width: MediaQuery.of(context).size.width * 0.85,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                Checkbox(
                                    value: isWhatsApp,
                                    onChanged: (val) {
                                      setState(() {
                                        isWhatsApp = val!;
                                        log(isWhatsApp.toString());
                                      });
                                    }),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "WhatsApp",
                                  style: hintStyle,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          GetBuilder<AddaddressController>(
                              builder: (controller) {
                            return Container(
                              height: !isGoogleDropdownClosed ? 200 : 58,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              width: MediaQuery.of(context).size.width * 0.85,
                              child: Column(
                                children: [
                                  Center(
                                    child: TextFormField(
                                      maxLines: 1,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          controller.validationMessageAddress
                                              .value = "Address can't be Empty";
                                          controller.update();
                                          return null;
                                        } else {
                                          controller.validationMessageAddress
                                              .value = "";
                                          controller.update();
                                          return null;
                                        }
                                      },
                                      controller:
                                          controller.goolePlacesController,
                                      keyboardType: TextInputType.text,
                                      onChanged: (value) {
                                        isGoogleDropdownClosed = false;
                                        setState(() {});
                                        controller.selectedAddress.value =
                                            controller
                                                .goolePlacesController.text;
                                        controller.update();
                                        controller.getPlacesFromGoogleApi();
                                        controller.update();
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: const EdgeInsets.only(
                                            left: 23, top: 10),
                                        hintText: 'Address',
                                        hintStyle: hintStyle,
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: !isGoogleDropdownClosed,
                                    child: Divider(
                                      height: 2,
                                      color: kPrimaryColor,
                                      thickness: 3,
                                    ),
                                  ),
                                  Visibility(
                                    visible: !isGoogleDropdownClosed,
                                    child: SizedBox(
                                      height: 150,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Align(
                                                alignment: Alignment.topLeft,
                                                child: IconButton(
                                                  onPressed: () {
                                                    isGoogleDropdownClosed =
                                                        true;
                                                    setState(() {});
                                                  },
                                                  icon: const Icon(
                                                    Icons.close,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ),
                                          Expanded(
                                            flex: 6,
                                            child: ListView.separated(
                                                separatorBuilder:
                                                    (context, index) {
                                                  return const Divider(
                                                    height: 1,
                                                    color: Colors.black,
                                                    thickness: 1,
                                                  );
                                                },
                                                itemCount: controller
                                                    .responseGooglePlacesApi
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  return ListTile(
                                                    onTap: () async {
                                                      controller
                                                          .goolePlacesController
                                                          .value = TextEditingValue(
                                                        text: controller
                                                                .responseGooglePlacesApi[
                                                            index]['description'],
                                                        selection: TextSelection
                                                            .fromPosition(
                                                          TextPosition(
                                                              offset: controller
                                                                  .responseGooglePlacesApi[
                                                                      index][
                                                                      'description']
                                                                  .length),
                                                        ),
                                                      );
                                                      isGoogleDropdownClosed =
                                                          true;
                                                      setState(() {});
                                                      controller.update();
                                                      locations =
                                                          await locationFromAddress(
                                                              controller
                                                                  .goolePlacesController
                                                                  .value
                                                                  .toString());
                                                      log(locations[0]
                                                          .latitude
                                                          .toString());
                                                      log(locations[0]
                                                          .longitude
                                                          .toString());
                                                      controller.update();

                                                      //?======================IMPORTANT METHODS=========================

                                                      // countryStateCityPin = await controller
                                                      //     .getAddressFromLatLng(
                                                      //         double.parse(
                                                      //             locations[0]
                                                      //                 .latitude
                                                      //                 .toString()),
                                                      //         double.parse(
                                                      //             locations[0]
                                                      //                 .longitude
                                                      //                 .toString()));
                                                      // setState(() {});
                                                      // countryStateCityPinList =
                                                      //     countryStateCityPin
                                                      //         .split(',');
                                                      // log(countryStateCityPinList
                                                      //     .toList()
                                                      //     .toString());
                                                      //?======================IMPORTANT METHODS=========================
                                                    },
                                                    title: Text(controller
                                                            .responseGooglePlacesApi[
                                                        index]['description']),
                                                  );
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          const SizedBox(
                            height: 20,
                          ),
                          // Text(countryStateCityPin.toString()),
                          // const SizedBox(
                          //   height: 20,
                          // ),
                          GetBuilder<AddaddressController>(
                              builder: (controller) {
                            return Container(
                              height: 58,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              width: MediaQuery.of(context).size.width * 0.85,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20.0),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButtonFormField(
                                            isExpanded: true,
                                            borderRadius: BorderRadius.zero,
                                            decoration:
                                                InputDecoration.collapsed(
                                                    hintText: "Select Country",
                                                    hintStyle: hintStyle),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selCountry =
                                                    newValue.toString();
                                              });
                                            },
                                            validator: ((value) {
                                              value = (value ?? "");
                                              if (value.isEmpty) {
                                                controller
                                                    .validationMessageCountry
                                                    .value = "Select Country";
                                                return "";
                                              } else {
                                                controller
                                                    .validationMessageCountry
                                                    .value = "";
                                                controller.update();
                                                return null;
                                              }
                                            }),
                                            value: selCountry,
                                            items: controller.countries.keys
                                                .toList()
                                                .map((e) {
                                              return DropdownMenuItem(
                                                value: e,
                                                child: Text(
                                                  controller.countries[e]
                                                      .toString(),
                                                ),
                                              );
                                            }).toList()),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 58,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            width: MediaQuery.of(context).size.width * 0.85,
                            child: GetBuilder<AddaddressController>(
                                builder: (controller) {
                              return Container(
                                height: 58,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                width: MediaQuery.of(context).size.width * 0.85,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.85,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20.0),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButtonFormField(
                                              isExpanded: true,
                                              borderRadius: BorderRadius.zero,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  selState =
                                                      newValue.toString();
                                                });
                                              },
                                              decoration:
                                                  InputDecoration.collapsed(
                                                      hintText: "Select State",
                                                      hintStyle: hintStyle),
                                              validator: ((value) {
                                                value = (value ?? "");
                                                if (value.isEmpty) {
                                                  controller
                                                      .validationMessageState
                                                      .value = "Select State";
                                                  return "";
                                                } else {
                                                  controller
                                                      .validationMessageState
                                                      .value = "";
                                                  controller.update();
                                                  return null;
                                                }
                                              }),
                                              value: selState,
                                              items: controller.states.keys
                                                  .toList()
                                                  .map((e) {
                                                return DropdownMenuItem(
                                                  value: e,
                                                  child: Text(
                                                    controller.states[e]
                                                        .toString(),
                                                  ),
                                                );
                                              }).toList()),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 58,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            width: MediaQuery.of(context).size.width * 0.85,
                            child: Center(
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    controller!.validationMessagePincode.value =
                                        "Pincode can't be Empty";
                                    controller!.update();
                                    return null;
                                  }
                                  if (value.length < 6) {
                                    controller!.validationMessagePincode.value =
                                        "Pincode can't be less than 6 Digits";
                                    controller!.update();
                                    return null;
                                  }
                                  if (value.length > 6) {
                                    controller!.validationMessagePincode.value =
                                        "Pincode can't be greater than 6 Digits";
                                    controller!.update();
                                    return null;
                                  } else {
                                    controller!.validationMessagePincode.value =
                                        "";
                                    controller!.update();
                                    return null;
                                  }
                                },
                                controller: controller!.pincodeController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding:
                                        const EdgeInsets.only(left: 23),
                                    hintText: 'Pincode',
                                    hintStyle: hintStyle),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          GetBuilder<AddaddressController>(
                              builder: (controller) {
                            return InkWell(
                              splashColor: Colors.black,
                              highlightColor: Colors.green,
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  log("Name : ${controller.nameController.text}");
                                  log("Age : $selAge");
                                  log("Gender : $selGender");
                                  log("DOB : $selDOB");

                                  log("Phone : ${controller.phoneController.text}");
                                  log("Email : ${controller.emailController.text}");
                                  log("Maps Address : ${controller.goolePlacesController.text}");
                                  // log("Longitude : ${locations[0].longitude}");
                                  // log("Latitude : ${locations[0].latitude}");
                                  log("Country : $selCountry");
                                  log("State : $selState");
                                  log("WhatsApp : $isWhatsApp");
                                  log("Pincode : ${controller.pincodeController.text}");
                                  context.loaderOverlay.show();
                                  controller.apiServices
                                      .addAddress(AddressModel(
                                    name: controller.nameController.text
                                        .toString()
                                        .trim(),
                                    age: selAge,
                                    gender: selGender,
                                    dob: selDOB,
                                    email: controller.emailController.text
                                        .toString()
                                        .trim(),
                                    mobileNo: controller.phoneController.text
                                        .toString()
                                        .trim(),
                                    googleMap:
                                        controller.goolePlacesController.text,
                                    googleLat: locations == null
                                        ? "12.9716"
                                        : locations[0].latitude.toString(),
                                    googleLng: locations == null
                                        ? "77.5946"
                                        : locations[0].longitude.toString(),
                                    address: (controller.goolePlacesController
                                                    .text ==
                                                null ||
                                            controller.goolePlacesController
                                                    .text ==
                                                null)
                                        ? "Truemedix, Kodigehalli - Thindlu Main Rd, Bengaluru, Karnataka 560092"
                                        : controller.goolePlacesController.text,
                                    country: selCountry,
                                    state: selState,
                                    city: controller.goolePlacesController.text,
                                    pincode: controller.pincodeController.text
                                        .toString()
                                        .trim(),
                                    whatsapp: isWhatsApp == true ? 1 : 0,
                                    customerId: (await controller.sessionManager
                                            .getAuthToken())
                                        .id,
                                    id: widget.isEdit == true
                                        ? widget.getAddressModel!.id!.toString()
                                        : "",
                                  ))
                                      .then((value) {
                                    ElegantNotification.success(
                                      title: const Text("Success"),
                                      description:
                                          Text(value['message'].toString()),
                                    ).show(context);
                                    context.loaderOverlay.hide();
                                    controller.nameController.clear();
                                    controller.emailController.clear();
                                    controller.phoneController.clear();
                                    controller.goolePlacesController.clear();
                                    controller.pincodeController.clear();
                                    controller.countryController.clear();
                                    controller.stateController.clear();
                                    controller.addressController.clear();
                                    controller.dobController.clear();
                                    controller.cityController.clear();

                                    Future.delayed(const Duration(seconds: 1),
                                        () {
                                      profileController!.onInit();
                                      profileController!.update();
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              BottomnavbarView(
                                            incomingIndex: 3,
                                          ),
                                        ),
                                      );
                                    });
                                    // context.loaderOverlay.hide();
                                  }).onError((error, stackTrace) {
                                    ElegantNotification.error(
                                      title: const Text("Error"),
                                      description: Text((error
                                          as Map<String, dynamic>)['message']),
                                    ).show(context);
                                    context.loaderOverlay.hide();
                                  });
                                } else {
                                  ElegantNotification.error(
                                    height: 180,
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    toastDuration: const Duration(seconds: 2),
                                    title: const Text("Validation Error"),
                                    description: Text(
                                        "${controller.validationMessageName.value}\n${controller.validationMessageAge.value}\n${controller.validationMessageGender.value}\n${controller.validationMessageDob.value}\n${controller.validationMessageEmail.value}\n${controller.validationMessagePhone.value}\n${controller.validationMessageAddress.value}\n${controller.validationMessageCountry.value}\n${controller.validationMessageState.value}\n${controller.validationMessagePincode.value}"),
                                  ).show(context);
                                }
                              },
                              child: Ink(
                                height: 40,
                                decoration: BoxDecoration(
                                  color: kBtnColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                width: 170,
                                child: Center(
                                  child: Text(
                                    "Save",
                                    style: btnStyle,
                                  ),
                                ),
                              ),
                            );
                          }),
                          const SizedBox(
                            height: 46,
                          ),
                          const SizedBox(
                            height: 100,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
