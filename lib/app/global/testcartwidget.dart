// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utilities/appstyles.dart';

class TestCartWidget extends StatelessWidget {
  TestCartWidget({
    required this.price,
    required this.subTitle,
    required this.title,
    required this.onTapDeleted,
    required this.onTapDrop,
    Key? key,
  }) : super(key: key);

  VoidCallback onTapDeleted;
  VoidCallback onTapDrop;
  String title;
  String subTitle;
  String price;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            FittedBox(
              child: Text(
                title,
                style: testTextStyle.copyWith(fontSize: 16),
              ),
            ),
            const Spacer(),
            GestureDetector(
                onTap: onTapDrop, child: SvgPicture.asset("assets/drop.svg")),
          ],
        ),
        const SizedBox(
          height: 13,
        ),
        Text(
          "Includes 8 Tests",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: const Color(0XFF242424),
          ),
        ),
        const SizedBox(
          height: 13,
        ),
        Row(
          children: [
            Text(
              "Rs. $price",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: const Color(0XFF242424),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 30,
              height: 30,
              child: Center(
                child: IconButton(
                  onPressed: onTapDeleted,
                  icon: Image.asset("assets/trash.png"),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
