import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:true_medix/app/modules/booking/model/slotmodel.dart';
import 'package:true_medix/app/services/apiServives/apiservices.dart';

class BookingController extends GetxController {
  ApiServices apiServices = ApiServices();
  RxList slotModelList = [
    SlotModel(
        dateTime: DateTime.now().add(const Duration(days: 1)),
        dayName: DateFormat('EEEE')
            .format(DateTime.now().add(const Duration(days: 1)))
            .toString()
            .substring(0, 3),
        month: DateFormat('EEEE, d MMM, yyyy')
            .format(DateTime.now().add(const Duration(days: 1)))
            .toString()
            .split(',')[1]
            .trim()
            .split(',')[0]
            .toString(),
        weekDay: DateFormat('EEEE, d MMM, yyyy')
            .format(DateTime.now().add(const Duration(days: 1)))
            .toString()
            .split(',')[0]
            .trim()
            .toString()),
    SlotModel(
        dateTime: DateTime.now().add(const Duration(days: 2)),
        dayName: DateFormat('EEEE')
            .format(DateTime.now().add(const Duration(days: 2)))
            .toString()
            .substring(0, 3),
        month: DateFormat('EEEE, d MMM, yyyy')
            .format(DateTime.now().add(const Duration(days: 2)))
            .toString()
            .split(',')[1]
            .trim()
            .split(',')[0]
            .toString(),
        weekDay: DateFormat('EEEE, d MMM, yyyy')
            .format(DateTime.now().add(const Duration(days: 2)))
            .toString()
            .split(',')[0]
            .trim()
            .toString()),
    SlotModel(
        dateTime: DateTime.now().add(const Duration(days: 3)),
        dayName: DateFormat('EEEE')
            .format(DateTime.now().add(const Duration(days: 3)))
            .toString()
            .substring(0, 3),
        month: DateFormat('EEEE, d MMM, yyyy')
            .format(DateTime.now().add(const Duration(days: 3)))
            .toString()
            .split(',')[1]
            .trim()
            .split(',')[0]
            .toString(),
        weekDay: DateFormat('EEEE, d MMM, yyyy')
            .format(DateTime.now().add(const Duration(days: 3)))
            .toString()
            .split(',')[0]
            .trim()
            .toString()),
    SlotModel(
        dateTime: DateTime.now().add(const Duration(days: 4)),
        dayName: DateFormat('EEEE')
            .format(DateTime.now().add(const Duration(days: 4)))
            .toString()
            .substring(0, 3),
        month: DateFormat('EEEE, d MMM, yyyy')
            .format(DateTime.now().add(const Duration(days: 4)))
            .toString()
            .split(',')[1]
            .trim()
            .split(',')[0]
            .toString(),
        weekDay: DateFormat('EEEE, d MMM, yyyy')
            .format(DateTime.now().add(const Duration(days: 4)))
            .toString()
            .split(',')[0]
            .trim()
            .toString()),
  ].obs;

  RxList timeSlots = [
    "06:00AM-07:00AM",
    "07:00AM-08:00AM",
    "08:00AM-09:00AM",
    "09:00AM-10:00AM",
    "10:00AM-11:00AM",
    "11:00AM-12:00PM",
    "12:00PM-01:00PM",
    "12:00PM-01:00PM",
    "01:00PM-02:00PM",
    "02:00PM-03:00PM"
  ].obs;

  @override
  void onInit() {
    log("BookingController Init...");
    super.onInit();
  }
}
