// ignore_for_file: unnecessary_getters_setters, prefer_final_fields, deprecated_member_use

import 'dart:developer';

import 'package:get/get.dart';
import 'package:true_medix/app/global/hometestwidget.dart';
import 'package:true_medix/app/modules/home/models/bannermodel.dart';
import 'package:true_medix/app/modules/productdetail/models/productmodel.dart';
import 'package:true_medix/app/services/apiServives/apiservices.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  //ApiService Instance
  ApiServices apiServices = ApiServices();

  List<HomeTestWidget> homeTestList = [
    HomeTestWidget(
      icon: "assets/Images/covid.svg",
      title: "Covid",
    ),
    HomeTestWidget(
      icon: "assets/Images/Diabetic.svg",
      title: "Diabetic",
    ),
    HomeTestWidget(
      icon: "assets/Images/Diet.svg",
      title: "Diet",
    ),
    HomeTestWidget(
      icon: "assets/Images/EyeCare.svg",
      title: "EyeCare",
    ),
    HomeTestWidget(
      icon: "assets/Images/Immunity.svg",
      title: "Immunity",
    ),
    HomeTestWidget(
      icon: "assets/Images/Mom&Kids.svg",
      title: "Mom&Kids",
    ),
    HomeTestWidget(icon: "assets/Images/SkinCare.svg", title: "SkinCare"),
  ];

  //Reactive Data Variables for Banner
  List<BannerModel> _bannerList = [
    BannerModel(
        id: "1",
        image:
            "https://cdn.ps.emap.com/wp-content/uploads/sites/3/2020/03/coronavirus-test-1024x683.jpg",
        title: ""),
    BannerModel(
        id: "1",
        image:
            "https://cdn.ps.emap.com/wp-content/uploads/sites/3/2020/03/coronavirus-test-1024x683.jpg",
        title: ""),
    BannerModel(
        id: "1",
        image:
            "https://cdn.ps.emap.com/wp-content/uploads/sites/3/2020/03/coronavirus-test-1024x683.jpg",
        title: ""),
    BannerModel(
        id: "1",
        image:
            "https://cdn.ps.emap.com/wp-content/uploads/sites/3/2020/03/coronavirus-test-1024x683.jpg",
        title: ""),
    BannerModel(
        id: "1",
        image:
            "https://cdn.ps.emap.com/wp-content/uploads/sites/3/2020/03/coronavirus-test-1024x683.jpg",
        title: ""),
    BannerModel(
        id: "1",
        image:
            "https://cdn.ps.emap.com/wp-content/uploads/sites/3/2020/03/coronavirus-test-1024x683.jpg",
        title: ""),
    BannerModel(
        id: "1",
        image:
            "https://cdn.ps.emap.com/wp-content/uploads/sites/3/2020/03/coronavirus-test-1024x683.jpg",
        title: ""),
  ];

  List<ProductModel> _productsList = [];

  //Loading for Banner
  RxBool _bannerLoading = false.obs;

  //Loading for Products
  RxBool _productsLoading = false.obs;

  //Setter and Getter for Banners
  set bannerLoading(RxBool loadingVal) {
    _bannerLoading.value = loadingVal.value;
    update();
  }

  RxBool get bannerLoading => _bannerLoading;

  List<BannerModel> get bannerList => _bannerList;

  //Setters and Getter for ProductList

  set productsLoading(RxBool loadingVal) {
    _productsLoading.value = loadingVal.value;
    update();
  }

  RxBool get productsLoading => _productsLoading;

  List<ProductModel> get productsList => _productsList;

  //ApiCall for Banners from HomeController to ApiServices
  Future<void> initBannerCall() async {
    log("Loading Banner Setter Called 1....");
    bannerLoading = true.obs;
    log("Banner API in Progress");
    await apiServices.getRunningBanners();
    bannerLoading = false.obs;
    log("Loading Banner Setter Called 2....");
  }

  //ApiCall for Products from HomeController to ApiServices
  Future<void> initProductsCall() async {
    productsLoading = true.obs;
    log("Loading Product Setter Called 1....");
    log("Products API in Progress");
    _productsList = await apiServices.getProducts();
    productsLoading = false.obs;
    log("Loading Product Setter Called 2....");
  }

  Future<void> launchCustomerCarePhone() async {
    log("launchCustomerCarePhone init...");
    const url = "tel:9055448696";
    if (await canLaunch(url)) {
      log("launchCustomerCarePhone canLaunch...");
      await launch(url);
    } else {
      log("launchCustomerCarePhone error...");

      throw 'Could not launch $url';
    }
  }

  @override
  void onInit() {
    log("HomeController Init...");
    super.onInit();
    initBannerCall();
    initProductsCall();
  }
}
