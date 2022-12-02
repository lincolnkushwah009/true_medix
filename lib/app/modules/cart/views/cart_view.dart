import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:true_medix/app/utilities/appcolors.dart';
import 'package:true_medix/app/utilities/appstyles.dart';

import '../../../global/testcartwidget.dart';
import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          'Cart',
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
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 30.0),
                            child: TestCartWidget(
                              image: "assets/bottal.png",
                              title: "ALBERTS STAIN",
                              subTitle: "REPORT 2",
                              price: "300",
                            ),
                          );
                        },
                        itemCount: 3,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 270,
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
                            "₹ 300",
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
                            "Tax & Fees",
                            style: cartCheckoutTextStyle,
                          ),
                          const Spacer(),
                          Text(
                            "₹ 750",
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
                            "Free",
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
                                fontSize: 17, fontWeight: FontWeight.w900),
                          ),
                          const Spacer(),
                          Text(
                            "₹ 1050",
                            style: cartCheckoutTextStyle.copyWith(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width * 0.7,
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
                    ],
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
