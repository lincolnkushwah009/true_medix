import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:true_medix/app/utilities/appcolors.dart';

class CustomDialog {
  Future<dynamic> customDialog(
    BuildContext context, {
    String? title,
    double? height,
    String? orderTitle,
    String? subTitle,
    String? btnTitle,
    String? orderId,
    VoidCallback? onTap,
    String? image,
    bool? isError,
  }) {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return Stack(
            children: [
              Container(
                color: Colors.black.withOpacity(0.5),
              ),
              Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  height: height ?? MediaQuery.of(context).size.height * 0.6,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width * 0.7,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              image: const DecorationImage(
                                  image: AssetImage("assets/brand.png"))),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: isError!
                              ? Image.asset(image!)
                              : SvgPicture.asset(
                                  image!,
                                  width: 200,
                                  height: 130,
                                ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          title.toString(),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: isError ? Colors.red : Colors.green,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          subTitle.toString(),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              orderTitle.toString(),
                              style: GoogleFonts.poppins(
                                decoration: TextDecoration.underline,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: kBtnColor,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              orderId.toString(),
                              style: GoogleFonts.poppins(
                                decoration: TextDecoration.underline,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: kBtnColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: onTap,
                          child: Container(
                            width: 100,
                            height: 40,
                            decoration: BoxDecoration(
                              color: isError ? Colors.red : Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                                child: Text(
                              btnTitle.toString(),
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
