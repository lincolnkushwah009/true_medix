import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global/customtext.dart';
import '../../../routes/app_pages.dart';
import '../../../utilities/appcolors.dart';
import '../controllers/productdetail_controller.dart';

class ProductdetailView extends GetView {
  const ProductdetailView({super.key});

  @override
  Widget build(BuildContext context) {
    ProductdetailController controller = Get.put(ProductdetailController());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(249.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(49.0),
          ),
          child: AppBar(
            backgroundColor: kAppBarColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(49),
              ),
            ),
            leading: Card(
              margin: const EdgeInsets.fromLTRB(12, 12, 0, 0),
              elevation: 1.0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              color: kAppBarColor.withOpacity(0.8),
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: SizedBox(
                  height: Get.height * 0.03,
                  width: Get.height * 0.05,
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 28,
                  ),
                ),
              ),
            ),
            actions: [
              Card(
                margin: const EdgeInsets.fromLTRB(0, 12, 12, 0),
                elevation: 1.0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                color: kAppBarColor.withOpacity(0.8),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.CART);
                  },
                  child: SizedBox(
                    height: Get.height * 0.03,
                    width: Get.height * 0.05,
                    child: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.black,
                      size: 28,
                    ),
                  ),
                ),
              )
            ],
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(top: 35.0),
              child: Image.asset(
                "assets/bottal.png",
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
          child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.0),
                  child: CustomText(
                    textName: "ALBERTS STAIN REPORT",
                    fontColor: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                        textName: "₹ 499",
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        width: Get.width * 0.36,
                      ),
                      Expanded(
                        child: Container(
                          width: Get.width * 0.24,
                          height: Get.height * 0.064,
                          decoration: BoxDecoration(
                              color: kAppBarColor,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(14)),
                          child: Obx(() => Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          controller.removeQuantity();
                                        },
                                        child: const Icon(
                                          Icons.remove,
                                        )),
                                    CustomText(
                                      textName:
                                          controller.quantity.value.toString(),
                                      fontSize: 26,
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          controller.addQuantity();
                                        },
                                        child: const Icon(Icons.add)),
                                  ])),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: CustomText(
                    textName: "About Product",
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.0),
                  child: CustomText(
                    fontColor: Color(0XFF606060),
                    textName:
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s,",
                    fontSize: 15,
                  ),
                )
              ]),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
        width: Get.width * 0.8,
        height: Get.height * 0.07,
        decoration: BoxDecoration(
            color: kAppBarColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20)),
        child: const Center(
            child: CustomText(
          textName: "Add to Cart",
          fontWeight: FontWeight.w500,
          fontSize: 22,
        )),
      ),
    );
  }
}
