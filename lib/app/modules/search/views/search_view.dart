import 'dart:developer';

import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:true_medix/app/modules/cart/controllers/cart_controller.dart';
import 'package:true_medix/app/modules/home/models/homeproductmodel.dart';
import 'package:true_medix/app/modules/productdetail/models/productmodel.dart';
import 'package:true_medix/app/services/apiServives/apiservices.dart';
import '../../../global/productwidget.dart';
import '../../productdetail/views/productdetail_view.dart';
import '../controllers/search_controller.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  SearchController? controller;
  CartController? cartController;

  @override
  void initState() {
    controller = Get.put<SearchController>(SearchController());
    cartController = Get.put<CartController>(CartController());
    fetchSearchProducts();
    super.initState();
  }

  fetchSearchProducts({String page = "1", String query = "diet"}) async {
    await ApiServices().getProducts(page: page, query: query).then((value) {
      controller!.isLoading.value = true;
      controller!.searchProducts.value = value.records!;
    }).onError((error, stackTrace) {});
    controller!.isLoading.value = false;
    controller!.update();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, right: 16, left: 16),
          child: ListView(
            children: [
              Container(
                height: 58,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(2, 2),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                width: MediaQuery.of(context).size.width * 0.91,
                child: Center(
                  child: InkWell(
                    onTap: () {
                      Get.to(const SearchView());
                    },
                    child: TextFormField(
                      controller: TextEditingController(),
                      keyboardType: TextInputType.text,
                      onChanged: (value) async {
                        fetchSearchProducts(page: "1", query: value);
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                              left: 0.0, top: 15, bottom: 15),
                          child: SvgPicture.asset("assets/search.svg"),
                        ),
                        hintText: 'Search Test',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: Container(
                    height: 500,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: GetBuilder<SearchController>(builder: (controller) {
                      if (controller.isLoading.value == true) {
                        return ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey.withOpacity(0.25),
                                highlightColor: Colors.white.withOpacity(0.6),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8.0),
                                  child: Card(
                                    child: Container(
                                      height: 80,
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        // color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      }
                      if (controller.searchProducts.isEmpty) {
                        return Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 50.0),
                            child: Image.asset("assets/noitem.png"),
                          ),
                        );
                      } else {
                        return ListView.builder(
                            itemCount: controller.searchProducts.length,
                            itemBuilder: (context, index) {
                              return GetBuilder<SearchController>(
                                  builder: (controller) {
                                return InkWell(
                                  splashColor: Colors.black,
                                  highlightColor: Colors.green,
                                  onTap: () {
                                    Get.to(
                                      () => ProductdetailView(
                                        isBannerInput: false,
                                        productData: ProductModel.fromJson(
                                          (controller.searchProducts[index]
                                                  as Records)
                                              .toJson(),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Ink(
                                    child: Card(
                                      child: ProductWidget(
                                        rating: controller.searchProducts[index]
                                            .ratings!.total
                                            .toString(),
                                        onTap: () {
                                          List<dynamic> cartProductId =
                                              cartController!.cartProducts
                                                  .map((element) {
                                            return element.id;
                                          }).toList();
                                          cartProductId.add(controller
                                              .searchProducts[index].id);
                                          log(cartProductId
                                              .toList()
                                              .toString());
                                          Map<String, dynamic> payLoad = {
                                            "mobile_no": "",
                                            "products": cartProductId,
                                          };
                                          ApiServices()
                                              .addToCart(payLoad)
                                              .then((value) {
                                            cartController!
                                                .initGetCartProducts();
                                            ElegantNotification.success(
                                              title: const Text("Success"),
                                              description: Text(
                                                  value['message'].toString()),
                                            ).show(context);
                                          }).onError((error, stackTrace) {
                                            log(stackTrace.toString());
                                            ElegantNotification.error(
                                              title: const Text("Error"),
                                              description: const Text(
                                                  "Error Occured, Please try again"),
                                            ).show(context);
                                          });
                                        },
                                        title: controller
                                            .searchProducts[index].name
                                            .toString(),
                                        price: controller
                                            .searchProducts[index].saleprice
                                            .toString(),
                                      ),
                                    ),
                                  ),
                                );
                              });
                            });
                      }
                    })),
              ),
              const SizedBox(
                width: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
