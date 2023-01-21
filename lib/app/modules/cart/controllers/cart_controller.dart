// ignore_for_file: prefer_final_fields

import 'dart:developer';

import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:true_medix/app/services/apiServives/apiservices.dart';

class CartController extends GetxController {
  ApiServices apiServices = ApiServices();

  RxList _cartProducts = [].obs;

  LocationData? locationData;

  RxBool isLocationPermissionGranted = false.obs;

  RxBool isLocationDataActive = false.obs;

  RxBool _cartProductsLoading = false.obs;

  RxBool isCaliculationDone = false.obs;

  //Cart Calculation Variables

  RxDouble subTotal = 0.0.obs;
  RxDouble taxAndFee = 0.0.obs;
  RxString delivery = "".obs;
  RxDouble total = 0.0.obs;

  set cartProductsLoading(RxBool loadingVal) {
    _cartProductsLoading = loadingVal;
    update();
  }

  RxBool get cartProductsLoading => _cartProductsLoading;

  RxList get cartProducts {
    return _cartProducts;
  }

  //ApiCall for initGetCartProducts
  Future<void> initGetCartProducts() async {
    cartProductsLoading = true.obs;
    _cartProducts.value = await apiServices.getCartProducts();
    cartProducts;
    update();
    cartProductsLoading = false.obs;
  }

  //Get Geo Permission
  Future<void> getLocationPermission() async {
    isLocationPermissionGranted.value = await Permission.location.isGranted;
    if (isLocationPermissionGranted.value) {
      log(isLocationPermissionGranted.value.toString());
      getLocationData();
    } else {
      Permission.location.request().then((value) {
        isLocationPermissionGranted.value = value.isGranted;
        getLocationData();
      }).onError((error, stackTrace) {
        isLocationPermissionGranted.value = false;
      });
      locationData = await Location.instance.getLocation();
      log(isLocationPermissionGranted.value.toString());
    }
  }

  // Get Location Data
  Future<void> getLocationData() async {
    Location.instance.getLocation().then((value) {
      isLocationDataActive.value = true;
      locationData = value;
      log(value.longitude.toString());
      log(value.latitude.toString());
      log(isLocationDataActive.value.toString());
    }).onError((error, stackTrace) {
      ("Error Occured Location Data");
      isLocationDataActive.value = false;
    });
  }

  //Calculate Total Price of Cart
  Future<double> getTotalPriceOfCart(List<dynamic> cartList) async {
    subTotal = 0.0.obs;
    taxAndFee = 0.0.obs;
    delivery = "".obs;
    total = 0.0.obs;
    for (var element in cartList) {
      subTotal.value =
          subTotal.value + double.parse(element.saleprice.toString());
      log(subTotal.toString());
    }
    if (subTotal < 500 && subTotal > 0.0) {
      taxAndFee.value = taxAndFee.value + 150;
    }
    delivery.value = "Free";
    total.value = subTotal.value + taxAndFee.value;
    isCaliculationDone.value = true;
    return total.value;
  }

  @override
  void onInit() {
    super.onInit();
    ("CartController Init...");
    subTotal = 0.0.obs;
    taxAndFee = 0.0.obs;
    delivery = "".obs;
    total = 0.0.obs;
    update();
    initGetCartProducts();
    getTotalPriceOfCart(cartProducts);
  }

  // @override
  // void onClose() {
  //   ("CartController OnClose...");
  //   dispose();
  //   super.onClose();
  // }
}
