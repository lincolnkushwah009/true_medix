// ignore_for_file: avoid_print, unrelated_type_equality_checks

import 'dart:developer';

import 'package:banner_carousel/banner_carousel.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:true_medix/app/routes/app_pages.dart';
import 'package:true_medix/app/utilities/appcolors.dart';

import '../../../global/productwidget.dart';
import '../../../services/apiServives/apiservices.dart';
import '../../cart/controllers/cart_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeController? controller;
  CartController? cartController;
  @override
  void initState() {
    controller = Get.put<HomeController>(HomeController());

    controller!.initBannerCall();
    controller!.initProductsCall();
    cartController = Get.put<CartController>(CartController());
    cartController!.initGetCartProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              decoration: BoxDecoration(
                color: kPrimaryColor,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey,
                      blurStyle: BlurStyle.normal,
                      blurRadius: 5),
                ],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0, top: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 104,
                        height: 39,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/logo.png"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        width: MediaQuery.of(context).size.width * 0.73,
                        child: Center(
                          child: TextFormField(
                            controller: TextEditingController(),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(
                                    left: 0.0, top: 15, bottom: 15),
                                child: SvgPicture.asset("assets/search.svg"),
                              ),
                              hintText: 'Search Test',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Card(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        color: const Color(0XFF75DBEB),
                        child: GestureDetector(
                          onTap: () {
                            print("Menu Clicked");
                          },
                          child: SizedBox(
                            height: Get.height * 0.06,
                            width: Get.height * 0.06,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SvgPicture.asset("assets/menu.svg"),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 08,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 20),
                    child: SizedBox(
                      height: 81,
                      child: ListView.builder(
                          itemCount: controller!.homeTestList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return SizedBox(
                                height: 100,
                                child: Row(
                                  children: [
                                    controller!.homeTestList[index],
                                    const SizedBox(
                                      width: 14,
                                    ),
                                  ],
                                ));
                          }),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8,
                top: 18,
              ),
              child: SizedBox(
                  height: 135,
                  width: MediaQuery.of(context).size.width,
                  child: GetBuilder<HomeController>(builder: (controller) {
                    if (controller.bannerLoading.value) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.withOpacity(0.25),
                        highlightColor: Colors.white.withOpacity(0.6),
                        period: const Duration(seconds: 1),
                        loop: 10,
                        child: Container(
                          height: 260,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      );
                    } else {
                      return BannerCarousel(
                        showIndicator: true,
                        banners: controller.bannerList.map((e) {
                          return BannerModel(imagePath: e.image, id: e.id);
                        }).toList(),
                        customizedIndicators: const IndicatorModel.animation(
                            width: 7,
                            height: 7,
                            spaceBetween: 5,
                            widthAnimation: 38),
                        height: 260,
                        activeColor: const Color(0XFF43D2DE),
                        disableColor: Colors.white,
                        animation: true,
                        borderRadius: 10,
                        width: 250,
                        indicatorBottom: false,
                      );
                    }
                  })),
            ),
            const SizedBox(
              height: 18,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: GetBuilder<HomeController>(builder: (controller) {
                if (controller.productsLoading.value) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: controller.productsList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Get.toNamed(Routes.PRODUCTDETAIL,
                                  arguments: controller.productsList[index]);
                            },
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.withOpacity(0.25),
                              highlightColor: Colors.white.withOpacity(0.6),
                              loop: 10,
                              period: const Duration(seconds: 2),
                              direction: ShimmerDirection.ltr,
                              child: ProductWidget(
                                onTap: () {},
                                title: controller.productsList[index].name
                                    .toString(),
                                price: controller.productsList[index].price
                                    .toString(),
                              ),
                            ),
                          );
                        }),
                  );
                } else {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.438,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: controller.productsList.length,
                        itemBuilder: (context, index) {
                          return GetBuilder<HomeController>(
                              builder: (controller) {
                            return InkWell(
                              onTap: () {
                                Get.toNamed(Routes.PRODUCTDETAIL,
                                    arguments: controller.productsList[index]);
                              },
                              child: ProductWidget(
                                onTap: () {
                                  List<dynamic> cartProductId = cartController!
                                      .cartProducts
                                      .map((element) {
                                    return element.id;
                                  }).toList();
                                  cartProductId
                                      .add(controller.productsList[index].id);
                                  log(cartProductId.toList().toString());
                                  Map<String, dynamic> payLoad = {
                                    "mobile_no": "",
                                    "products": cartProductId,
                                  };
                                  ApiServices()
                                      .addToCart(payLoad)
                                      .then((value) {
                                    cartController!.initGetCartProducts();
                                    ElegantNotification.success(
                                      title: const Text("Success"),
                                      description:
                                          Text(value['message'].toString()),
                                    ).show(context);
                                  }).onError((error, stackTrace) {
                                    log(stackTrace.toString());
                                    ElegantNotification.error(
                                      title: const Text("Error"),
                                      description: const Text(
                                          "Error Occured, Please try again"),
                                    ).show(context);
                                  });
                                },
                                title: controller.productsList[index].name
                                    .toString(),
                                price: controller.productsList[index].price
                                    .toString(),
                              ),
                            );
                          });
                        }),
                  );
                }
              }),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: "Call Customer",
        backgroundColor: kPrimaryColor,
        onPressed: () async {
          await controller!.launchCustomerCarePhone();
        },
        child: const Icon(
          Icons.phone,
          color: Colors.black,
        ),
      ),
    );
  }
}
