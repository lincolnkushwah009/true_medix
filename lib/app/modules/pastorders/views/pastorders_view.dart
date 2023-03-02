import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:true_medix/app/modules/pamentsummary/views/pamentsummary_view.dart';

import '../../../global/orderhistorywidget.dart';
import '../../activeorders/model/ordermodel.dart';
import '../controllers/pastorders_controller.dart';

class PastordersView extends StatefulWidget {
  const PastordersView({Key? key}) : super(key: key);

  @override
  State<PastordersView> createState() => _PastordersViewState();
}

class _PastordersViewState extends State<PastordersView> {
  PastordersController? controller;

  @override
  void initState() {
    controller = Get.put<PastordersController>(PastordersController());
    fetchStatusList();
    super.initState();
  }

  void fetchStatusList() async {
    controller!.statusListData.value =
        await controller!.apiServices.getStatusList();
    log(controller!.statusListData.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GetBuilder<PastordersController>(builder: (controller) {
          return FutureBuilder(
              future: controller.apiServices.pastrderService(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.withOpacity(0.25),
                    highlightColor: Colors.white.withOpacity(0.6),
                    child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 15,
                          );
                        },
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, top: 10),
                            child: InkWell(
                              onTap: () {},
                              child: Card(
                                child: Container(
                                  height: 160,
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey, blurRadius: 2)
                                    ],
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: OrderHistoryWidget(
                                    orderId: "16699577861	",
                                    paymentStatus: "Paid",
                                    scheduledOn: "30-12-2022 06:00 Am",
                                    pending: false,
                                    bookingStatus: "Phlebo Assigned",
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  );
                }
                if (snapshot.data == null) {
                  return Center(
                    child: Image.asset("assets/oops.png"),
                  );
                }
                if (snapshot.data!.isEmpty) {
                  return Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Image.asset("assets/noitem.png"),
                    ),
                  );
                }
                return ListView.separated(
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 15,
                      );
                    },
                    itemCount: snapshot.data!.reversed.length,
                    itemBuilder: (context, index) {
                      List<OrderModel> reversedList =
                          List.from(snapshot.data!.reversed);
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 10),
                        child: InkWell(
                          splashColor: Colors.black,
                          highlightColor: Colors.green,
                          onTap: () {
                            Get.to(
                              () => PamentsummaryView(
                                orderId:
                                    reversedList[index].orderNumber.toString(),
                                pheleboId: reversedList[index].id.toString(),
                              ),
                            );
                          },
                          child: Card(
                            child: Container(
                              height: 190,
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(color: Colors.grey, blurRadius: 2)
                                ],
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: OrderHistoryWidget(
                                  orderId: reversedList[index]
                                      .orderNumber
                                      .toString(),
                                  paymentStatus: double.parse(reversedList[index].total!.toString()) ==
                                          double.parse(reversedList[index]
                                              .paidAmount!
                                              .toString())
                                      ? "Paid"
                                      : (double.parse(reversedList[index].total!.toString()) ==
                                              double.parse(reversedList[index]
                                                  .dueAmount!
                                                  .toString()))
                                          ? "Not Paid"
                                          : (double.parse(reversedList[index].dueAmount!) <
                                                      double.parse(
                                                          reversedList[index]
                                                              .total!) &&
                                                  double.parse(reversedList[index].paidAmount!) >
                                                      0)
                                              ? "Partially Paid"
                                              : "Not Updated Yet",
                                  scheduledOn: reversedList[index]
                                      .scheduledOn
                                      .toString(),
                                  pending: double.parse(
                                              reversedList[index].total!.toString()) ==
                                          double.parse(reversedList[index].paidAmount!.toString())
                                      ? false
                                      : true,
                                  bookingStatus: controller.statusListData[reversedList[index].status] ?? ""),
                            ),
                          ),
                        ),
                      );
                    });
              });
        }),
      ),
    );
  }
}
