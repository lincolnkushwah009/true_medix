import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:true_medix/app/modules/bottomnavbar/controllers/bottomnavbar_controller.dart';
import 'package:true_medix/app/modules/profile/controllers/profile_controller.dart';
import 'package:true_medix/app/modules/profile/model/addressmodel.dart';
import 'package:true_medix/app/routes/app_pages.dart';
import 'package:true_medix/app/utilities/appcolors.dart';

import '../../../utilities/appstyles.dart';
import '../controllers/addaddress_controller.dart';

class AddaddressView extends StatefulWidget {
  const AddaddressView({Key? key}) : super(key: key);

  @override
  State<AddaddressView> createState() => _AddaddressViewState();
}

class _AddaddressViewState extends State<AddaddressView> {
  AddaddressController? controller;
  ProfileController? profileController;
  var formKey = GlobalKey<FormState>();
  String countryCode = "🇮🇳";
  bool isGoogleDropdownClosed = true;
  String? selCountry;
  String? selState;
  String? selAge;
  String? selGender;
  String? selDOB;
  List<Location> locations = [];

  @override
  void initState() {
    controller = Get.put<AddaddressController>(AddaddressController());
    profileController = Get.put<ProfileController>(ProfileController());
    controller!.goolePlacesController.addListener(() {
      if (controller!.sessionToken.value == "") {
        controller!.sessionToken.value = controller!.uuid.v4();
        log(controller!.sessionToken.value.toString());
        controller!.update();
      }
    });
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
      disableBackButton: false,
      child: Scaffold(
          backgroundColor: kCardBackgroundColor,
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
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          "Address Book",
                          style: heading1Style.copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 27,
                    ),
                    Form(
                      key: formKey,
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
                          GetBuilder<AddaddressController>(
                              builder: (controller) {
                            return Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
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
                                            hint: const Text("Select Age"),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selAge = newValue.toString();
                                              });
                                            },
                                            validator: ((value) {
                                              if (value!.isEmpty) {
                                                controller.validationMessageAge
                                                    .value = "Select Age";
                                                return "";
                                              } else {
                                                controller.validationMessageAge
                                                    .value = "";
                                                controller.update();
                                              }
                                            }),
                                            // underline:
                                            //     DropdownButtonHideUnderline(
                                            //   child: Container(),
                                            // ),
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
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
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
                                            hint: const Text("Select Gender"),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selGender = newValue.toString();
                                              });
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                controller
                                                        .validationMessageGender
                                                        .value ==
                                                    "Select Gender";
                                                controller.update();
                                                return "";
                                              } else {
                                                controller
                                                    .validationMessageGender
                                                    .value = "";
                                                controller.update();
                                                return null;
                                              }
                                            },
                                            // underline:
                                            //     DropdownButtonHideUnderline(
                                            //   child: Container(),
                                            // ),
                                            value: selGender,
                                            items: ["Male", "Female", "Other"]
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
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              width: MediaQuery.of(context).size.width * 0.85,
                              child: InkWell(
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2050),
                                  ).then((value) {
                                    setState(() {
                                      selDOB = value
                                          .toString()
                                          .split(" ")[0]
                                          .toString();
                                    });
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(selDOB ?? "Select DOB"),
                                  ),
                                ),
                              ),
                            );
                          }),
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
                                    controller!.validationMessagePhone.value =
                                        "Phone can't be Empty";
                                    controller!.update();
                                    return null;
                                  }
                                  if (value.length < 10) {
                                    controller!.validationMessagePhone.value =
                                        "Phone can't be less than 10 digits";
                                    controller!.update();
                                    return null;
                                  }
                                  if (value.length > 10) {
                                    controller!.validationMessagePhone.value =
                                        "Phone can't be greater than 10 digits";
                                    controller!.update();
                                    return null;
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
                                  prefixIcon: IconButton(
                                    onPressed: () {
                                      showCountryPicker(
                                        context: context,
                                        countryListTheme: CountryListThemeData(
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
                                  contentPadding:
                                      const EdgeInsets.only(top: 14),
                                  hintText: 'Phone',
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
                              height: !isGoogleDropdownClosed ? 200 : 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
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
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Icon(
                                          Icons.location_on,
                                          color: Colors.black,
                                        ),
                                        contentPadding:
                                            EdgeInsets.only(top: 14),
                                        hintText: 'Address',
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
                                                      // String
                                                      //     countryStateCityPin =
                                                      //     await controller.getAddressFromLatLng(
                                                      //         double.parse(
                                                      //             locations[0]
                                                      //                 .latitude
                                                      //                 .toString()),
                                                      //         double.parse(
                                                      //             locations[0]
                                                      //                 .longitude
                                                      //                 .toString()));
                                                      // List<dynamic>
                                                      //     countryStateCityPinList =
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
                          GetBuilder<AddaddressController>(
                              builder: (controller) {
                            return Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
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
                                        child: DropdownButton(
                                            isExpanded: true,
                                            borderRadius: BorderRadius.zero,
                                            hint: const Text("Select Country"),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selCountry =
                                                    newValue.toString();
                                              });
                                            },
                                            underline:
                                                DropdownButtonHideUnderline(
                                              child: Container(),
                                            ),
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
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            width: MediaQuery.of(context).size.width * 0.85,
                            child: GetBuilder<AddaddressController>(
                                builder: (controller) {
                              return Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25),
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
                                          child: DropdownButton(
                                              isExpanded: true,
                                              borderRadius: BorderRadius.zero,
                                              hint: const Text("Select State"),
                                              onChanged: (newValue) {
                                                setState(() {
                                                  selState =
                                                      newValue.toString();
                                                });
                                              },
                                              underline:
                                                  DropdownButtonHideUnderline(
                                                child: Container(),
                                              ),
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
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: Image.asset("assets/pincode.png"),
                                  ),
                                  contentPadding:
                                      const EdgeInsets.only(top: 14),
                                  hintText: 'Pincode',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          GetBuilder<AddaddressController>(
                              builder: (controller) {
                            return InkWell(
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  log("Name : ${controller.nameController.text}");
                                  log("Age : $selAge");
                                  log("Gender : $selGender");
                                  log("DOB : $selDOB");

                                  log("Phone : ${controller.phoneController.text}");
                                  log("Email : ${controller.emailController.text}");
                                  log("Maps Address : ${controller.goolePlacesController.text}");
                                  log("Longitude : ${locations[0].longitude}");
                                  log("Latitude : ${locations[0].latitude}");
                                  log("Country : $selCountry");
                                  log("State : $selState");
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
                                    googleLat: locations[0].latitude.toString(),
                                    googleLng:
                                        locations[0].longitude.toString(),
                                    address:
                                        controller.goolePlacesController.text,
                                    country: selCountry,
                                    state: selState,
                                    city: controller.goolePlacesController.text,
                                    pincode: controller.pincodeController.text
                                        .toString()
                                        .trim(),
                                    customerId: controller
                                        .localStorage.getCustomer['id'],
                                  ))
                                      .then((value) {
                                    ElegantNotification.success(
                                      title: const Text("Success"),
                                      description:
                                          Text(value['message'].toString()),
                                    ).show(context);
                                    context.loaderOverlay.hide();
                                    Future.delayed(const Duration(seconds: 1),
                                        () {
                                      profileController!.onInit();
                                      profileController!.update();
                                      Get.back();
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
                                    toastDuration: const Duration(seconds: 2),
                                    title: const Text("Validation Error"),
                                    description: Text(
                                        "${controller.validationMessageName.value}\n${controller.validationMessageAge.value}\n${controller.validationMessageGender.value}\n${controller.validationMessageDob.value}\n${controller.validationMessageEmail.value}\n${controller.validationMessagePhone.value}\n${controller.validationMessageAddress.value}\n${controller.validationMessageCountry.value}\n${controller.validationMessageState.value}\n${controller.validationMessagePincode.value}"),
                                  ).show(context);
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
                                    "Add Address",
                                    style: btnStyle,
                                  ),
                                ),
                              ),
                            );
                          }),
                          const SizedBox(
                            height: 20,
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
