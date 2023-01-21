import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/debitcard_controller.dart';

class DebitcardView extends GetView<DebitcardController> {
  const DebitcardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DebitcardView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'DebitcardView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
