// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../utilities/appcolors.dart';
import '../utilities/appstyles.dart';

class ProductWidget extends StatelessWidget {
  ProductWidget({
    required this.image,
    required this.price,
    required this.title,
    Key? key,
  }) : super(key: key);

  String image;
  String title;
  String price;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 151,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0XFFedfbff),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(
                width: 45,
              ),
              const Spacer(),
              Container(
                height: 107,
                width: 102,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: kPrimaryColor,
                ),
                child: Image.asset(image),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            title,
            style: testTextStyle,
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "₹ $price",
                  style: testTextStyle,
                ),
                Container(
                  height: 25,
                  width: 50,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      "Add",
                      style: btnStyle.copyWith(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
