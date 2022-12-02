// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utilities/appcolors.dart';
import '../utilities/appstyles.dart';

class HomeTestWidget extends StatelessWidget {
  HomeTestWidget({
    required this.icon,
    required this.title,
    Key? key,
  }) : super(key: key);

  String icon;
  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            color: kIconColor,
            width: 29,
            height: 21,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            title,
            style: iconTextStyle,
          ),
        ],
      ),
    );
  }
}
