import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/otpscreen_controller.dart';

class OtpscreenView extends GetView<OtpscreenController> {
  const OtpscreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OtpscreenView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'OtpscreenView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
