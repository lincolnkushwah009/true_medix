import 'package:get/get.dart';

import '../modules/bottomnavbar/bindings/bottomnavbar_binding.dart';
import '../modules/bottomnavbar/views/bottomnavbar_view.dart';
import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/orderhistory/bindings/orderhistory_binding.dart';
import '../modules/orderhistory/views/orderhistory_view.dart';
import '../modules/otpscreen/bindings/otpscreen_binding.dart';
import '../modules/otpscreen/views/otpscreen_view.dart';
import '../modules/productdetail/bindings/productdetail_binding.dart';
import '../modules/productdetail/views/productdetail_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/search/bindings/search_binding.dart';
import '../modules/search/views/search_view.dart';
import '../modules/tests/bindings/tests_binding.dart';
import '../modules/tests/views/tests_view.dart';
import '../modules/trackstatus/bindings/trackstatus_binding.dart';
import '../modules/trackstatus/views/trackstatus_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.OTPSCREEN,
      page: () => const OtpscreenView(),
      binding: OtpscreenBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => const CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.ORDERHISTORY,
      page: () => const OrderhistoryView(),
      binding: OrderhistoryBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCTDETAIL,
      page: () => const ProductdetailView(),
      binding: ProductdetailBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => const SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.TRACKSTATUS,
      page: () => const TrackstatusView(),
      binding: TrackstatusBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOMNAVBAR,
      page: () => const BottomnavbarView(),
      binding: BottomnavbarBinding(),
    ),
    GetPage(
      name: _Paths.TESTS,
      page: () => const TestsView(),
      binding: TestsBinding(),
    ),
  ];
}
