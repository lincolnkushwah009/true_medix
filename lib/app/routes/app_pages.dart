import 'package:get/get.dart';

import '../modules/activeorders/views/activeorders_view.dart';
import '../modules/addaddress/bindings/addaddress_binding.dart';
import '../modules/addaddress/views/addaddress_view.dart';
import '../modules/booking/views/booking_view.dart';
import '../modules/bottomnavbar/views/bottomnavbar_view.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/views/login_view.dart';
import '../modules/loginwithpassword/views/loginwithpassword_view.dart';
import '../modules/orderhistory/views/orderhistory_view.dart';
import '../modules/otpscreen/views/otpscreen_view.dart';
import '../modules/pastorders/views/pastorders_view.dart';
import '../modules/productdetail/views/productdetail_view.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/views/register_view.dart';
import '../modules/search/views/search_view.dart';
import '../modules/trackstatus/views/trackstatus_view.dart';

// ignore_for_file: constant_identifier_names, prefer_typing_uninitialized_variables

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGINWITHPASSWORD;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
    ),
    GetPage(
      name: _Paths.OTPSCREEN,
      page: () => OtpscreenView(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => const CartView(),
    ),
    GetPage(
      name: _Paths.ORDERHISTORY,
      page: () => const OrderhistoryView(),
    ),
    GetPage(
      name: _Paths.BOOKING,
      page: () => const BookingView(),
    ),
    GetPage(
      name: _Paths.PRODUCTDETAIL,
      page: () => const ProductdetailView(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => const SearchView(),
    ),
    GetPage(
      name: _Paths.TRACKSTATUS,
      page: () => const TrackstatusView(),
    ),
    GetPage(
      name: _Paths.BOTTOMNAVBAR,
      page: () => BottomnavbarView(
        incomingIndex: 0,
      ),
    ),
    GetPage(
      name: _Paths.ACTIVEORDERS,
      page: () => const ActiveordersView(),
    ),
    GetPage(
      name: _Paths.PASTORDERS,
      page: () => const PastordersView(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
    ),
    GetPage(
      name: _Paths.LOGINWITHPASSWORD,
      page: () => LoginwithpasswordView(),
    ),
    GetPage(
      name: _Paths.ADDADDRESS,
      page: () => AddaddressView(),
      binding: AddaddressBinding(),
    ),
  ];
}
