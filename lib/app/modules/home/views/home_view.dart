// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:true_medix/app/routes/app_pages.dart';
import 'package:true_medix/app/utilities/appcolors.dart';

import '../../../global/hometestwidget.dart';
import '../../../global/productwidget.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 40),
                child: Container(
                  height: 135,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset("assets/homeBranding.png"),
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30),
                child: SizedBox(
                  height: 1600,
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 50.0,
                    children: List.generate(
                      30,
                      (index) {
                        return InkWell(
                          onTap: () {
                            Get.toNamed(Routes.PRODUCTDETAIL);
                          },
                          child: ProductWidget(
                            image: "assets/bottal.png",
                            title: "ALBERTS STAIN REPORT",
                            price: "300",
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
