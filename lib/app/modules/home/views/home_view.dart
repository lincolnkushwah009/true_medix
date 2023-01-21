// ignore_for_file: avoid_print, unrelated_type_equality_checks

import 'dart:developer';

import 'package:banner_carousel/banner_carousel.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:true_medix/app/modules/search/views/search_view.dart';
import 'package:true_medix/app/routes/app_pages.dart';
import 'package:true_medix/app/services/sessionmanager.dart';
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
  SessionManager sessionManager = SessionManager();
  bool isLoggedOut = false;
  @override
  void initState() {
    controller = Get.put<HomeController>(HomeController());

    controller!.initBannerCall();
    controller!.initProductsCall(page: "1", query: "arunodaya");
    cartController = Get.put<CartController>(CartController());
    cartController!.initGetCartProducts();
    super.initState();
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit App'),
            content: const Text('Do you want to exit an App?'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kBtnColor),
                ),
                child: const Text('No'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kBtnColor),
                ),
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: true,
      overlayColor: kPrimaryColor,
      overlayWholeScreen: true,
      switchInCurve: Curves.bounceIn,
      switchOutCurve: Curves.bounceOut,
      closeOnBackButton: true,
      disableBackButton: false,
      child: WillPopScope(
        onWillPop: showExitPopup,
        child: Scaffold(
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
                        child: Row(
                          children: [
                            Container(
                              width: 104,
                              height: 39,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/logo.png"),
                                ),
                              ),
                            ),
                            const Spacer(),
                            Tooltip(
                              message: "Logout",
                              child: IconButton(
                                onPressed: () async {
                                  SharedPreferences sharedPreferences =
                                      await SharedPreferences.getInstance();
                                  sharedPreferences
                                      .setString("AUTHID", "null")
                                      .then((value) {
                                    isLoggedOut == false
                                        ? const LinearProgressIndicator(
                                            color: Colors.red,
                                          )
                                        : const SizedBox();
                                    Future.delayed(const Duration(seconds: 2),
                                        () {
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                              Routes.LOGINWITHPASSWORD,
                                              (Route<dynamic> route) => false);
                                    });
                                  }).onError((error, stackTrace) {});
                                },
                                icon: const Icon(Icons.logout),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 8),
                        child: Container(
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                Get.to(const SearchView());
                              },
                              child: TextFormField(
                                enabled: false,
                                controller: TextEditingController(),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 0.0, top: 15, bottom: 15),
                                    child:
                                        SvgPicture.asset("assets/search.svg"),
                                  ),
                                  hintText: 'Search Test',
                                ),
                              ),
                            ),
                          ),
                        ),
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
                                return GestureDetector(
                                  onTap: () {
                                    controller!.initProductsCall(
                                        page: "1",
                                        query: controller!
                                            .homeTestList[index].title
                                            .toString());
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      height: 100,
                                      child: Row(
                                        children: [
                                          controller!.homeTestList[index],
                                          const SizedBox(
                                            width: 14,
                                          ),
                                        ],
                                      )),
                                );
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
                            customizedIndicators:
                                const IndicatorModel.animation(
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
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.withOpacity(0.25),
                        highlightColor: Colors.white.withOpacity(0.6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ProductWidget(
                              rating: "1299 Rating",
                              onTap: () {},
                              title: "Arunodaya Basic Health Check Up",
                              price: "599.00",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ProductWidget(
                              rating: "1299 Rating",
                              onTap: () {},
                              title: "sjsdsdsdsds".toString(),
                              price: "sdsdssd",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ProductWidget(
                              rating: "1299 Rating",
                              onTap: () {},
                              title: "sjsdsdsdsds".toString(),
                              price: "sdsdssd",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ProductWidget(
                              rating: "1299 Rating",
                              onTap: () {},
                              title: "sjsdsdsdsds".toString(),
                              price: "sdsdssd",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ProductWidget(
                              rating: "1299 Rating",
                              onTap: () {},
                              title: "sjsdsdsdsds".toString(),
                              price: "sdsdssd",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      );
                    }
                    if (controller.productsList.isEmpty) {
                      return Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Image.asset("assets/noitem.png"),
                        ),
                      );
                    }
                    if (controller.productsList == null) {
                      return Center(
                        child: Image.asset("assets/oops.png"),
                      );
                    }
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
                                      arguments:
                                          controller.productsList[index]);
                                },
                                child: Card(
                                  child: ProductWidget(
                                    rating: controller
                                        .productsList[index].ratings!.total
                                        .toString(),
                                    onTap: () {
                                      List<dynamic> cartProductId =
                                          cartController!.cartProducts
                                              .map((element) {
                                        return element.id;
                                      }).toList();
                                      cartProductId.add(
                                          controller.productsList[index].id);
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
                                    price: controller
                                        .productsList[index].saleprice
                                        .toString(),
                                  ),
                                ),
                              );
                            });
                          }),
                    );
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
        ),
      ),
    );
  }
}
