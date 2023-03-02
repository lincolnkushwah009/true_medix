// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:true_medix/app/modules/home/controllers/home_controller.dart';
import 'package:true_medix/app/utilities/appcolors.dart';

import '../utilities/appstyles.dart';

class HomeTestWidget extends StatelessWidget {
  HomeTestWidget({
    required this.icon,
    required this.title,
    required this.isActive,
    Key? key,
  }) : super(key: key);

  String icon;
  String title;
  bool isActive;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Container(
        width: isActive ? 50 : 57,
        height: isActive ? 50 : 57,
        decoration: BoxDecoration(
          color: isActive ? Colors.black38 : Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              color: isActive ? Colors.white : const Color(0XFF75DBEB),
              width: 29,
              height: 21,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: iconTextStyle.copyWith(
                color: isActive ? Colors.white : const Color(0XFF75DBEB),
              ),
            ),
          ],
        ),
      );
    });
  }
}
