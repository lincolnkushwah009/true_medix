// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../utilities/appstyles.dart';

class TestCartWidget extends StatelessWidget {
  TestCartWidget({
    required this.image,
    required this.price,
    required this.subTitle,
    required this.title,
    Key? key,
  }) : super(key: key);

  String image;
  String title;
  String subTitle;
  String price;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 68,
          width: 61,
          decoration: BoxDecoration(
            color: const Color(0XFFedfbff),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(image),
          ),
        ),
        const SizedBox(
          width: 19,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 3,
            ),
            Text(
              "₹ $price",
              style: testCartTextStyle,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              title,
              style: testTextStyle,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              subTitle,
              style: testTextStyle,
            ),
            const SizedBox(
              height: 3,
            ),
          ],
        ),
        const Spacer(),
        SizedBox(
          width: 40,
          height: 40,
          child: Card(
            child: Center(
              child: IconButton(
                  onPressed: () {}, icon: Image.asset("assets/trash.png")),
            ),
          ),
        ),
      ],
    );
  }
}
