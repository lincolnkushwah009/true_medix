// ignore_for_file: unnecessary_getters_setters, prefer_final_fields, deprecated_member_use

import 'dart:developer';

import 'package:get/get.dart';
import 'package:true_medix/app/global/hometestwidget.dart';
import 'package:true_medix/app/modules/home/models/homeproductmodel.dart';
import 'package:true_medix/app/modules/productdetail/models/productmodel.dart';
import 'package:true_medix/app/services/apiServives/apiservices.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  //ApiService Instance
  ApiServices apiServices = ApiServices();

  List<HomeTestWidget> homeTestList = [
    HomeTestWidget(
      icon: "assets/Images/popular.svg",
      title: "Popular Package",
      isActive: false,
    ),
    HomeTestWidget(
      icon: "assets/Images/covidnew.svg",
      title: "Covid",
      isActive: false,
    ),
    HomeTestWidget(
      icon: "assets/Images/fewernew.svg",
      isActive: false,
      title: "Fever",
    ),
    HomeTestWidget(
      icon: "assets/Images/bloodnew.svg",
      isActive: false,
      title: "Blood",
    ),
    HomeTestWidget(
      icon: "assets/Images/urinenew.svg",
      isActive: false,
      title: "Urine Test",
    ),
    HomeTestWidget(
      icon: "assets/Images/kidneynew.svg",
      isActive: false,
      title: "Kidney",
    ),
    HomeTestWidget(
      icon: "assets/Images/allergy.svg",
      title: "Allergy",
      isActive: false,
    ),
  ];

  HomeProductModel? _productsList;

  //Loading for Products
  RxBool _productsLoading = false.obs;

  //Setters and Getter for ProductList
  set productsLoading(RxBool loadingVal) {
    _productsLoading.value = loadingVal.value;
    update();
  }

  RxBool get productsLoading => _productsLoading;

  HomeProductModel get productsList => _productsList!;

  //ApiCall for Banners from HomeController to ApiServices
  Future<void> initBannerCall() async {
    var data = await apiServices.getRunningBanners();
    log(data.toString());
  }

  //ApiCall for Products from HomeController to ApiServices
  Future<HomeProductModel> initProductsCall(
      {String page = "1", String query = "arunodaya"}) async {
    productsLoading = true.obs;
    _productsList = await apiServices.getProducts(page: page, query: query);
    productsLoading = false.obs;
    return _productsList!;
  }

  Future<void> launchCustomerCarePhone(String payload) async {
    if (await canLaunch(payload)) {
      Future.delayed(const Duration(seconds: 2), () {});
      await launch(payload);
    } else {
      throw 'Could not launch $payload';
    }
  }

  @override
  void onInit() {
    super.onInit();
    initBannerCall();
    initProductsCall();
  }
}
