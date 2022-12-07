import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../global/orderhistorywidget.dart';
import '../controllers/activeorders_controller.dart';

class ActiveordersView extends GetView<ActiveordersController> {
  const ActiveordersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF1F1F1),
      body: SafeArea(
        child: ListView.separated(
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 15,
              );
            },
            itemCount: 13,
            itemBuilder: (context, index) {
              if (index == 0) {
                return const SizedBox(
                  height: 1,
                );
              }
              return Container(
                height: 124,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: OrderHistoryWidget(
                  orderId: "16699577861	",
                  paymentStatus: "Paid",
                  scheduledOn: "30-12-2022 06:00 Am",
                  pending: false,
                ),
              );
            }),
      ),
    );
  }
}
