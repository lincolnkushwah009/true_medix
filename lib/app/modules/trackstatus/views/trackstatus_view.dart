import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/trackstatus_controller.dart';

class TrackstatusView extends GetView<TrackstatusController> {
  const TrackstatusView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TrackstatusView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'TrackstatusView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
