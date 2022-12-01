// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:true_medix/app/modules/productdetail/views/productdetail_view.dart';

import '../../../utilities/appstyles.dart';
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
            ProductdetailView(),
            ProductdetailView(),
            ProductdetailView(),
            ProductdetailView(),
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
                  icon: const Icon(
                    Icons.home,
                    color: Colors.black,
                  )),
              BottomNavyBarItem(
                  title: Text(
                    'Item Two',
                    style: navBarItemsStyle,
                  ),
                  icon: const Icon(
                    Icons.apps,
                    color: Colors.black,
                  )),
              BottomNavyBarItem(
                  title: Text(
                    'Item Three',
                    style: navBarItemsStyle,
                  ),
                  icon: const Icon(
                    Icons.chat_bubble,
                    color: Colors.black,
                  )),
              BottomNavyBarItem(
                  title: Text(
                    'Item Four',
                    style: navBarItemsStyle,
                  ),
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.black,
                  )),
            ],
          )),
    );
  }
}
