// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utilities/appstyles.dart';

class OrderHistoryWidget extends StatelessWidget {
  OrderHistoryWidget({
    required this.orderId,
    required this.paymentStatus,
    required this.pending,
    required this.scheduledOn,
    Key? key,
  }) : super(key: key);

  String orderId;
  String scheduledOn;
  String paymentStatus;
  bool pending;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 14, bottom: 14, left: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Order ID",
                style: orderHistoryTextStyle,
              ),
              const SizedBox(
                height: 14,
              ),
              Text(
                "Scheduled On	",
                style: orderHistoryTextStyle,
              ),
              const SizedBox(
                height: 14,
              ),
              Text(
                "Payment Status",
                style: orderHistoryTextStyle,
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 64,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 14, bottom: 14, right: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "#$orderId",
                style: orderHistoryTextStyle,
              ),
              const SizedBox(
                height: 14,
              ),
              Text(
                scheduledOn,
                style: orderHistoryTextStyle,
              ),
              const SizedBox(
                height: 14,
              ),
              Row(
                children: [
                  pending == true
                      ? SvgPicture.asset("assets/Pending.svg")
                      : SvgPicture.asset("assets/Paid.svg"),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    paymentStatus,
                    style: orderHistoryTextStyle,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}