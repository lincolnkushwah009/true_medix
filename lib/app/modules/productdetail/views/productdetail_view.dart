import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global/customtext.dart';
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
                  if (kDebugMode) {
                    print("back clicked");
                  }
                },
                child: SizedBox(
                  height: Get.height * 0.08,
                  width: Get.height * 0.08,
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 32,
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
                    if (kDebugMode) {
                      print("added to cart ");
                    }
                  },
                  child: SizedBox(
                    height: Get.height * 0.08,
                    width: Get.height * 0.08,
                    child: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.black,
                      size: 32,
                    ),
                  ),
                ),
              )
            ],
            flexibleSpace: Image.asset(
              "assets/sampleProduct.jpeg",
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 6.0),
                child: CustomText(
                  textName: "Title",
                  fontColor: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CustomText(
                textName: "Sub- Title",
                fontColor: Colors.black.withOpacity(0.8),
                fontSize: 28,
                fontWeight: FontWeight.w300,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.currency_rupee,
                      size: 42,
                    ),
                    const CustomText(
                      textName: "499",
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
                                      child: const Icon(Icons.remove)),
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
                  fontSize: 30,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 6.0),
                child: CustomText(
                  textName: "Description",
                  fontSize: 18,
                ),
              )
            ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
        width: Get.width * 0.8,
        height: Get.height * 0.09,
        decoration: BoxDecoration(
            color: kAppBarColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20)),
        child: const Center(
            child: CustomText(
          textName: "Add to Cart",
          fontSize: 24,
        )),
      ),
    );
  }
}
