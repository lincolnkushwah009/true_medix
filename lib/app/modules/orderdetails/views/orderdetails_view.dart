import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/orderdetails_controller.dart';

class OrderdetailsView extends GetView<OrderdetailsController> {
  const OrderdetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OrderdetailsView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'OrderdetailsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
