// // ignore_for_file: use_build_context_synchronously

// import 'dart:convert';
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:http/http.dart' as http;
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';

// import '../../../utilities/appcolors.dart';
// import '../../../utilities/appstyles.dart';
// import '../controllers/pamentmethod_controller.dart';

// class PamentmethodView extends StatefulWidget {
//   const PamentmethodView({Key? key}) : super(key: key);

//   @override
//   State<PamentmethodView> createState() => _PamentmethodViewState();
// }

// class _PamentmethodViewState extends State<PamentmethodView> {
//   PamentmethodController? controller;
//   Razorpay razorpay = Razorpay();
// //rzp_test_aIvgB1n3nCf3xL
// // uH1mq5OT1JtT6McdOHwQ3XAA
//   // create order
//   void createOrder() async {
//     String username = "rzp_live_mKNu8CwkcIBYKG";
//     String password = "Y14AdAlST3G1SX7qZMbVW0kr";
//     String basicAuth =
//         'Basic ${base64Encode(utf8.encode('$username:$password'))}';

//     Map<String, dynamic> body = {
//       "amount": 100,
//       "currency": "INR",
//       "receipt": "Iok3aHQk7RKlUo"
//     };
//     var res = await http.post(
//       Uri.https("api.razorpay.com", "v1/orders"),
//       headers: <String, String>{
//         "Content-Type": "application/json",
//         'authorization': basicAuth,
//       },
//       body: jsonEncode(body),
//     );
//     if (res.statusCode == 200) {
//       openGateway(jsonDecode(res.body)['id']);
//     }
//     log("CREATEORDER");
//     log(res.body);
//   }

//   openGateway(String orderId) {
//     var options = {
//       'key': "rzp_live_mKNu8CwkcIBYKG",
//       'amount': 50,
//       'name': 'Truemedix',
//       'order_id': orderId,
//       'description': 'Product Name Here',
//       'timeout': 60 * 5,
//       'prefill': {
//         'contact': '9541599562',
//         'email': 'developer.zaidbashir@gmail.com',
//       }
//     };
//     razorpay.open(options);
//   }

//   void showAlertDialog(BuildContext context, String title, String message) {
//     Widget continueButton = ElevatedButton(
//       child: const Text("Continue"),
//       onPressed: () {},
//     );
//     AlertDialog alert = AlertDialog(
//       title: Text(title),
//       content: Text(message),
//       actions: [
//         continueButton,
//       ],
//     );
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }

//   void handlePaymentErrorResponse(PaymentFailureResponse response) {
//     /*
//     * PaymentFailureResponse contains three values:
//     * 1. Error Code
//     * 2. Error Description
//     * 3. Metadata
//     * */
//     log(response.toString());
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(response.message ?? ''),
//       ),
//     );
//     showAlertDialog(context, "Payment Failed", "${response.message}");
//     //\nMetadata:${response.error.toString()
//     //"Code: ${response.code}\n
//   }

//   void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
//     log("${response.paymentId}   /   ${response.signature}    /    ${response.orderId}");
//     /*
//     * Payment Success Response contains three values:
//     * 1. Order ID
//     * 2. Payment ID
//     * 3. Signature
//     * */
//     log(response.toString());
//     // verifySignature(
//     //   signature: response.signature,
//     //   paymentId: response.paymentId,
//     //   orderId: response.orderId,
//     // );
//     // verifySignature(
//     //   signature: response.signature,
//     //   paymentId: response.paymentId,
//     //   orderId: response.orderId,
//     // );
//     showAlertDialog(context, "Payment Successful",
//         "Your Payment has been Completed Successfully\nPayment ID: ${response.paymentId}");
//   }

//   void handleExternalWalletSelected(ExternalWalletResponse response) {
//     log(response.toString());
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(response.walletName ?? ''),
//       ),
//     );
//   }

//   // verifySignature({
//   //   String? signature,
//   //   String? paymentId,
//   //   String? orderId,
//   // }) async {
//   //   Map<String, dynamic> body = {
//   //     'razorpay_signature': signature,
//   //     'razorpay_payment_id': paymentId,
//   //     'razorpay_order_id': orderId,
//   //   };

//   //   var parts = [];
//   //   body.forEach((key, value) {
//   //     parts.add('${Uri.encodeQueryComponent(key)}='
//   //         '${Uri.encodeQueryComponent(value)}');
//   //   });
//   //   var formData = parts.join('&');
//   //   var res = await http.post(
//   //     Uri.https(
//   //       "10.0.2.2", // my ip address , localhost
//   //       "razorpay_signature_verify.php",
//   //     ),
//   //     headers: {
//   //       "Content-Type": "application/x-www-form-urlencoded", // urlencoded
//   //     },
//   //     body: formData,
//   //   );

//   //   log(res.body);
//   //   if (res.statusCode == 200) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(
//   //         content: Text(res.body),
//   //       ),
//   //     );
//   //   }
//   // }

//   @override
//   void initState() {
//     controller = Get.put<PamentmethodController>(PamentmethodController());
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
//       razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
//       razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
//     });
//     super.initState();
//   }

//   @override
//   void dispose() {
//     razorpay.clear();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: kPrimaryColor,
//         automaticallyImplyLeading: false,
//         title: Text(
//           "Payment Method",
//           style: iconTextStyle.copyWith(
//               fontSize: 24,
//               color: const Color(0XFF242424),
//               fontWeight: FontWeight.w400),
//         ),
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.of(context).pop();
//           },
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: SvgPicture.asset("assets/back.svg"),
//           ),
//         ),
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(30),
//             bottomRight: Radius.circular(30),
//           ),
//         ),
//       ),
//       body: SizedBox(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: Padding(
//           padding: const EdgeInsets.only(left: 16.0, right: 16, top: 36),
//           child: Column(
//             children: [
//               Container(
//                 height: 57,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5),
//                   color: const Color(0XFFBBEFFD),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 23.0, right: 23),
//                   child: Row(
//                     children: [
//                       Text(
//                         "Debit / Credit Card",
//                         style: GoogleFonts.poppins(
//                           fontWeight: FontWeight.w500,
//                           fontSize: 16,
//                           color: const Color(0XFF242424),
//                         ),
//                       ),
//                       const Spacer(),
//                       Image.asset(
//                         "assets/creditdebit.png",
//                         width: 35,
//                         height: 35,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 13,
//               ),
//               Container(
//                 height: 57,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5),
//                   color: const Color(0XFFBBEFFD),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 23.0, right: 23),
//                   child: Row(
//                     children: [
//                       Text(
//                         "Internet Banking",
//                         style: GoogleFonts.poppins(
//                           fontWeight: FontWeight.w500,
//                           fontSize: 16,
//                           color: const Color(0XFF242424),
//                         ),
//                       ),
//                       const Spacer(),
//                       Image.asset(
//                         "assets/intbanking.png",
//                         width: 35,
//                         height: 35,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 13,
//               ),
//               GestureDetector(
//                 onTap: () async {
//                   try {
//                     createOrder();
//                   } catch (e) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text(e.toString()),
//                       ),
//                     );
//                   }
//                 },
//                 child: Container(
//                   height: 57,
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5),
//                     color: const Color(0XFFBBEFFD),
//                   ),
//                   child: Row(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 18.0, top: 5),
//                         child: Image.asset(
//                           "assets/gpay.png",
//                           width: 80,
//                           height: 25,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 13,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   try {
//                     createOrder();
//                   } catch (e) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text(e.toString()),
//                       ),
//                     );
//                   }
//                 },
//                 child: Container(
//                   height: 57,
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5),
//                     color: const Color(0XFFBBEFFD),
//                   ),
//                   child: Row(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 23.0),
//                         child: Image.asset(
//                           "assets/phonepe.png",
//                           width: 80,
//                           height: 32,
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
