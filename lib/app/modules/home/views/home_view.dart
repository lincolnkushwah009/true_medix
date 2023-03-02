// ignore_for_file: avoid_print, unrelated_type_equality_checks

import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:true_medix/app/modules/home/models/homeproductmodel.dart';
import 'package:true_medix/app/modules/productdetail/models/productmodel.dart';
import 'package:true_medix/app/modules/productdetail/views/productdetail_view.dart';
import 'package:true_medix/app/modules/search/views/search_view.dart';
import 'package:true_medix/app/modules/uploadprescription/views/uploadprescription_view.dart';
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
  List<Records>? records;
  String querySearch = "arunodaya";
  int page = 1;
  SessionManager sessionManager = SessionManager();
  ScrollController scrollController = ScrollController();
  bool isLoggedOut = false;
  @override
  void initState() {
    controller = Get.put<HomeController>(HomeController());
    controller!.initBannerCall();
    callProducts(page, querySearch);
    cartController = Get.put<CartController>(CartController());
    cartController!.initGetCartProducts();
    scrollController.addListener(onScroolPagination);
    super.initState();
  }

  void callProducts(int page, String searchQuery) async {
    List<Records>? data = (await controller!
            .initProductsCall(page: page.toString(), query: searchQuery))
        .records;

    setState(() {
      records = data;
    });
    // Future.delayed(const Duration(seconds: 1), () {});
  }

  void onScroolPagination() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      page = page + 1;
      page = (page > int.parse(controller!.productsList.totalPages!))
          ? (page - 1)
          : page;
      setState(() {});
      callProducts(page, querySearch);
    }
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
                            Row(
                              children: [
                                Tooltip(
                                  message: "Upload Prescription",
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(
                                          () => const UploadprescriptionView());
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                "assets/prescription.png"),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
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
                                        Future.delayed(
                                            const Duration(seconds: 2), () {
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                                  Routes.LOGINWITHPASSWORD,
                                                  (Route<dynamic> route) =>
                                                      false);
                                        });
                                      }).onError((error, stackTrace) {});
                                    },
                                    icon: Image.asset(
                                      "assets/logout.png",
                                      color: kBtnColor,
                                      width: 30,
                                      height: 30,
                                    ),
                                  ),
                                ),
                              ],
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
                            child: InkWell(
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
                                return InkWell(
                                  splashColor: Colors.black,
                                  highlightColor: Colors.green,
                                  onTap: () {
                                    for (var element
                                        in controller!.homeTestList) {
                                      element.isActive = false;
                                    }
                                    querySearch = index == 0
                                        ? controller!.homeTestList[index].title
                                            .toString()
                                            .split(' ')[1]
                                            .toString()
                                        : (index == 4)
                                            ? controller!
                                                .homeTestList[index].title
                                                .toString()
                                                .split(" ")[0]
                                                .toString()
                                            : controller!
                                                .homeTestList[index].title
                                                .toString();
                                    controller!.homeTestList[index].isActive =
                                        true;
                                    page = 1;
                                    setState(() {});
                                    callProducts(page, querySearch);
                                  },
                                  child: Ink(
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
                      width: MediaQuery.of(context).size.width,
                      child: GetBuilder<HomeController>(builder: (controller) {
                        return FutureBuilder(
                            future: controller.apiServices.getRunningBanners(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey.withOpacity(0.25),
                                  highlightColor: Colors.white.withOpacity(0.6),
                                  child: CarouselSlider(
                                    options: CarouselOptions(
                                      height: 400.0,
                                      autoPlay: true,
                                      enlargeCenterPage: true,
                                      autoPlayInterval:
                                          const Duration(seconds: 2),
                                    ),
                                    items: [1, 2, 3, 4, 5, 6].map((i) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 400,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                              image: const DecorationImage(
                                                image: AssetImage(
                                                    "assets/brand.png"),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }).toList(),
                                  ),
                                );
                              } else {
                                return CarouselSlider(
                                  options: CarouselOptions(
                                    height: 135.0,
                                    autoPlay: true,
                                    enlargeCenterPage: true,
                                    autoPlayInterval:
                                        const Duration(seconds: 2),
                                  ),
                                  items: snapshot.data == null
                                      ? ["assets/brand.png"].map((i) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 400,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          i.toString()),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        }).toList()
                                      : snapshot.data!.map((i) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return GestureDetector(
                                                onTap: () {
                                                  Get.to(
                                                    () => ProductdetailView(
                                                      isBannerInput: true,
                                                      productData:
                                                          ProductModel.fromJson(
                                                              i.product![0]
                                                                  .toJson()),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 400,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          i.image.toString()),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        }).toList(),
                                );
                              }
                            });
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
                    if (controller.productsList.records!.isEmpty) {
                      return Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Image.asset("assets/noitem.png"),
                        ),
                      );
                    }
                    if (controller.productsList.records == null) {
                      return Center(
                        child: Image.asset("assets/oops.png"),
                      );
                    }
                    return Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.438,
                          child: ListView.builder(
                              controller: scrollController,
                              scrollDirection: Axis.vertical,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: records!.length,
                              itemBuilder: (context, index) {
                                return GetBuilder<HomeController>(
                                    builder: (controller) {
                                  return InkWell(
                                    splashColor: Colors.black,
                                    highlightColor: Colors.green,
                                    onTap: () {
                                      Get.to(
                                        () => ProductdetailView(
                                          isBannerInput: false,
                                          productData: ProductModel.fromJson(
                                              records![index].toJson()),
                                        ),
                                      );
                                    },
                                    child: Ink(
                                      child: Card(
                                        child: ProductWidget(
                                          rating: records![index]
                                              .ratings!
                                              .total
                                              .toString(),
                                          onTap: () {
                                            List<dynamic> cartProductId =
                                                cartController!.cartProducts
                                                    .map((element) {
                                              return element.id;
                                            }).toList();
                                            cartProductId.add(controller
                                                .productsList
                                                .records![index]
                                                .id);
                                            log(cartProductId
                                                .toList()
                                                .toString());
                                            Map<String, dynamic> payLoad = {
                                              "mobile_no": "",
                                              "products": cartProductId,
                                            };
                                            ApiServices()
                                                .addToCart(payLoad)
                                                .then((value) {
                                              cartController!
                                                  .initGetCartProducts();
                                              ElegantNotification.success(
                                                title: const Text("Success"),
                                                description: Text(
                                                    value['message']
                                                        .toString()),
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
                                          title:
                                              records![index].name.toString(),
                                          price: records![index]
                                              .saleprice
                                              .toString(),
                                        ),
                                      ),
                                    ),
                                  );
                                });
                              }),
                        ),
                      ],
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
              //FOR PHONE NUMBER:
              final Uri phoneLaunchUri =
                  Uri(scheme: 'tel', path: "+91 8055554468");
              await controller!
                  .launchCustomerCarePhone(phoneLaunchUri.toString())
                  .then((value) {})
                  .onError((error, stackTrace) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                        title: Text("Call Customer Care "),
                        content: Text(
                            "Failed to Call Cutomer, We will resolve this Issue Soon"),
                      );
                    });
              });
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
