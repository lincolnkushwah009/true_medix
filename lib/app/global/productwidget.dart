// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:true_medix/app/utilities/appcolors.dart';
import '../utilities/appstyles.dart';

class ProductWidget extends StatelessWidget {
  ProductWidget({
    required this.onTap,
    required this.price,
    required this.rating,
    required this.title,
    Key? key,
  }) : super(key: key);

  VoidCallback onTap;
  String rating;
  String title;
  String price;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 13),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              child: Text(
                title,
                style: testTextStyle,
              ),
            ),
            const SizedBox(
              height: 05,
            ),
            RatingBar.builder(
              initialRating: 5,
              minRating: 1,
              direction: Axis.horizontal,
              ignoreGestures: true,
              allowHalfRating: false,
              itemCount: 5,
              itemBuilder: (context, _) => Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: SvgPicture.asset(
                  "assets/rating.svg",
                  width: 20,
                  height: 20,
                ),
              ),
              onRatingUpdate: (rating) {
                log(rating.toString());
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "$rating Ratings",
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Color(0XFF242424)),
            ),
            const SizedBox(
              height: 26,
            ),
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Divider(
                height: 2,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                children: [
                  Text(
                    "Rs. " "$price",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: const Color(0XFF242424)),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: onTap,
                    child: Container(
                      width: 117,
                      height: 33,
                      decoration: BoxDecoration(
                        color: kBtnColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          "ADD",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 27,
            ),
          ],
        ),
      ),
    );
  }
}
