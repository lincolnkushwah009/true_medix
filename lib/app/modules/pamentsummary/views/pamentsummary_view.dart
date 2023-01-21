// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:true_medix/app/modules/activeorders/controllers/activeorders_controller.dart';

import '../../../utilities/appcolors.dart';
import '../../../utilities/appstyles.dart';
import '../controllers/pamentsummary_controller.dart';

class PamentsummaryView extends StatefulWidget {
  PamentsummaryView({required this.orderId, Key? key}) : super(key: key);
  String orderId;

  @override
  State<PamentsummaryView> createState() => _PamentsummaryViewState();
}

class _PamentsummaryViewState extends State<PamentsummaryView> {
  PamentsummaryController? controller;
  ActiveordersController? activeordersController;
  Map<dynamic, dynamic> statusData = {};

  @override
  void initState() {
    controller = Get.put<PamentsummaryController>(PamentsummaryController());
    activeordersController =
        Get.put<ActiveordersController>(ActiveordersController());
    getStatusList();
    super.initState();
  }

  void getStatusList() async {
    statusData = await activeordersController!.initStatusList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          "Summary",
          style: iconTextStyle.copyWith(
              fontSize: 24,
              color: const Color(0XFF242424),
              fontWeight: FontWeight.w400),
        ),
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SvgPicture.asset("assets/back.svg"),
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: controller!.apiServices.orderDetailsService(widget.orderId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.withOpacity(0.25),
                  highlightColor: Colors.white.withOpacity(0.6),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 17.0, right: 17, top: 34),
                    child: ListView(
                      children: [
                        Container(
                          height: 87,
                          decoration: BoxDecoration(
                            color: const Color(0XFFBBEFFD),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Center(
                            child: Text(
                              "Phlebo Assigned",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: const Color(0XFF464646),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 34,
                        ),
                        Text(
                          "Expert Summary",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: const Color(0XFF464646),
                          ),
                        ),
                        const SizedBox(
                          height: 21,
                        ),
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                            color: const Color(0XFFBBEFFD),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 37.0, top: 18, bottom: 18, right: 37),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset("assets/expertperson.svg"),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      "Ramesh Kumar",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: const Color(0XFF242424),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 13,
                                ),
                                const Divider(
                                  height: 2,
                                  thickness: 1,
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  height: 13,
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset("assets/star.svg"),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      "4.5 Rating",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: const Color(0XFF242424),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 13,
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset("assets/jobdone.svg"),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      "1,245 Jobs Completed",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: const Color(0XFF242424),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 26,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 80.0, right: 80),
                          child: Container(
                            height: 46,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0XFF457B9D),
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 20.0),
                                  child: Icon(
                                    Icons.phone,
                                    size: 30,
                                    color: Color(0XFF457B9D),
                                  ),
                                ),
                                const SizedBox(
                                  width: 18,
                                ),
                                Text(
                                  "Call Phlebo",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: const Color(0XFF464646),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 34,
                        ),
                        Text(
                          "Customer Summary",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: const Color(0XFF464646),
                          ),
                        ),
                        const SizedBox(
                          height: 21,
                        ),
                        Obx(() => Container(
                              height: 110,
                              decoration: BoxDecoration(
                                color:
                                    controller!.paymentStatus.value == "SUCESS"
                                        ? const Color(0XFFE2FEF0)
                                        : (controller!.paymentStatus.value ==
                                                "ERROR")
                                            ? const Color(0XFFFFC5CA)
                                            : const Color(0XFFFFF0A4),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(controller!
                                                .paymentStatus.value ==
                                            "SUCESS"
                                        ? "assets/success.svg"
                                        : ((controller!.paymentStatus.value ==
                                                "ERROR")
                                            ? "assets/error.svg"
                                            : "assets/loading.svg")),
                                    const SizedBox(
                                      width: 26,
                                    ),
                                    Text(
                                      controller!.paymentStatus.value ==
                                              "SUCESS"
                                          ? "Payment Successful"
                                          : (controller!.paymentStatus.value ==
                                                  "ERROR")
                                              ? "Payment Unsuccessful"
                                              : "Payment In Progress",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                        color: const Color(0XFF464646),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        const SizedBox(
                          height: 34,
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 17.0, left: 15, right: 15),
                            child: Container(
                              height: 209,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Total Price:",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: const Color(0XFF464646),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "Taxes and GST:",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: const Color(0XFF464646),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "₹ 1,299",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: const Color(0XFF464646),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "₹ 58",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: const Color(0XFF464646),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 18,
                                  ),
                                  const Divider(
                                    color: Colors.grey,
                                    height: 2,
                                    thickness: 1,
                                  ),
                                  const SizedBox(
                                    height: 18,
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Total:",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: const Color(0XFF464646),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "₹ 1599",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: const Color(0XFF464646),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 18,
                                  ),
                                  controller!.paymentStatus.value == 'SUCESS'
                                      ? Row(
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  "Payment Status:",
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                    color:
                                                        const Color(0XFF464646),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  "Paid",
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                    color:
                                                        const Color(0XFF464646),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      : (controller!.paymentStatus.value ==
                                              'ERROR')
                                          ? GestureDetector(
                                              onTap: () {
                                                // Get.to(
                                                //   () => const PamentmethodView(),
                                                // );
                                              },
                                              child: Container(
                                                height: 40,
                                                width: 155,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: kBtnColor,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Try Again',
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                height: 40,
                                                width: 155,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color:
                                                      const Color(0XFFD9D9D9),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Pay Now',
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 18,
                                                      color: const Color(
                                                          0XFF242424),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 34,
                        ),
                        Text(
                          "Booking Summary",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: const Color(0XFF464646),
                          ),
                        ),
                        const SizedBox(
                          height: 21,
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 17.0, left: 15, right: 15),
                            child: Container(
                              height: 166,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Test",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: const Color(0XFF464646),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 43,
                                          ),
                                          Text(
                                            "Preferred Date:",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: const Color(0XFF464646),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "Preferred Time:",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: const Color(0XFF464646),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Arunodaya Basic\nHealth Checkup",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: const Color(0XFF464646),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "29 Nov, 2022",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: const Color(0XFF464646),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "11:00 AM - 12:00PM",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: const Color(0XFF464646),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 34,
                        ),
                        Text(
                          "Customer Summary",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: const Color(0XFF464646),
                          ),
                        ),
                        const SizedBox(
                          height: 21,
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 17.0, left: 15, right: 15),
                            child: Container(
                              height: 190,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Name:",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: const Color(0XFF464646),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "Mobile:",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: const Color(0XFF464646),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "Address:",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: const Color(0XFF464646),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Harish Kumar",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: const Color(0XFF464646),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "9783452617",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: const Color(0XFF464646),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "#56, 4th Cross,\n Hsr Layout,\nBangalore",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: const Color(0XFF464646),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              if (snapshot.data == null) {
                return const Center(
                  child: Text("No Details Found"),
                );
              }
              return Padding(
                padding: const EdgeInsets.only(left: 17.0, right: 17, top: 34),
                child: ListView(
                  children: [
                    Container(
                      height: 87,
                      decoration: BoxDecoration(
                        color: const Color(0XFFBBEFFD),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          statusData[snapshot.data!.order.status].toString(),
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: const Color(0XFF464646),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 34,
                    ),
                    Text(
                      "Expert Summary",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: const Color(0XFF464646),
                      ),
                    ),
                    const SizedBox(
                      height: 21,
                    ),
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: const Color(0XFFBBEFFD),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 37.0, top: 18, bottom: 18, right: 37),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset("assets/expertperson.svg"),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "Ramesh Kumar",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: const Color(0XFF242424),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 13,
                            ),
                            const Divider(
                              height: 2,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              height: 13,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset("assets/star.svg"),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "4.5 Rating",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: const Color(0XFF242424),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 13,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset("assets/jobdone.svg"),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "1,245 Jobs Completed",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: const Color(0XFF242424),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 80.0, right: 80),
                      child: Container(
                        height: 46,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0XFF457B9D),
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 20.0),
                              child: Icon(
                                Icons.phone,
                                size: 30,
                                color: Color(0XFF457B9D),
                              ),
                            ),
                            const SizedBox(
                              width: 18,
                            ),
                            Text(
                              "Call Phlebo",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: const Color(0XFF464646),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 34,
                    ),
                    Text(
                      "Payment Summary",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: const Color(0XFF464646),
                      ),
                    ),
                    const SizedBox(
                      height: 21,
                    ),
                    // ignore: unnecessary_null_comparison
                    snapshot.data!.payments.isEmpty
                        ? Container(
                            height: 110,
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Center(
                              child: Text(
                                "Pay on Visit",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: const Color(0XFF464646),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            height: 110,
                            decoration: BoxDecoration(
                              color: snapshot.data!.payments[0].payStatus == "1"
                                  ? const Color(0XFFE2FEF0)
                                  : (snapshot.data!.payments[0].payStatus ==
                                          "2")
                                      ? const Color(0XFFFFC5CA)
                                      : const Color(0XFFFFF0A4),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      snapshot.data!.payments[0].payStatus ==
                                              "1"
                                          ? "assets/success.svg"
                                          : ((snapshot.data!.payments[0]
                                                      .payStatus ==
                                                  "2")
                                              ? "assets/error.svg"
                                              : "assets/loading.svg")),
                                  const SizedBox(
                                    width: 26,
                                  ),
                                  Text(
                                    snapshot.data!.payments[0].payStatus == "1"
                                        ? "Payment Successful"
                                        : (snapshot.data!.payments[0]
                                                    .payStatus ==
                                                "2")
                                            ? "Payment Unsuccessful"
                                            : "Payment In Progress",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: const Color(0XFF464646),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 34,
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 17.0, left: 15, right: 15),
                        child: Container(
                          height: 209,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Total Price:",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: const Color(0XFF464646),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "Taxes and GST:",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: const Color(0XFF464646),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "₹ ${snapshot.data!.order.total.toString()}",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: const Color(0XFF464646),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "₹ ${snapshot.data!.order.tax.toString()}",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: const Color(0XFF464646),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              const Divider(
                                color: Colors.grey,
                                height: 2,
                                thickness: 1,
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Total:",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: const Color(0XFF464646),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "₹ ${(double.parse(snapshot.data!.order.total) + double.parse(snapshot.data!.order.tax)).toString()}",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: const Color(0XFF464646),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              snapshot.data!.payments.isNotEmpty
                                  ? Column(
                                      children: [
                                        snapshot.data!.payments[0].payStatus ==
                                                '1'
                                            ? Row(
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text(
                                                        "Payment Status:",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16,
                                                          color: const Color(
                                                              0XFF464646),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const Spacer(),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text(
                                                        "Paid",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16,
                                                          color: const Color(
                                                              0XFF464646),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            : (snapshot.data!.payments[0]
                                                        .payStatus ==
                                                    '2')
                                                ? GestureDetector(
                                                    onTap: () {
                                                      // Get.to(
                                                      //   () => const PamentmethodView(),
                                                      // );
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      width: 155,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: kBtnColor,
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'Try Again',
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 16,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : GestureDetector(
                                                    onTap: () {},
                                                    child: Container(
                                                      height: 40,
                                                      width: 155,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: const Color(
                                                            0XFFD9D9D9),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'Pay Now',
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 18,
                                                            color: const Color(
                                                                0XFF242424),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                      ],
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 34,
                    ),
                    Text(
                      "Booking Summary",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: const Color(0XFF464646),
                      ),
                    ),
                    const SizedBox(
                      height: 21,
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 17.0, left: 15, right: 15),
                        child: Container(
                          height: 350,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Preferred Date:",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: const Color(0XFF464646),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "Preferred Time:",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: const Color(0XFF464646),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        DateFormat.yMMMMd().format(
                                            DateTime.parse(snapshot
                                                .data!.order.scheduledOn
                                                .toString())),
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: const Color(0XFF464646),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "${int.parse(DateFormat.jms().format(DateTime.parse(snapshot.data!.order.scheduledOn.toString())).toString().split(':')[0].toString())} : 00 ${DateFormat.jms().format(DateTime.parse(snapshot.data!.order.scheduledOn.toString())).toString().split(' ')[1]} - ${int.parse(DateFormat.jms().format(DateTime.parse(snapshot.data!.order.scheduledOn.toString())).toString().split(':')[0].toString()) + 1} : 00 ${DateFormat.jms().format(DateTime.parse(snapshot.data!.order.scheduledOn.toString())).toString().split(' ')[1]}",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: const Color(0XFF464646),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Test:",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: const Color(0XFF464646),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    height: 200,
                                    width: double.infinity,
                                    child: ListView.builder(
                                        itemCount: snapshot
                                            .data!.order.contents.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: Container(
                                              height: 70,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: kPrimaryColor,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Center(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      snapshot
                                                          .data!
                                                          .order
                                                          .contents[index]
                                                          .productName
                                                          .toString(),
                                                      textAlign: TextAlign.left,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16,
                                                        color: const Color(
                                                            0XFF464646),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 34,
                    ),
                    Text(
                      "Customer Summary",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: const Color(0XFF464646),
                      ),
                    ),
                    const SizedBox(
                      height: 21,
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 17.0, left: 15, right: 15),
                        child: Container(
                          height: 320,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Name:",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: const Color(0XFF464646),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "Mobile:",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: const Color(0XFF464646),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        snapshot.data!.order.name.toString(),
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: const Color(0XFF464646),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        snapshot.data!.order.mobileNo
                                            .toString(),
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: const Color(0XFF464646),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "Address:",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: const Color(0XFF464646),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      height: 130,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: kPrimaryColor,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Center(
                                          child: Text(
                                            snapshot.data!.order.googleMap
                                                .toString(),
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: const Color(0XFF464646),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
