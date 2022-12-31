import 'dart:developer';

import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:true_medix/app/modules/cart/controllers/cart_controller.dart';
import 'package:true_medix/app/modules/cart/views/cart_view.dart';
import 'package:true_medix/app/modules/productdetail/models/productmodel.dart';
import 'package:true_medix/app/services/apiServives/apiservices.dart';

import '../../../global/customtext.dart';
import '../../../utilities/appcolors.dart';
import '../controllers/productdetail_controller.dart';

class ProductdetailView extends StatefulWidget {
  const ProductdetailView({super.key});

  @override
  State<ProductdetailView> createState() => _ProductdetailViewState();
}

class _ProductdetailViewState extends State<ProductdetailView> {
  ProductdetailController? controller;
  CartController? cartController;
  @override
  void initState() {
    controller = Get.put(ProductdetailController());
    cartController = Get.put<CartController>(CartController());
    cartController!.initGetCartProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductModel productData = Get.arguments;
    log(productData.name.toString());
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
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const CartView(),
                        ),
                      );
                    },
                    child: SizedBox(
                      height: Get.height * 0.03,
                      width: Get.height * 0.05,
                      child: Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            const Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.black,
                              size: 28,
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                    child: Obx(() => Text(
                                          cartController!.cartProducts.length
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(top: 35.0, bottom: 5),
                child: Image.network(
                  productData.image.toString(),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: CustomText(
                  textName: productData.name.toString(),
                  fontColor: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: CustomText(
                  textName: "₹ ${productData.price.toString()}",
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: CustomText(
                  fontColor: const Color(0XFF606060),
                  textName: productData.description.toString(),
                  fontSize: 15,
                ),
              )
            ]),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: InkWell(
          onTap: () async {
            Map<String, dynamic> payLoad = {
              "mobile_no": "",
              "products": [productData.id.toString()]
            };
            ApiServices().addToCart(payLoad).then((value) {
              cartController!.initGetCartProducts();
              ElegantNotification.success(
                title: const Text("Success"),
                description: Text(value['message'].toString()),
              ).show(context);
            }).onError((error, stackTrace) {
              log(stackTrace.toString());
              ElegantNotification.error(
                title: const Text("Error"),
                description: const Text("Error Occured, Please try again"),
              ).show(context);
            });
          },
          child: Container(
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
        ));
  }
}
