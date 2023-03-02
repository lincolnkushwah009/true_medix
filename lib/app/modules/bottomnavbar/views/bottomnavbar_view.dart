// ignore_for_file: import_of_legacy_library_into_null_safe, must_be_immutable

import 'dart:developer';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:true_medix/app/modules/cart/controllers/cart_controller.dart';
import 'package:true_medix/app/modules/home/views/home_view.dart';
import 'package:true_medix/app/modules/orderhistory/views/orderhistory_view.dart';
import 'package:true_medix/app/modules/profile/views/profile_view.dart';
import 'package:true_medix/app/utilities/appcolors.dart';

import '../../../utilities/appstyles.dart';
import '../../cart/views/cart_view.dart';
import '../controllers/bottomnavbar_controller.dart';

class BottomnavbarView extends StatefulWidget {
  BottomnavbarView(
      {required this.incomingIndex, this.isPaymentSuccess = false, Key? key})
      : super(key: key);
  int incomingIndex = 0;
  bool isPaymentSuccess;

  @override
  State<BottomnavbarView> createState() => _BottomnavbarViewState();
}

class _BottomnavbarViewState extends State<BottomnavbarView> {
  BottomnavbarController? controller;
  CartController? cartController;
  List<Widget> pages = const [
    HomeView(),
    CartView(),
    OrderhistoryView(),
    ProfileView(),
  ];
  @override
  void initState() {
    controller = Get.put<BottomnavbarController>(BottomnavbarController());
    cartController = Get.put<CartController>(CartController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BottomnavbarController controller =
        Get.put<BottomnavbarController>(BottomnavbarController());
    return Scaffold(
      body: pages[widget.incomingIndex],
      bottomNavigationBar: BottomNavyBar(
        showElevation: true,
        backgroundColor: Colors.white60,
        selectedIndex: widget.incomingIndex,
        onItemSelected: (index) {
          widget.incomingIndex = index;
          setState(() {});
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
              title: Row(
                children: [
                  Text(
                    'Cart',
                    style: navBarItemsStyle,
                  ),
                ],
              ),
              icon: Stack(
                children: [
                  Image.asset(
                    "assets/bag.png",
                    width: 20,
                    height: 20,
                  ),
                  Positioned(
                    right: -0.5,
                    top: -0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.red,
                      ),
                      child: Center(
                        child: Obx(() => Text(
                              cartController!.cartProducts.length.toString(),
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 7),
                            )),
                      ),
                    ),
                  ),
                ],
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
      ),
    );
  }
}
