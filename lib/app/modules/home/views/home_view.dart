// ignore_for_file: avoid_print, unrelated_type_equality_checks

import 'dart:developer';
import 'package:banner_carousel/banner_carousel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:true_medix/app/routes/app_pages.dart';
import 'package:true_medix/app/utilities/appcolors.dart';

import '../../../global/hometestwidget.dart';
import '../../../global/productwidget.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeController? controller;
  @override
  void initState() {
    controller = Get.put<HomeController>(HomeController());
    controller!.initBannerCall();
    controller!.initProductsCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            log(innerBoxIsScrolled.toString());
            return [
              SliverAppBar(
                expandedHeight: 260,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                pinned: true,
                floating: true,
                snap: true,
                title: innerBoxIsScrolled == true
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Center(
                              child: TextFormField(
                                controller: TextEditingController(),
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.black,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            color: kAppBarColor.withOpacity(0.8),
                            child: GestureDetector(
                              onTap: () {
                                print("Menu Clicked");
                              },
                              child: SizedBox(
                                height: Get.height * 0.06,
                                width: Get.height * 0.06,
                                child: const Icon(
                                  Icons.menu,
                                  color: Colors.black,
                                  size: 32,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
                backgroundColor: const Color(0XFFFAFAFA),
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    height: 279,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 20,
                          color: Colors.grey,
                        ),
                      ],
                      color: kPrimaryColor,
                      borderRadius: const BorderRadiusDirectional.only(
                        bottomStart: Radius.circular(40),
                        bottomEnd: Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: Center(
                                    child: TextFormField(
                                      controller: TextEditingController(),
                                      keyboardType: TextInputType.text,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Icon(
                                          Icons.search,
                                          color: Colors.black,
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  color: kAppBarColor.withOpacity(0.8),
                                  child: GestureDetector(
                                    onTap: () {
                                      print("Menu Clicked");
                                    },
                                    child: SizedBox(
                                      height: Get.height * 0.06,
                                      width: Get.height * 0.06,
                                      child: const Icon(
                                        Icons.menu,
                                        color: Colors.black,
                                        size: 32,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  HomeTestWidget(
                                    icon: "assets/Images/covid.svg",
                                    title: "Covid",
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  HomeTestWidget(
                                    icon: "assets/Images/Diabetic.svg",
                                    title: "Diabetic",
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  HomeTestWidget(
                                    icon: "assets/Images/Diet.svg",
                                    title: "Diet",
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  HomeTestWidget(
                                    icon: "assets/Images/EyeCare.svg",
                                    title: "EyeCare",
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  HomeTestWidget(
                                    icon: "assets/Images/Immunity.svg",
                                    title: "Immunity",
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  HomeTestWidget(
                                    icon: "assets/Images/Mom&Kids.svg",
                                    title: "Mom&Kids",
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  HomeTestWidget(
                                      icon: "assets/Images/SkinCare.svg",
                                      title: "SkinCare")
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                automaticallyImplyLeading: false,
              ),
            ];
          },
          body: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Container(
                    height: 135,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                    ),
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
                              width: 10,
                              height: 5,
                              spaceBetween: 5,
                              widthAnimation: 50),
                          height: 260,
                          activeColor: kPrimaryColor,
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
                height: 36,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: GetBuilder<HomeController>(builder: (controller) {
                  if (controller.productsLoading.value) {
                    return SizedBox(
                      height: 1900,
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20.0,
                        mainAxisSpacing: 50.0,
                        children: List.generate(controller.productsList.length,
                            (index) {
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
                                image: controller.productsList[index].image
                                    .toString(),
                                title: controller.productsList[index].name
                                    .toString(),
                                price: controller.productsList[index].price
                                    .toString(),
                              ),
                            ),
                          );
                        }),
                      ),
                    );
                  } else {
                    return SizedBox(
                      height: 1900,
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20.0,
                        mainAxisSpacing: 50.0,
                        children: List.generate(controller.productsList.length,
                            (index) {
                          return InkWell(
                            onTap: () {
                              Get.toNamed(Routes.PRODUCTDETAIL,
                                  arguments: controller.productsList[index]);
                            },
                            child: ProductWidget(
                              image: controller.productsList[index].image
                                  .toString(),
                              title: controller.productsList[index].name
                                  .toString(),
                              price: controller.productsList[index].price
                                  .toString(),
                            ),
                          );
                        }),
                      ),
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
