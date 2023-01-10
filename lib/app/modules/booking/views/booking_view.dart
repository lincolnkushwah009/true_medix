// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:true_medix/app/modules/booking/controllers/booking_controller.dart';
import 'package:true_medix/app/utilities/appcolors.dart';
import 'package:true_medix/app/utilities/appstyles.dart';

class BookingView extends StatefulWidget {
  const BookingView({Key? key}) : super(key: key);
  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  BookingController? controller;
  int radioGroupValue = 0;
  @override
  void initState() {
    controller = Get.put<BookingController>(BookingController());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          'Booking',
          style: iconTextStyle.copyWith(
              fontSize: 24,
              color: const Color(0XFF242424),
              fontWeight: FontWeight.w400),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SvgPicture.asset("assets/back.svg"),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 26.0, right: 26, top: 20),
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        FittedBox(
                          child: Text(
                            "Arunodaya Basic Health Checkup",
                            style: testTextStyle.copyWith(fontSize: 16),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: GestureDetector(
                            onTap: () {},
                            child: SvgPicture.asset("assets/drop.svg"),
                          ),
                        ),
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
                          "Rs. 99",
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
                              onPressed: () {},
                              icon: Image.asset("assets/trash.png"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 23,
                    ),
                    Text(
                      "+  Add Test",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: const Color(0XFF00B9C9),
                      ),
                    ),
                    const SizedBox(
                      height: 31,
                    ),
                    Text(
                      "Address",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: const Color(0XFF242424),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Your sample will be collected as per details",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: const Color(0XFF242424),
                      ),
                    ),
                    const SizedBox(
                      height: 21,
                    ),
                    SizedBox(
                      height: 210,
                      child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 17.0),
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color(0XFFBBEFFD),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 13.0, right: 0, bottom: 0),
                                      child: Row(
                                        children: [
                                          Text(
                                            "#627",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: const Color(0XFF242424),
                                            ),
                                          ),
                                          const Spacer(),
                                          Radio<int>(
                                              value: index,
                                              fillColor:
                                                  MaterialStateProperty.all(
                                                      Colors.black),
                                              activeColor: Colors.black,
                                              groupValue: radioGroupValue,
                                              onChanged: (val) {
                                                setState(() {
                                                  radioGroupValue = val!;
                                                });
                                              }),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 13.0, right: 13),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "HSR Layout, 2nd Sector,\nBengaluru-560068",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: const Color(0XFF242424),
                                            ),
                                          ),
                                          const Spacer(),
                                          Text(
                                            "Edit",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: const Color(0XFF00B9C9),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 23,
                    ),
                    Text(
                      "+  Add Address",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: const Color(0XFF00B9C9),
                      ),
                    ),
                    const SizedBox(
                      height: 31,
                    ),
                    Row(
                      children: [
                        Text(
                          "Slot",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: const Color(0XFF242424),
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.calendar_today_outlined,
                            size: 15,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Most of our users book morning slots",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: const Color(0XFF242424),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      height: 100,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 39,
                                width: MediaQuery.of(context).size.width * 0.42,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: kBtnColor,
                                ),
                                child: Center(
                                    child: Text(
                                  "6 Jan (Fri)",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                )),
                              ),
                              const Spacer(),
                              Container(
                                height: 39,
                                width: MediaQuery.of(context).size.width * 0.42,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey
                                          .withOpacity(0.5), //color of shadow
                                      spreadRadius: 2, //spread radius
                                      blurRadius: 5, // blur radius
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: Center(
                                    child: Text(
                                  "7 Jan (Sat)",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: const Color(0XFF242424),
                                  ),
                                )),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 39,
                                width: MediaQuery.of(context).size.width * 0.42,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey
                                          .withOpacity(0.5), //color of shadow
                                      spreadRadius: 2, //spread radius
                                      blurRadius: 5, // blur radius
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: Center(
                                    child: Text(
                                  "8 Jan (Sun)",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: const Color(0XFF242424),
                                  ),
                                )),
                              ),
                              const Spacer(),
                              Container(
                                height: 39,
                                width: MediaQuery.of(context).size.width * 0.42,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey
                                          .withOpacity(0.5), //color of shadow
                                      spreadRadius: 2, //spread radius
                                      blurRadius: 5, // blur radius
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: Center(
                                    child: Text(
                                  "10 Jan (Mon)",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: const Color(0XFF242424),
                                  ),
                                )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 31,
                    ),
                    Text(
                      "Time",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: const Color(0XFF242424),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 300,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 39,
                                width: MediaQuery.of(context).size.width * 0.42,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: Center(
                                    child: Text(
                                  "06:00AM-07:00AM",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: const Color(0XFF242424),
                                  ),
                                )),
                              ),
                              const Spacer(),
                              Container(
                                height: 39,
                                width: MediaQuery.of(context).size.width * 0.42,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: Center(
                                    child: Text(
                                  "07:00AM-08:00AM",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: const Color(0XFF242424),
                                  ),
                                )),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 39,
                                width: MediaQuery.of(context).size.width * 0.42,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: Center(
                                    child: Text(
                                  "08:00AM-09:00AM",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: const Color(0XFF242424),
                                  ),
                                )),
                              ),
                              const Spacer(),
                              Container(
                                height: 39,
                                width: MediaQuery.of(context).size.width * 0.42,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey
                                          .withOpacity(0.5), //color of shadow
                                      spreadRadius: 2, //spread radius
                                      blurRadius: 5, // blur radius
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: Center(
                                    child: Text(
                                  "09:00AM-10:00AM",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: const Color(0XFF242424),
                                  ),
                                )),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 39,
                                width: MediaQuery.of(context).size.width * 0.42,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: Center(
                                    child: Text(
                                  "08:00AM-09:00AM",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: const Color(0XFF242424),
                                  ),
                                )),
                              ),
                              const Spacer(),
                              Container(
                                height: 39,
                                width: MediaQuery.of(context).size.width * 0.42,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey
                                          .withOpacity(0.5), //color of shadow
                                      spreadRadius: 2, //spread radius
                                      blurRadius: 5, // blur radius
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: Center(
                                    child: Text(
                                  "09:00AM-10:00AM",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: const Color(0XFF242424),
                                  ),
                                )),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 39,
                                width: MediaQuery.of(context).size.width * 0.42,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: Center(
                                    child: Text(
                                  "08:00AM-09:00AM",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: const Color(0XFF242424),
                                  ),
                                )),
                              ),
                              const Spacer(),
                              Container(
                                height: 39,
                                width: MediaQuery.of(context).size.width * 0.42,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey
                                          .withOpacity(0.5), //color of shadow
                                      spreadRadius: 2, //spread radius
                                      blurRadius: 5, // blur radius
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: Center(
                                    child: Text(
                                  "09:00AM-10:00AM",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: const Color(0XFF242424),
                                  ),
                                )),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 39,
                                width: MediaQuery.of(context).size.width * 0.42,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: Center(
                                    child: Text(
                                  "08:00AM-09:00AM",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: const Color(0XFF242424),
                                  ),
                                )),
                              ),
                              const Spacer(),
                              Container(
                                height: 39,
                                width: MediaQuery.of(context).size.width * 0.42,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey
                                          .withOpacity(0.5), //color of shadow
                                      spreadRadius: 2, //spread radius
                                      blurRadius: 5, // blur radius
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: Center(
                                    child: Text(
                                  "09:00AM-10:00AM",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: const Color(0XFF242424),
                                  ),
                                )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 101,
                    ),
                    Center(
                      child: Container(
                        height: 40,
                        width: 170,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: kBtnColor,
                        ),
                        child: Center(
                            child: Text(
                          'Pay Now',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        )),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
