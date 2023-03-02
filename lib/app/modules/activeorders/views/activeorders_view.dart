// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:true_medix/app/modules/activeorders/model/ordermodel.dart';
import 'package:true_medix/app/modules/pamentsummary/views/pamentsummary_view.dart';

import '../../../global/orderhistorywidget.dart';
import '../controllers/activeorders_controller.dart';

class ActiveordersView extends StatefulWidget {
  const ActiveordersView({Key? key}) : super(key: key);

  @override
  State<ActiveordersView> createState() => _ActiveordersViewState();
}

class _ActiveordersViewState extends State<ActiveordersView> {
  ActiveordersController? controller;
  List<OrderModel>? data = [];
  @override
  void initState() {
    controller = Get.put<ActiveordersController>(ActiveordersController());
    controller!.initStatusList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GetBuilder<ActiveordersController>(builder: (controller) {
          return FutureBuilder(
              future: controller.apiServices.orderService(),
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
                          onTap: () {
                            Get.to(
                              () => PamentsummaryView(
                                  pheleboId:
                                      reversedList[index].phleboId.toString(),
                                  orderId: reversedList[index]
                                      .orderNumber
                                      .toString()),
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
