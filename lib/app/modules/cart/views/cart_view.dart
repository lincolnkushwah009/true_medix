// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shimmer/shimmer.dart';
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
  @override
  void initState() {
    controller = Get.put<CartController>(CartController());
    controller!.subTotal.value = 0.0;
    controller!.taxAndFee.value = 0.0;
    controller!.delivery.value = "Free";
    controller!.total.value = 0.0;
    controller!.initGetCartProducts();
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(
                height: 27,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "My Cart",
                      style: heading1Style.copyWith(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 27,
                    ),
                    GetBuilder<CartController>(builder: (controller) {
                      if (controller.cartProductsLoading.value) {
                        return SizedBox(
                            height: 300,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return Center(
                                    child: Shimmer.fromColors(
                                  baseColor: Colors.grey.withOpacity(0.25),
                                  highlightColor: Colors.white.withOpacity(0.6),
                                  loop: 10,
                                  direction: ShimmerDirection.ltr,
                                  period: const Duration(seconds: 1),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                ));
                              },
                              itemCount: 8,
                            ));
                      } else {
                        return SizedBox(
                            height: 300,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 30.0),
                                  child: TestCartWidget(
                                    image: controller.cartProducts[index].image
                                        .toString(),
                                    title: controller.cartProducts[index].name
                                        .toString(),
                                    subTitle: controller
                                        .cartProducts[index].apiDepartmentName
                                        .toString(),
                                    price: controller.cartProducts[index].price
                                        .toString(),
                                    onTap: () async {},
                                  ),
                                );
                              },
                              itemCount: controller.cartProducts.length,
                            ));
                      }
                    }),
                  ],
                ),
              ),
              GetBuilder<CartController>(builder: (controller) {
                if (controller.isCaliculationDone.value = false) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  );
                } else {
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.42,
                      decoration: const BoxDecoration(
                        color: Color(0XFF458090),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Subtotal",
                                  style: cartCheckoutTextStyle,
                                ),
                                const Spacer(),
                                Text(
                                  "₹ ${controller.subTotal.value.toString()}",
                                  style: cartCheckoutTextStyle.copyWith(
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Home Collection Fee",
                                  style: cartCheckoutTextStyle,
                                ),
                                const Spacer(),
                                Text(
                                  "₹ ${controller.taxAndFee.value.toString()}",
                                  style: cartCheckoutTextStyle.copyWith(
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Delivery",
                                  style: cartCheckoutTextStyle,
                                ),
                                const Spacer(),
                                Text(
                                  controller.delivery.value.toString(),
                                  style: cartCheckoutTextStyle.copyWith(
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Total",
                                  style: cartCheckoutTextStyle.copyWith(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w900),
                                ),
                                const Spacer(),
                                Text(
                                  "₹ ${controller.total.value.toString()}",
                                  style: cartCheckoutTextStyle.copyWith(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w900),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.07,
                            ),
                            GetBuilder<CartController>(builder: (controller) {
                              return InkWell(
                                onTap: () async {
                                  if (!controller
                                      .isLocationPermissionGranted.value) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text(
                                                "Location Access Disabled"),
                                            content: const Text(
                                                "Please turn on the Location Access to Checkout"),
                                            actions: [
                                              TextButton(
                                                onPressed: () async {
                                                  await openAppSettings();
                                                  Get.back();
                                                },
                                                child: const Text("OK"),
                                              )
                                            ],
                                          );
                                        });
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text(
                                                "Location Access Granted"),
                                            content: const Text(
                                                "Location Service Active, Thanks for Believing TrueMedix"),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {},
                                                  child: const Text("Continue"))
                                            ],
                                          );
                                        });
                                  }
                                },
                                child: Container(
                                  height: 45,
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Checkout",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0XFF537f8e),
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
