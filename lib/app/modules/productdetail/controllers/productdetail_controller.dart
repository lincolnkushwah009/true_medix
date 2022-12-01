import 'package:get/get.dart';

class ProductdetailController extends GetxController {
  @override
  RxInt quantity = 0.obs;

  void onInit() {
    // TODO: implement onInit
    RxInt quantity = 0.obs;
  }

  void addQuantity() {
    quantity++;
  }

  void removeQuantity() {
    if (quantity <= 0) {
      quantity;
    } else {
      quantity--;
    }
  }
}
