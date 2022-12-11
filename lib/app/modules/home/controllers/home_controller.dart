import 'dart:developer';

import 'package:get/get.dart';
import 'package:true_medix/app/services/apiServives/apiservices.dart';

class HomeController extends GetxController {
  //ApiService Instance
  ApiServices apiServices = ApiServices();

  //Reactive Data Variables for Banner
  RxMap? bannerResponse = {}.obs;
  RxList? bannerResponseList = [].obs;

  //Reactive Data Variables for Banner
  RxMap? productsResponse = {}.obs;
  RxList? productsResponseList = [].obs;

  //Loading for Banner
  RxBool isBannerLoading = true.obs;

  //Loading for Products
  RxBool isProductsLoading = true.obs;

  //ApiCall for Banners from HomeController to ApiServices
  Future<void> initBannerCall() async {
    log("Banner API in Progress");
    bannerResponse!.value = await apiServices.getRunningBanners();
    bannerResponseList!.value = bannerResponse!['data'] as List<dynamic>;
    isBannerLoading.value = false;
  }

  //ApiCall for Products from HomeController to ApiServices
  Future<void> initProductsCall() async {
    log("Products API in Progress");
    productsResponse!.value = await apiServices.getProducts();
    productsResponseList!.value = productsResponse!['records'] as List<dynamic>;
    isProductsLoading.value = false;
  }

  @override
  void onInit() {
    log("HomeController Init...");
    initBannerCall();
    super.onInit();
  }
}
