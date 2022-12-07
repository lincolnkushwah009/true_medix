// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:true_medix/app/modules/home/views/home_view.dart';
import 'package:true_medix/app/modules/orderhistory/views/orderhistory_view.dart';
import 'package:true_medix/app/modules/profile/views/profile_view.dart';

import '../../../utilities/appstyles.dart';
import '../../cart/views/cart_view.dart';
import '../controllers/bottomnavbar_controller.dart';

class BottomnavbarView extends GetView<BottomnavbarController> {
  const BottomnavbarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    BottomnavbarController controller =
        Get.put<BottomnavbarController>(BottomnavbarController());
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: controller.pageController,
          onPageChanged: (index) {
            controller.currentIndex.value = index;
          },
          children: const <Widget>[
            HomeView(),
            CartView(),
            OrderhistoryView(),
            ProfileView(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() => BottomNavyBar(
            selectedIndex: controller.currentIndex.value,
            onItemSelected: (index) {
              controller.currentIndex.value = index;
              controller.pageController.jumpToPage(index);
            },
            items: <BottomNavyBarItem>[
              BottomNavyBarItem(
                title: Text(
                  'Home',
                  style: navBarItemsStyle,
                ),
                icon: Image.asset(
                  "assets/home.png",
                  width: 20,
                  height: 20,
                ),
              ),
              BottomNavyBarItem(
                  title: Text(
                    'Cart',
                    style: navBarItemsStyle,
                  ),
                  icon: Image.asset(
                    "assets/bag.png",
                    width: 20,
                    height: 20,
                  )),
              BottomNavyBarItem(
                title: Text(
                  'Orders',
                  style: navBarItemsStyle,
                ),
                icon: Image.asset(
                  "assets/list.png",
                  width: 20,
                  height: 20,
                ),
              ),
              BottomNavyBarItem(
                title: Text(
                  'Profile',
                  style: navBarItemsStyle,
                ),
                icon: Image.asset(
                  "assets/account.png",
                  width: 20,
                  height: 20,
                ),
              ),
            ],
          )),
    );
  }
}
