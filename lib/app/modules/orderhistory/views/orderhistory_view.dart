import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:true_medix/app/modules/activeorders/views/activeorders_view.dart';
import 'package:true_medix/app/modules/pastorders/views/pastorders_view.dart';
import 'package:true_medix/app/utilities/appcolors.dart';

import '../../../utilities/appstyles.dart';
import '../controllers/orderhistory_controller.dart';

class OrderhistoryView extends GetView<OrderhistoryController> {
  const OrderhistoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          backgroundColor: kPrimaryColor,
          automaticallyImplyLeading: false,
          title: Text(
            'LOGO',
            style: iconTextStyle.copyWith(fontSize: 22),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelColor: Color(0XFF888888),
            indicatorWeight: 1,
            padding: EdgeInsets.all(8),
            labelColor: Colors.black,
            automaticIndicatorColorAdjustment: true,
            tabs: [
              Tab(
                  child: Text(
                'Active Orders',
                style: TextStyle(
                    fontSize: 18,
                    // color: Colors.black,
                    fontWeight: FontWeight.w700),
              )),
              Tab(
                child: Text(
                  'Past Orders',
                  style: TextStyle(
                      fontSize: 18,
                      // color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [ActiveordersView(), PastordersView()],
        ),
      ),
    );
  }
}
