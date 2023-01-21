import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/creditcard_controller.dart';

class CreditcardView extends GetView<CreditcardController> {
  const CreditcardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CreditcardView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'CreditcardView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
