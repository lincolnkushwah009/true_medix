// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:true_medix/app/global/customdialog.dart';
import 'package:true_medix/app/modules/bottomnavbar/views/bottomnavbar_view.dart';
import 'package:true_medix/app/modules/productdetail/models/productmodel.dart';
import 'package:true_medix/app/routes/app_pages.dart';
import 'package:true_medix/app/services/sessionmanager.dart';
import 'package:true_medix/app/utilities/appcolors.dart';
import 'package:true_medix/app/utilities/appstyles.dart';

import '../../../global/testcartwidget.dart';
import '../controllers/cart_controller.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  CartController? controller;
  SessionManager sessionManager = SessionManager();
  @override
  void initState() {
    controller = Get.put<CartController>(CartController());
    controller!.subTotal.value = 0.0;
    controller!.taxAndFee.value = 0.0;
    controller!.delivery.value = "Free";
    controller!.total.value = 0.0;
    // controller!.getLocationPermission();
    controller!.getTotalPriceOfCart(controller!.cartProducts);
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
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
      ),
      bottomNavigationBar: GetBuilder<CartController>(builder: (controller) {
        return SizedBox(
          height: 80,
          child: controller.cartProducts.isEmpty
              ? const SizedBox()
              : FutureBuilder(
                  future:
                      controller!.getTotalPriceOfCart(controller!.cartProducts),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: LinearProgressIndicator(),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          double.parse(snapshot.data![1].toString()) > 0.0
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    "Home Collection charge Rs.150 for test less than Rs.500.",
                                    style: GoogleFonts.poppins(
                                        fontSize: 10,
                                        color: Colors.red,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )
                              : const SizedBox(),
                          Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Rs. ${double.parse(snapshot.data![0].toString()).toString()}",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: const Color(0XFF242424),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {},
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
                              InkWell(
                                splashColor: Colors.black,
                                highlightColor: Colors.green,
                                onTap: () {
                                  Get.toNamed(Routes.BOOKING);
                                },
                                child: Ink(
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
                        ],
                      ),
                    );
                  }),
        );
      }),
      body: SafeArea(
        child: GetBuilder<CartController>(
          builder: (cartController) {
            return ListView(
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
                      FutureBuilder(
                          future: cartController.apiServices.getCartProducts(),
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
                                  itemCount: cartController.cartProducts.length,
                                ),
                              );
                            }
                            if (snapshot.data == null) {
                              return Center(
                                child: Image.asset("assets/oops.png"),
                              );
                            }
                            if (snapshot.data!.isEmpty) {
                              return Align(
                                alignment: Alignment.center,
                                child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Image.asset("assets/emptycart.png")),
                              );
                            }
                            return SizedBox(
                                height:
                                    cartController.cartProducts.length * 220,
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
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
                                          relatedBundle: snapshot.data![index]
                                                      .relatedProducts ==
                                                  null
                                              ? "0"
                                              : (snapshot.data![index]
                                                      .relatedProducts!
                                                      .split(','))
                                                  .length
                                                  .toString(),
                                          onTapDrop: () {
                                            showModalBottomSheet(
                                                context: context,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15),
                                                  ),
                                                ),
                                                builder: (context) {
                                                  return Container(
                                                    height: 328,
                                                    decoration:
                                                        const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(15),
                                                        topRight:
                                                            Radius.circular(15),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 23.0,
                                                              top: 4,
                                                              right: 12),
                                                      child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Package Details",
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        18,
                                                                    color: const Color(
                                                                        0XFF242424),
                                                                  ),
                                                                ),
                                                                const Spacer(),
                                                                IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .close),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              cartController
                                                                  .cartProducts[
                                                                      index]
                                                                  .name
                                                                  .toString(),
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 16,
                                                                color: const Color(
                                                                    0XFF242424),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              "Includes ${snapshot.data![index].relatedProducts == null ? "0" : (snapshot.data![index].relatedProducts!.split(',')).length.toString()} Tests",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 14,
                                                                color: const Color(
                                                                    0XFF242424),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              "${cartController.cartProducts[index].description}" ==
                                                                          "null" ||
                                                                      cartController
                                                                              .cartProducts[index]
                                                                              .description
                                                                              .toString() ==
                                                                          ""
                                                                  ? "No Description Found, We will Update it Soon"
                                                                  : "${cartController.cartProducts[index].description}",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 12,
                                                                color: const Color(
                                                                    0XFF242424),
                                                              ),
                                                            )
                                                          ]),
                                                    ),
                                                  );
                                                });
                                          },
                                          title: snapshot.data![index].name
                                              .toString(),
                                          subTitle: snapshot
                                              .data![index].apiDepartmentName
                                              .toString(),
                                          price: snapshot.data![index].saleprice
                                              .toString(),
                                          onTapDeleted: () async {
                                            List<dynamic> cartProductId =
                                                snapshot.data!.map((element) {
                                              return element.id;
                                            }).toList();
                                            cartProductId.remove(
                                                snapshot.data![index].id);
                                            log(cartProductId
                                                .toList()
                                                .toString());
                                            Map<String, dynamic> payLoad = {
                                              "mobile_no": sessionManager
                                                  .getCustomer['mobile_no']
                                                  .toString(),
                                              "products": cartProductId,
                                            };
                                            cartController.apiServices
                                                .addToCart(payLoad)
                                                .then((value) {
                                              cartController.update();
                                              Get.offAll(
                                                () => BottomnavbarView(
                                                    incomingIndex: 1),
                                              );
                                              ElegantNotification.success(
                                                title: const Text("Success"),
                                                description: Text(
                                                    value['message']
                                                        .toString()),
                                              ).show(context);

                                              cartController.onInit();
                                            }).onError((error, stackTrace) {
                                              log(stackTrace.toString());
                                              ElegantNotification.error(
                                                title: const Text("Error"),
                                                description: const Text(
                                                    "Error Occured, Please try again"),
                                              ).show(context);
                                            });
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: cartController.cartProducts.length,
                                ));
                          }),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
