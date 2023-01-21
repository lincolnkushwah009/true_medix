import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pamentcards_controller.dart';

class PamentcardsView extends GetView<PamentcardsController> {
  const PamentcardsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PamentcardsView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'PamentcardsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
