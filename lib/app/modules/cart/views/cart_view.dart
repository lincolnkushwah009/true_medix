// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:true_medix/app/routes/app_pages.dart';
import 'package:true_medix/app/utilities/appcolors.dart';
import 'package:true_medix/app/utilities/appstyles.dart';

import '../../../global/testcartwidget.dart';
import '../../../services/apiServives/apiservices.dart';
import '../controllers/cart_controller.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  CartController? controller;
  @override
  void initState() {
    controller = Get.put<CartController>(CartController());
    controller!.subTotal.value = 0.0;
    controller!.taxAndFee.value = 0.0;
    controller!.delivery.value = "Free";
    controller!.total.value = 0.0;
    controller!.getLocationPermission();
    controller!.getTotalPriceOfCart(controller!.cartProducts);
    controller!.update();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          'My Cart',
          style: iconTextStyle.copyWith(
              fontSize: 24,
              color: const Color(0XFF242424),
              fontWeight: FontWeight.w400),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GestureDetector(
              onTap: () {}, child: SvgPicture.asset("assets/back.svg")),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    GetBuilder<CartController>(builder: (controller) {
                      return SizedBox(
                          height: 500,
                          child: FutureBuilder(
                              future: controller.apiServices.getCartProducts(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return SizedBox(
                                    height: 500,
                                    child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) {
                                        return Center(
                                          child: Shimmer.fromColors(
                                            baseColor:
                                                Colors.grey.withOpacity(0.25),
                                            highlightColor:
                                                Colors.white.withOpacity(0.6),
                                            loop: 10,
                                            direction: ShimmerDirection.ltr,
                                            period: const Duration(seconds: 1),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.9,
                                                height: 70,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: controller.cartProducts.length,
                                    ),
                                  );
                                }
                                if (snapshot.data!.isEmpty) {
                                  return Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 20.0),
                                        child: Image.asset(
                                            "assets/emptycart.png")),
                                  );
                                } else {
                                  return SizedBox(
                                      height: 500,
                                      child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, index) {
                                          return Card(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0,
                                                  top: 15,
                                                  bottom: 15,
                                                  right: 20),
                                              child: TestCartWidget(
                                                onTapDrop: () {},
                                                title: controller
                                                    .cartProducts[index].name
                                                    .toString(),
                                                subTitle: controller
                                                    .cartProducts[index]
                                                    .apiDepartmentName
                                                    .toString(),
                                                price: controller
                                                    .cartProducts[index].price
                                                    .toString(),
                                                onTapDeleted: () async {
                                                  List<dynamic> cartProductId =
                                                      controller.cartProducts
                                                          .map((element) {
                                                    return element.id;
                                                  }).toList();
                                                  cartProductId.remove(
                                                      snapshot.data![index].id);
                                                  log(cartProductId
                                                      .toList()
                                                      .toString());
                                                  Map<String, dynamic> payLoad =
                                                      {
                                                    "mobile_no": "",
                                                    "products": cartProductId,
                                                  };
                                                  ApiServices()
                                                      .addToCart(payLoad)
                                                      .then((value) {
                                                    controller
                                                        .initGetCartProducts();
                                                    ElegantNotification.success(
                                                      title:
                                                          const Text("Success"),
                                                      description: Text(
                                                          value['message']
                                                              .toString()),
                                                    ).show(context);
                                                    controller.onInit();
                                                  }).onError(
                                                          (error, stackTrace) {
                                                    log(stackTrace.toString());
                                                    ElegantNotification.error(
                                                      title:
                                                          const Text("Error"),
                                                      description: const Text(
                                                          "Error Occured, Please try again"),
                                                    ).show(context);
                                                  });
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                        itemCount:
                                            controller.cartProducts.length,
                                      ));
                                }
                              }));
                    }),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Rs. 699",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: const Color(0XFF242424),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                ),
                                builder: (context) {
                                  return Container(
                                    height: 328,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 23.0, top: 4, right: 12),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Package Details",
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18,
                                                    color:
                                                        const Color(0XFF242424),
                                                  ),
                                                ),
                                                const Spacer(),
                                                IconButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  icon: const Icon(Icons.close),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Arunodaya Basic Health Checkup",
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: const Color(0XFF242424),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Includes 8 Tests",
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                color: const Color(0XFF242424),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "These metabolites are derived from cortisol and cortisone and measure approximately half to two-thirds of cortisol and its metabolites.",
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: const Color(0XFF242424),
                                              ),
                                            )
                                          ]),
                                    ),
                                  );
                                });
                          },
                          child: Text(
                            "View Details",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: const Color(0XFF242424),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.BOOKING);
                      },
                      child: Container(
                        width: 170,
                        height: 40,
                        decoration: BoxDecoration(
                          color: kBtnColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            "Book Now",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.white,
                            ),
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

// GetBuilder<CartController>(builder: (controller) {
//               if (controller.isCaliculationDone.value = false) {
//                 return Center(
//                   child: CircularProgressIndicator(
//                     color: kPrimaryColor,
//                   ),
//                 );
//               } else {
//                 return Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Container(
//                     height: MediaQuery.of(context).size.height * 0.42,
//                     decoration: const BoxDecoration(
//                       color: Color(0XFF458090),
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(30),
//                         topRight: Radius.circular(30),
//                       ),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(20.0),
//                       child: Column(
//                         children: [
//                           Row(
//                             children: [
//                               Text(
//                                 "Subtotal",
//                                 style: cartCheckoutTextStyle,
//                               ),
//                               const Spacer(),
//                               Text(
//                                 "₹ ${controller.subTotal.value.toString()}",
//                                 style: cartCheckoutTextStyle.copyWith(
//                                     color: Colors.white),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 "Home Collection Fee",
//                                 style: cartCheckoutTextStyle,
//                               ),
//                               const Spacer(),
//                               Text(
//                                 "₹ ${controller.taxAndFee.value.toString()}",
//                                 style: cartCheckoutTextStyle.copyWith(
//                                     color: Colors.white),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 "Delivery",
//                                 style: cartCheckoutTextStyle,
//                               ),
//                               const Spacer(),
//                               Text(
//                                 controller.delivery.value.toString(),
//                                 style: cartCheckoutTextStyle.copyWith(
//                                     color: Colors.white),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 "Total",
//                                 style: cartCheckoutTextStyle.copyWith(
//                                     fontSize: 17,
//                                     fontWeight: FontWeight.w900),
//                               ),
//                               const Spacer(),
//                               Text(
//                                 "₹ ${controller.total.value.toString()}",
//                                 style: cartCheckoutTextStyle.copyWith(
//                                     color: Colors.white,
//                                     fontSize: 17,
//                                     fontWeight: FontWeight.w900),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * 0.07,
//                           ),
//                           GetBuilder<CartController>(builder: (controller) {
//                             return InkWell(
//                               onTap: () async {
//                                 if (!controller
//                                     .isLocationPermissionGranted.value) {
//                                   showDialog(
//                                       context: context,
//                                       builder: (context) {
//                                         return AlertDialog(
//                                           title: const Text(
//                                               "Location Access Disabled"),
//                                           content: const Text(
//                                               "Please turn on the Location Access to Checkout"),
//                                           actions: [
//                                             TextButton(
//                                               onPressed: () async {
//                                                 await openAppSettings();
//                                                 Get.back();
//                                               },
//                                               child: const Text("OK"),
//                                             )
//                                           ],
//                                         );
//                                       });
//                                 } else {
//                                   showDialog(
//                                       context: context,
//                                       builder: (context) {
//                                         return AlertDialog(
//                                           title: const Text(
//                                               "Location Access Granted"),
//                                           content: const Text(
//                                               "Location Service Active, Thanks for Believing TrueMedix"),
//                                           actions: [
//                                             TextButton(
//                                                 onPressed: () {},
//                                                 child: const Text("Continue"))
//                                           ],
//                                         );
//                                       });
//                                 }
//                               },
//                               child: Container(
//                                 height: 45,
//                                 width:
//                                     MediaQuery.of(context).size.width * 0.7,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: const Center(
//                                   child: Text(
//                                     "Checkout",
//                                     style: TextStyle(
//                                         fontSize: 20,
//                                         color: Color(0XFF537f8e),
//                                         fontWeight: FontWeight.w800),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               }
//             }),
