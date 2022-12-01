import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/orderhistory_controller.dart';

class OrderhistoryView extends GetView<OrderhistoryController> {
  const OrderhistoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OrderhistoryView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'OrderhistoryView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
