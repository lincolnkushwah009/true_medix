import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:true_medix/app/utilities/appcolors.dart';

import '../../../utilities/appstyles.dart';
import '../controllers/tests_controller.dart';

class TestsView extends GetView<TestsController> {
  const TestsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          'Tests',
          style: iconTextStyle.copyWith(fontSize: 22),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        centerTitle: false,
      ),
      body: const Center(
        child: Text(
          'TestsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
