import 'dart:developer';

import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:true_medix/app/modules/cart/controllers/cart_controller.dart';
import 'package:true_medix/app/modules/productdetail/models/productmodel.dart';
import 'package:true_medix/app/utilities/appcolors.dart';
import 'package:true_medix/app/utilities/appstyles.dart';

import '../../../services/apiServives/apiservices.dart';
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
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 11, right: 11, top: 24, bottom: 12),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: SvgPicture.asset("assets/back.svg")),
                  const SizedBox(
                    width: 15,
                  ),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        productData.name.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: testTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 11, right: 11, top: 0, bottom: 12),
              child: Row(
                children: [
                  const SizedBox(
                    width: 35,
                  ),
                  RatingBar.builder(
                    initialRating: 5,
                    minRating: 1,
                    ignoreGestures: true,
                    tapOnlyMode: false,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 16,
                    itemPadding: const EdgeInsets.all(4),
                    itemBuilder: (context, _) => SvgPicture.asset(
                      "assets/rating.svg",
                      width: 1,
                      height: 1,
                    ),
                    onRatingUpdate: (rating) {
                      log(rating.toString());
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const FittedBox(
                    child: Text("1356 Ratings",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color(0XFF242424))),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 11, right: 11, top: 0, bottom: 11),
              child: Row(
                children: [
                  const SizedBox(
                    width: 39,
                  ),
                  Text(
                    "Rs. " + "${productData.price}",
                    style: testTextStyle,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Rs. 2000.00",
                    style: testTextStyle.copyWith(
                        decoration: TextDecoration.lineThrough,
                        color: const Color(0XFF8F8F8F),
                        fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            // ignore: prefer_const_constructors
            Padding(
              padding:
                  const EdgeInsets.only(left: 11, right: 11, top: 0, bottom: 0),
              child: Text(
                "These metabolites are derived from cortisol and cortisone and measure approximately half to two-thirds of cortisol and its metabolites. This test is indicated for evaluation of adrenocortical function and to diagnose glucocorticoid related disorders.",
                textAlign: TextAlign.justify,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: const Color(0XFF242424),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 11, right: 11, top: 0, bottom: 11),
              child: Text(
                "Included Tests",
                style: testTextStyle.copyWith(fontSize: 15),
              ),
            ),
            const SizedBox(
              height: 22,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 33, right: 11, top: 0, bottom: 11),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: const Color(0XFF242424),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text("Urine Examination Routine; Urine R/E"),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: const Color(0XFF242424),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text("SGOT (AST)"),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: const Color(0XFF242424),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text("TSH (Thyroid Stimulating Hormone)"),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: const Color(0XFF242424),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text("CBC+ESR"),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: const Color(0XFF242424),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text("SGPT; Alanine Aminotransferase (ALT)"),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: const Color(0XFF242424),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text("Cholestrol, TOTAL"),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: const Color(0XFF242424),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text("Fasting Blood Sugar (FBS)"),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: 62,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0XFFBBEFFD)),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 28,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Rs. 150",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.lineThrough,
                                fontSize: 12,
                                color: const Color(0XFF8F8F8F)),
                          ),
                          Text(
                            "Rs. 99",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: const Color(0XFF242424),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        width: 78,
                        height: 29,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: const Color(0XFFFFF3EC),
                        ),
                        child: Center(
                          child: Text(
                            "Get 71 % Off",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: const Color(0XFF8F8F8F)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          List<dynamic> cartProductId =
                              cartController!.cartProducts.map((element) {
                            return element.id;
                          }).toList();
                          cartProductId.add(productData.id);
                          log(cartProductId.toList().toString());
                          Map<String, dynamic> payLoad = {
                            "mobile_no": "",
                            "products": cartProductId,
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
                              description:
                                  const Text("Error Occured, Please try again"),
                            ).show(context);
                          });
                        },
                        child: Container(
                          width: 85,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: kBtnColor,
                          ),
                          child: Center(
                              child: Text(
                            "ADD",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.white),
                          )),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
