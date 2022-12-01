import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/productdetail_controller.dart';

class ProductdetailView extends GetView<ProductdetailController> {
  const ProductdetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProductdetailView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ProductdetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
