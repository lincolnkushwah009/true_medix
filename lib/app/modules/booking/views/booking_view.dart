// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:true_medix/app/global/customermodel.dart';
import 'package:true_medix/app/modules/addaddress/views/addaddress_view.dart';
import 'package:true_medix/app/modules/booking/controllers/booking_controller.dart';
import 'package:true_medix/app/modules/booking/model/placeorderitemmodel.dart';
import 'package:true_medix/app/modules/booking/model/placeorderrequestmodel.dart';
import 'package:true_medix/app/modules/bottomnavbar/views/bottomnavbar_view.dart';
import 'package:true_medix/app/modules/cart/controllers/cart_controller.dart';
import 'package:true_medix/app/modules/profile/controllers/profile_controller.dart';
import 'package:true_medix/app/services/secrets.dart';
import 'package:true_medix/app/services/sessionmanager.dart';
import 'package:true_medix/app/utilities/appcolors.dart';
import 'package:true_medix/app/utilities/appstyles.dart';

import '../../../global/customdialog.dart';

class BookingView extends StatefulWidget {
  const BookingView({Key? key}) : super(key: key);
  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  Map<String, dynamic>? placeOrder;
  Map<String, dynamic>? payment;
  List<PlaceOrderItemModel> placeOrderItems = [];
  PlaceOrderRequestModel? placeOrderRequestModel;
  SessionManager? sessionManager;
  BookingController? controller;
  ProfileController? profileController;
  CartController? cartController;
  int radioGroupValue = 0;
  String selectedSlot = "0";
  String selectedTimeSlot = "0";
  bool isPayOnVisit = false;
  Razorpay razorpay = Razorpay();
  // create order
  void createOrder() async {
    String username = liveKeyRazorpay;
    String password = livePasswordRazorpay;
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    Map<String, dynamic> body = {
      "amount": (cartController!.total.value.toInt() * 100).toInt(),
      "currency": "INR",
      "receipt": liveMerchantIdRazorpay
    };
    var res = await http.post(
      Uri.https("api.razorpay.com", "v1/orders"),
      headers: <String, String>{
        "Content-Type": "application/json",
        'authorization': basicAuth,
      },
      body: jsonEncode(body),
    );
    log(res.body);
    if (res.statusCode == 200) {
      openGateway(jsonDecode(res.body)['id']);
    }
  }

  openGateway(String orderId) {
    var options = {
      'key': liveKeyRazorpay,
      'amount': (cartController!.subTotal.value.toInt() * 100).toInt(),
      'name': 'truemedix.in',
      'order_id': orderId,
      'description': 'TRUEMEDIX LIFE SCIENCES PRIVATE LIMITED',
      'timeout': 60 * 5,
      'prefill': {
        'contact':
            profileController!.getAddressDetails[radioGroupValue].mobileNo,
        'email': profileController!.getAddressDetails[radioGroupValue].email,
      }
    };
    razorpay.open(options);
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    log(response.toString());
    CustomDialog().customDialog(context,
        orderTitle: "Error Code : ",
        btnTitle: "Try Again",
        subTitle: "Your Payment has been Failed.\n${response.message}",
        orderId: response.code.toString(), onTap: () {
      Navigator.of(context).pop();
      try {
        createOrder();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
    }, image: "assets/errorpay.png", title: "Payment Error", isError: true);
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) async {
    payment = {
      "type": "1",
      "mode": "4",
      "amount": cartController!.total.value.toString(),
      "pg_payment_id": response.paymentId,
      "pg_order_id": response.orderId
    };
    placeOrder!['payment'] = payment;
    await controller!.apiServices.placeOrderService(placeOrder!).then((value) {
      Navigator.of(context).pop();
      CustomDialog().customDialog(context,
          title: "Order Successful",
          orderTitle: "Order Id : ",
          subTitle:
              "Your Order has been Placed Successfully.\nPayment Received",
          btnTitle: "Track Order",
          image: "assets/successpay.svg",
          isError: false,
          onTap: () {},
          orderId: response.orderId.toString());
      Future.delayed(const Duration(seconds: 2), () async {
        await controller!.apiServices.addToCart({
          "mobile_no": sessionManager!.getCustomer['mobile_no'].toString(),
          "products": [],
        });
        Get.offAll(() => BottomnavbarView(
              incomingIndex: 2,
            ));
      });
    }).onError((error, stackTrace) {
      Navigator.of(context).pop();
      CustomDialog().customDialog(context,
          title: "Order Failed",
          orderTitle: "Order Id : ",
          subTitle:
              "Unfortunately Your Order has been Failed.\nSorry for the Inconvenience.\n",
          btnTitle: "Continue",
          image: "assets/errorpay.png",
          isError: true, onTap: () async {
        //Order Failed then Repeat the Process with Paying Again
        await controller!.apiServices
            .placeOrderService(placeOrder!)
            .then((value) {
          Navigator.of(context).pop();
          CustomDialog().customDialog(context,
              title: "Order Successful",
              orderTitle: "Order Id : ",
              subTitle:
                  "Your Order has been Placed Successfully.\nPayment Received",
              btnTitle: "Track Order",
              image: "assets/successpay.svg",
              isError: false,
              onTap: () {},
              orderId: response.orderId.toString());
          Future.delayed(const Duration(seconds: 2), () async {
            await controller!.apiServices.addToCart({
              "mobile_no": sessionManager!.getCustomer['mobile_no'].toString(),
              "products": [],
            });
            Get.offAll(() => BottomnavbarView(
                  incomingIndex: 2,
                ));
          });
        }).onError((error, stackTrace) {
          Navigator.of(context).pop();
          CustomDialog().customDialog(context,
              title: "Order Failed",
              orderTitle: "Order Id : ",
              subTitle:
                  "Unfortunately Your Order has been Failed.\nSorry for the Inconvenience.\n",
              btnTitle: "Continue",
              image: "assets/errorpay.png",
              isError: true,
              onTap: () async {},
              orderId: response.orderId.toString());
        });
      }, orderId: response.orderId.toString());
    });

    // verifySignature(
    //   signature: response.signature,
    //   paymentId: response.paymentId,
    //   orderId: response.orderId,
    // );
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    log(response.toString());
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response.walletName ?? ''),
      ),
    );
  }

  // verifySignature({
  //   String? signature,
  //   String? paymentId,
  //   String? orderId,
  // }) async {
  //   Map<String, dynamic> body = {
  //     'razorpay_signature': signature,
  //     'razorpay_payment_id': paymentId,
  //     'razorpay_order_id': orderId,
  //   };

  //   var parts = [];
  //   body.forEach((key, value) {
  //     parts.add('${Uri.encodeQueryComponent(key)}='
  //         '${Uri.encodeQueryComponent(value)}');
  //   });
  //   var formData = parts.join('&');
  //   var res = await http.post(
  //     Uri.https(
  //       "10.0.2.2", // my ip address , localhost
  //       "razorpay_signature_verify.php",
  //     ),
  //     headers: {
  //       "Content-Type": "application/x-www-form-urlencoded", // urlencoded
  //     },
  //     body: formData,
  //   );

  //   log(res.body);
  //   if (res.statusCode == 200) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(res.body),
  //       ),
  //     );
  //   }
  // }

  @override
  void initState() {
    controller = Get.put<BookingController>(BookingController());
    profileController = Get.put<ProfileController>(ProfileController());
    cartController = Get.put<CartController>(CartController());
    sessionManager = SessionManager();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
      razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
      razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
    });
    super.initState();
  }

  @override
  void dispose() {
    razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // logs Tuesday, 10 Dec, 2019
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          "Booking",
          style: iconTextStyle.copyWith(
              fontSize: 24,
              color: const Color(0XFF242424),
              fontWeight: FontWeight.w400),
        ),
        leading: InkWell(
          splashColor: Colors.black,
          highlightColor: Colors.green,
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Ink(child: SvgPicture.asset("assets/back.svg")),
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
      ),
      body: LoaderOverlay(
        useDefaultLoading: true,
        overlayColor: kPrimaryColor,
        overlayWholeScreen: true,
        switchInCurve: Curves.bounceIn,
        switchOutCurve: Curves.bounceOut,
        closeOnBackButton: false,
        disableBackButton: true,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, top: 20),
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GetBuilder<CartController>(
                        builder: (cartController) {
                          return FutureBuilder(
                              future:
                                  cartController.apiServices.getCartProducts(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Shimmer.fromColors(
                                    baseColor: Colors.grey.withOpacity(0.25),
                                    highlightColor:
                                        Colors.white.withOpacity(0.6),
                                    direction: ShimmerDirection.ltr,
                                    loop: 3,
                                    child: SizedBox(
                                      height: 150,
                                      child: ListView.builder(
                                          itemCount: 1,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    FittedBox(
                                                      child: Text(
                                                        "Test Name",
                                                        style: testTextStyle
                                                            .copyWith(
                                                                fontSize: 16),
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8.0),
                                                      child: InkWell(
                                                        onTap: () {},
                                                        child: SvgPicture.asset(
                                                            "assets/drop.svg"),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 13,
                                                ),
                                                Text(
                                                  "Include 8 Tests",
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    color:
                                                        const Color(0XFF242424),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 13,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Rs 600",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14,
                                                        color: const Color(
                                                            0XFF242424),
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    SizedBox(
                                                      width: 30,
                                                      height: 30,
                                                      child: Center(
                                                        child: IconButton(
                                                          onPressed: () {},
                                                          icon: Image.asset(
                                                              "assets/trash.png"),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 23,
                                                ),
                                              ],
                                            );
                                          }),
                                    ),
                                  );
                                }
                                if (snapshot.data == null) {
                                  return Center(
                                    child: Image.asset("assets/oops.png"),
                                  );
                                }
                                if (snapshot.data!.isEmpty) {
                                  return Center(
                                    child: Text(
                                      "Your Cart is Empty\n Click + Add Test to add Products",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: const Color(0XFF242424),
                                      ),
                                    ),
                                  );
                                }
                                return SizedBox(
                                  height: snapshot.data!.isEmpty
                                      ? 150
                                      : (snapshot.data!.length * 150),
                                  child: ListView.builder(
                                      itemCount: snapshot.data!.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Flexible(
                                                      child: SizedBox(
                                                        child: Text(
                                                          snapshot
                                                              .data![index].name
                                                              .toString(),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: testTextStyle
                                                              .copyWith(
                                                                  fontSize: 16),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8.0),
                                                      child: InkWell(
                                                        onTap: () {},
                                                        child: SvgPicture.asset(
                                                            "assets/drop.svg"),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 13,
                                                ),
                                                Text(
                                                  "Includes ${snapshot.data![index].relatedProducts == null ? "0" : snapshot.data![index].relatedProducts!.split(',').length.toString()} Tests",
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    color:
                                                        const Color(0XFF242424),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 13,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Rs. ${snapshot.data![index].saleprice}",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14,
                                                        color: const Color(
                                                            0XFF242424),
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    SizedBox(
                                                      width: 30,
                                                      height: 30,
                                                      child: Center(
                                                        child: IconButton(
                                                          onPressed: () async {
                                                            List<dynamic>
                                                                cartProductId =
                                                                cartController
                                                                    .cartProducts
                                                                    .map(
                                                                        (element) {
                                                              return element.id;
                                                            }).toList();
                                                            cartProductId
                                                                .remove(snapshot
                                                                    .data![
                                                                        index]
                                                                    .id);
                                                            log(cartProductId
                                                                .toList()
                                                                .toString());
                                                            Map<String, dynamic>
                                                                payLoad = {
                                                              "mobile_no": "",
                                                              "products":
                                                                  cartProductId,
                                                            };
                                                            cartController
                                                                .apiServices
                                                                .addToCart(
                                                                    payLoad)
                                                                .then((value) {
                                                              cartController
                                                                  .update();
                                                              ElegantNotification
                                                                  .success(
                                                                title: const Text(
                                                                    "Success"),
                                                                description: Text(
                                                                    value['message']
                                                                        .toString()),
                                                              ).show(context);
                                                              cartController
                                                                  .subTotal
                                                                  .value = 0.0;
                                                              cartController
                                                                  .taxAndFee
                                                                  .value = 0.0;
                                                              cartController
                                                                      .delivery
                                                                      .value =
                                                                  "Free";
                                                              cartController
                                                                  .total
                                                                  .value = 0.0;
                                                              cartController
                                                                  .onInit();
                                                            }).onError((error,
                                                                    stackTrace) {
                                                              log(stackTrace
                                                                  .toString());
                                                              ElegantNotification
                                                                  .error(
                                                                title:
                                                                    const Text(
                                                                        "Error"),
                                                                description:
                                                                    const Text(
                                                                        "Error Occured, Please try again"),
                                                              ).show(context);
                                                            });
                                                          },
                                                          icon: Image.asset(
                                                              "assets/trash.png"),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 23,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                );
                              });
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => BottomnavbarView(
                                incomingIndex: 0,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          "+  Add Test",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: const Color(0XFF00B9C9),
                          ),
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
                      GetBuilder<ProfileController>(
                        builder: (profileController) {
                          return FutureBuilder(
                            future: profileController.apiServices.getAddress(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey.withOpacity(0.25),
                                  highlightColor: Colors.white.withOpacity(0.6),
                                  child: SizedBox(
                                    height: 210,
                                    child: ListView.builder(
                                        itemCount: 1,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 17.0),
                                            child: Container(
                                              height: 100,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: const Color(0XFFBBEFFD),
                                              ),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 13.0,
                                                            right: 0,
                                                            bottom: 0),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 14,
                                                            color: const Color(
                                                                0XFF242424),
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                        Radio<int>(
                                                            value: index,
                                                            fillColor:
                                                                MaterialStateProperty
                                                                    .all(Colors
                                                                        .black),
                                                            activeColor:
                                                                Colors.black,
                                                            groupValue:
                                                                radioGroupValue,
                                                            onChanged: (val) {
                                                              setState(() {
                                                                radioGroupValue =
                                                                    val!;
                                                              });
                                                            }),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 13.0,
                                                            right: 13),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Flexible(
                                                          child: SizedBox(
                                                            width: 500,
                                                            child: Text(
                                                              "",
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 14,
                                                                color: const Color(
                                                                    0XFF242424),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                        Text(
                                                          "Edit",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 14,
                                                            color: const Color(
                                                                0XFF00B9C9),
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
                                );
                              }
                              if (snapshot.data == null) {
                                return Center(
                                  child: Image.asset("assets/oops.png"),
                                );
                              }
                              if (snapshot.data!.isEmpty) {
                                return Center(
                                  child: Text(
                                    "No Addresses Found\n Click on + Add Address to Add Address",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: const Color(0XFF242424),
                                    ),
                                  ),
                                );
                              }
                              return SizedBox(
                                height: snapshot.data!.isEmpty
                                    ? 120
                                    : snapshot.data!.length * 120,
                                child: ListView.builder(
                                    itemCount: snapshot.data!.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 17.0),
                                        child: Container(
                                          height: 100,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: const Color(0XFFBBEFFD),
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 13.0,
                                                    right: 0,
                                                    bottom: 0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "# ${snapshot.data![index].id.toString()}",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14,
                                                        color: const Color(
                                                            0XFF242424),
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    Radio<int>(
                                                        value: index,
                                                        fillColor:
                                                            MaterialStateProperty
                                                                .all(Colors
                                                                    .black),
                                                        activeColor:
                                                            Colors.black,
                                                        groupValue:
                                                            radioGroupValue,
                                                        onChanged: (val) {
                                                          setState(() {
                                                            radioGroupValue =
                                                                val!;
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
                                                    Flexible(
                                                      child: SizedBox(
                                                        width: 500,
                                                        child: Text(
                                                          "${snapshot.data![index].city.toString()}\n${snapshot.data![index].address.toString()}",
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 14,
                                                            color: const Color(
                                                                0XFF242424),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                AddaddressView(
                                                              getAddressModel:
                                                                  snapshot.data![
                                                                      index],
                                                              isEdit: true,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Text(
                                                        "Edit",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14,
                                                          color: const Color(
                                                              0XFF00B9C9),
                                                        ),
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
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        splashColor: Colors.black,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AddaddressView(),
                            ),
                          );
                        },
                        child: Text(
                          "+  Add Address",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: const Color(0XFF00B9C9),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
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
                        height: 10,
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
                          child: GridView.count(
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              crossAxisSpacing: 4.0,
                              mainAxisSpacing: 8.0,
                              childAspectRatio:
                                  (MediaQuery.of(context).size.width *
                                      0.42 /
                                      39),
                              children: List.generate(
                                  controller!.slotModelList.length, (index) {
                                return InkWell(
                                  onTap: () {
                                    log("${controller!.slotModelList[index].weekDay} ------ ${controller!.slotModelList[index].month} ------ (${controller!.slotModelList[index].dayName})");
                                    setState(() {
                                      selectedSlot = index.toString();
                                    });
                                  },
                                  child: Container(
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
                                      border: Border.all(
                                        color: selectedSlot == index.toString()
                                            ? kBtnColor
                                            : Colors.white,
                                      ),
                                    ),
                                    child: Center(
                                        child: Text(
                                      "${controller!.slotModelList[index].month} (${controller!.slotModelList[index].dayName})",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: selectedSlot == index.toString()
                                            ? kBtnColor
                                            : Colors.black,
                                      ),
                                    )),
                                  ),
                                );
                              }))),
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
                        child: GridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 8.0,
                          childAspectRatio:
                              (MediaQuery.of(context).size.width * 0.42 / 39),
                          children: List.generate(controller!.timeSlots.length,
                              (index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedTimeSlot = index.toString();
                                });
                              },
                              child: Container(
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
                                  border: Border.all(
                                    color: selectedTimeSlot == index.toString()
                                        ? kBtnColor
                                        : Colors.white,
                                  ),
                                  color: Colors.white,
                                ),
                                child: Center(
                                    child: Text(
                                  controller!.timeSlots[index].toString(),
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: selectedTimeSlot == index.toString()
                                        ? kBtnColor
                                        : Colors.black,
                                  ),
                                )),
                              ),
                            );
                          }),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          InkWell(
                            splashColor: Colors.black,
                            highlightColor: Colors.red,
                            onTap: () async {
                              placeOrderItems = [];
                              CustomerModel customerModel =
                                  await sessionManager!.getAuthToken();
                              log(cartController!.cartProducts.toString());
                              for (var element
                                  in cartController!.cartProducts) {
                                placeOrderItems.add(
                                  PlaceOrderItemModel(
                                      amount: element.saleprice,
                                      qty: 1,
                                      appDate: DateTime.now()
                                          .toString()
                                          .split('.')[0]
                                          .toString(),
                                      productId: element.id),
                                );
                              }
                              List<Map<String, dynamic>> items = [];
                              for (int i = 0; i < placeOrderItems.length; i++) {
                                items.add({
                                  "product_id":
                                      placeOrderItems[i].productId.toString(),
                                  "app_date":
                                      placeOrderItems[i].appDate.toString(),
                                  "qty": placeOrderItems[i].qty,
                                  "amount": placeOrderItems[i].amount
                                });
                              }
                              log("===============");
                              log(items.toString());
                              log("===============");
                              placeOrder = {
                                "ordered_on": DateTime.now()
                                    .toString()
                                    .split('.')[0]
                                    .toString(),
                                "scheduled_on":
                                    "${((controller!.slotModelList[int.parse(selectedSlot)].dateTime) as DateTime).toString().split('.')[0].toString().split(" ")[0]} ${controller!.timeSlots[int.parse(selectedTimeSlot)].toString().split('-')[0].toString()}",
                                "tax": "0.0",
                                "subtotal":
                                    cartController!.subTotal.value.toString(),
                                "coupon_discount": "0.0",
                                "total": cartController!.total.value.toString(),
                                "paid_amount": "0.00",
                                "due_amount":
                                    cartController!.total.value.toString(),
                                "total_products":
                                    cartController!.cartProducts.length,
                                "customer_id": customerModel.id.toString(),
                                "name": customerModel.name.toString(),
                                "mobile": customerModel.mobileNo.toString(),
                                "email": customerModel.email.toString(),
                                "bill_name": profileController!
                                    .getAddressDetails[radioGroupValue].name
                                    .toString(),
                                "bill_dob": profileController!
                                    .getAddressDetails[radioGroupValue].dob,
                                "bill_age": profileController!
                                    .getAddressDetails[radioGroupValue].age
                                    .toString(),
                                "bill_gender": profileController!
                                    .getAddressDetails[radioGroupValue].gender
                                    .toString(),
                                "bill_mobile_no": profileController!
                                    .getAddressDetails[radioGroupValue].mobileNo
                                    .toString(),
                                "bill_email": profileController!
                                    .getAddressDetails[radioGroupValue].email
                                    .toString(),
                                "bill_address": profileController!
                                    .getAddressDetails[radioGroupValue].address
                                    .toString(),
                                "bill_city": profileController!
                                    .getAddressDetails[radioGroupValue].city
                                    .toString(),
                                "bill_zip": profileController!
                                    .getAddressDetails[radioGroupValue].pincode
                                    .toString(),
                                "bill_zone_id": profileController!
                                    .getAddressDetails[radioGroupValue].state
                                    .toString(),
                                "bill_zone": profileController!
                                    .getAddressDetails[radioGroupValue]
                                    .stateName
                                    .toString(),
                                "bill_country": profileController!
                                    .getAddressDetails[radioGroupValue]
                                    .countryName
                                    .toString(),
                                "bill_country_id": profileController!
                                    .getAddressDetails[radioGroupValue].country
                                    .toString(),
                                "google_map": profileController!
                                    .getAddressDetails[radioGroupValue]
                                    .googleMap
                                    .toString(),
                                "google_lat": profileController!
                                    .getAddressDetails[radioGroupValue]
                                    .googleLat
                                    .toString(),
                                "google_lng": profileController!
                                    .getAddressDetails[radioGroupValue]
                                    .googleLng
                                    .toString(),
                                "ordered_by": "0",
                                "coupon": "_",
                                "items": items,
                                "payment": {
                                  "type": "0",
                                }
                              };
                              log(placeOrder.toString());
                              await controller!.apiServices
                                  .placeOrderService(placeOrder!)
                                  .then((value) {
                                CustomDialog().customDialog(context,
                                    title: "Order Successful",
                                    btnTitle: "Track Order",
                                    orderTitle: "Order Id : ",
                                    orderId: value.orderId.toString(),
                                    image: "assets/successpay.svg",
                                    isError: false,
                                    onTap: () {},
                                    subTitle:
                                        "Your Order has been Placed Successfully\nYou will receive an Email / Message Shortly.");
                                Future.delayed(const Duration(seconds: 2),
                                    () async {
                                  await controller!.apiServices.addToCart({
                                    "mobile_no": sessionManager!
                                        .getCustomer['mobile_no']
                                        .toString(),
                                    "products": [],
                                  });
                                  Get.offAll(() => BottomnavbarView(
                                        incomingIndex: 2,
                                      ));
                                });
                              }).onError((error, stackTrace) {
                                CustomDialog().customDialog(context,
                                    title: "Order Failed",
                                    btnTitle: "Try Again",
                                    orderTitle: "Error Code : ",
                                    orderId: "2",
                                    image: "assets/errorpay.png",
                                    isError: true, onTap: () async {
                                  Navigator.of(context).pop();
                                  await controller!.apiServices
                                      .placeOrderService(placeOrder!)
                                      .then((value) {
                                    CustomDialog().customDialog(context,
                                        title: "Order Successful",
                                        btnTitle: "Track Order",
                                        orderTitle: "Order Id : ",
                                        orderId: value.orderId.toString(),
                                        image: "assets/successpay.svg",
                                        isError: false,
                                        onTap: () async {},
                                        subTitle:
                                            "Your Order has been Placed Successfully\nYou will receive an Email / Message Shortly.");
                                    Future.delayed(const Duration(seconds: 2),
                                        () async {
                                      await controller!.apiServices.addToCart({
                                        "mobile_no": sessionManager!
                                            .getCustomer['mobile_no']
                                            .toString(),
                                        "products": [],
                                      });
                                      Get.offAll(() => BottomnavbarView(
                                            incomingIndex: 2,
                                          ));
                                    });
                                  }).onError((error, stackTrace) {
                                    CustomDialog().customDialog(context,
                                        title: "Order Failed",
                                        btnTitle: "Try Again",
                                        orderTitle: "Error Code : ",
                                        orderId: "2",
                                        image: "assets/errorpay.png",
                                        isError: true,
                                        onTap: () {},
                                        subTitle:
                                            "Unfortunately Your Order has been failed\nSorry for the Inconvenience.");
                                  });
                                },
                                    subTitle:
                                        "Unfortunately Your Order has been failed\nSorry for the Inconvenience.");
                              });
                            },
                            child: Ink(
                              height: 40,
                              width: 155,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Text(
                                  'Pay On Visit',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          const SizedBox(
                            width: 10,
                          ),
                          const Spacer(),
                          InkWell(
                            splashColor: Colors.black,
                            highlightColor: Colors.green,
                            onTap: () async {
                              placeOrderItems = [];
                              CustomerModel customerModel =
                                  await sessionManager!.getAuthToken();
                              log(cartController!.cartProducts.toString());
                              for (var element
                                  in cartController!.cartProducts) {
                                placeOrderItems.add(
                                  PlaceOrderItemModel(
                                      amount: element.saleprice,
                                      qty: 1,
                                      appDate: DateTime.now()
                                          .toString()
                                          .split('.')[0]
                                          .toString(),
                                      productId: element.id),
                                );
                              }
                              List<Map<String, dynamic>> items = [];
                              for (int i = 0; i < placeOrderItems.length; i++) {
                                items.add({
                                  "product_id":
                                      placeOrderItems[i].productId.toString(),
                                  "app_date":
                                      placeOrderItems[i].appDate.toString(),
                                  "qty": placeOrderItems[i].qty,
                                  "amount": placeOrderItems[i].amount
                                });
                              }
                              log("===============");
                              log(items.toString());
                              log("===============");
                              placeOrder = {
                                "ordered_on": DateTime.now()
                                    .toString()
                                    .split('.')[0]
                                    .toString(),
                                "scheduled_on":
                                    "${((controller!.slotModelList[int.parse(selectedSlot)].dateTime) as DateTime).toString().split('.')[0].toString().split(" ")[0]} ${controller!.timeSlots[int.parse(selectedTimeSlot)].toString().split('-')[0].toString()}",
                                "tax": "0.0",
                                "subtotal":
                                    cartController!.subTotal.value.toString(),
                                "coupon_discount": "0.0",
                                "total": cartController!.total.value.toString(),
                                "paid_amount":
                                    cartController!.total.value.toString(),
                                "due_amount": "0.00",
                                "total_products":
                                    cartController!.cartProducts.length,
                                "customer_id": customerModel.id.toString(),
                                "name": customerModel.name.toString(),
                                "mobile": customerModel.mobileNo.toString(),
                                "email": customerModel.email.toString(),
                                "bill_name": profileController!
                                    .getAddressDetails[radioGroupValue].name
                                    .toString(),
                                "bill_dob": "03-09-2000",
                                "bill_age": profileController!
                                    .getAddressDetails[radioGroupValue].age
                                    .toString(),
                                "bill_gender": profileController!
                                    .getAddressDetails[radioGroupValue].gender
                                    .toString(),
                                "bill_mobile_no": profileController!
                                    .getAddressDetails[radioGroupValue].mobileNo
                                    .toString(),
                                "bill_email": profileController!
                                    .getAddressDetails[radioGroupValue].email
                                    .toString(),
                                "bill_address": profileController!
                                    .getAddressDetails[radioGroupValue].address
                                    .toString(),
                                "bill_city": profileController!
                                    .getAddressDetails[radioGroupValue].city
                                    .toString(),
                                "bill_zip": profileController!
                                    .getAddressDetails[radioGroupValue].pincode
                                    .toString(),
                                "bill_zone_id": profileController!
                                    .getAddressDetails[radioGroupValue].state
                                    .toString(),
                                "bill_zone": profileController!
                                    .getAddressDetails[radioGroupValue]
                                    .stateName
                                    .toString(),
                                "bill_country": profileController!
                                    .getAddressDetails[radioGroupValue]
                                    .countryName
                                    .toString(),
                                "bill_country_id": profileController!
                                    .getAddressDetails[radioGroupValue].country
                                    .toString(),
                                "google_map": profileController!
                                    .getAddressDetails[radioGroupValue]
                                    .googleMap
                                    .toString(),
                                "google_lat": profileController!
                                    .getAddressDetails[radioGroupValue]
                                    .googleLat
                                    .toString(),
                                "google_lng": profileController!
                                    .getAddressDetails[radioGroupValue]
                                    .googleLng
                                    .toString(),
                                "ordered_by": "0",
                                "coupon": "_",
                                "items": items
                              };
                              log(placeOrder.toString());

                              try {
                                createOrder();
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(e.toString()),
                                  ),
                                );
                              }
                            },
                            child: Ink(
                              height: 40,
                              width: 155,
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
                                ),
                              ),
                            ),
                          ),
                        ],
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
      ),
    );
  }
}
