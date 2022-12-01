import 'dart:developer';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:true_medix/app/modules/productdetail/views/productdetail_view.dart';
import '../../../utilities/appcolors.dart';
import '../controllers/navigationbar_controller.dart';

class BottonNavBarView extends GetView<BottomnavbarController> {
  const BottonNavBarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
    BottomnavbarController controller =
        Get.put<BottomnavbarController>(BottomnavbarController());
    List<Widget> pages = const [
      ProductdetailView(),
      ProductdetailView(),
      ProductdetailView(),
      ProductdetailView(),
    ];
    return Scaffold(
      body: Obx(() {
        return pages[controller.selectedNavigationBarItem.value];
      }),
      bottomNavigationBar: CurvedNavigationBar(
        key: bottomNavigationKey,
        index: controller.selectedNavigationBarItem.value,
        height: 60.0,
        items: <Widget>[
          Column(
            children: [
              Obx(() => SvgPicture.asset(
                    "assets/Images/Diet.svg",
                    width: 30,
                    height: 30,
                    color: controller.selectedNavigationBarItem.value == 0
                        ? kPrimaryColor
                        : Colors.grey,
                  )),
              const Text("Nav1")
            ],
          ),
          Column(
            children: [
              Obx(() => SvgPicture.asset(
                    "assets/Images/Diet.svg",
                    width: 30,
                    height: 30,
                    color: controller.selectedNavigationBarItem.value == 1
                        ? kPrimaryColor
                        : Colors.grey,
                  )),
              const Text("Nav2")
            ],
          ),
          Column(
            children: [
              Obx(() => SvgPicture.asset(
                    "assets/Images/Diet.svg",
                    width: 30,
                    height: 30,
                    color: controller.selectedNavigationBarItem.value == 2
                        ? kPrimaryColor
                        : Colors.grey,
                  )),
              const Text("Nav3")
            ],
          ),
          Column(
            children: [
              Obx(() => SvgPicture.asset(
                    "assets/Images/Diet.svg",
                    width: 30,
                    height: 30,
                    color: controller.selectedNavigationBarItem.value == 3
                        ? kPrimaryColor
                        : Colors.grey,
                  )),
              const Text("Nav4")
            ],
          ),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: kPrimaryColor,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          controller.selectedNavigationBarItem.value = index;
          log("Selected Index ===> ${controller.selectedNavigationBarItem.value + 1}");
          controller.logger.i(
              "Selected Index ===> ${controller.selectedNavigationBarItem.value + 1}");
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
