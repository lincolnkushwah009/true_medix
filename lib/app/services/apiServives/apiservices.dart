import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:true_medix/app/services/apiResponse/apiresponse.dart';
import 'package:true_medix/app/services/apis/apis.dart';

class ApiServices {
  Future<ApiResponse<Map<String, dynamic>>> loginWithOTP(
      {required String phone}) async {
    log(phone.toString());
    try {
      var data = {"email_mobile": phone.toString()};

      var response = await http.post(
        Uri.parse(loginWithOtp),
        body: json.encode(data),
      );
      log(response.toString());
      log(response.body);
      Map<String, dynamic> parsedData =
          jsonDecode(response.body) as Map<String, dynamic>;
      return ApiResponse(data: parsedData, statusCode: response.statusCode);
    } catch (e) {
      log(e.toString());
      throw "LoginWithOTP Failed...";
    }
  }

  //Verify OTP API
  Future<ApiResponse<Map<String, dynamic>>> loginOTPVerify(
      {required String otp, required String phone}) async {
    log(otp.toString());
    try {
      var data = {"email_mobile": phone.toString(), "otp": otp.toString()};

      var response = await http.post(
        Uri.parse(loginOtpVerify),
        body: json.encode(data),
      );
      log(response.toString());
      Map<String, dynamic> parsedData =
          jsonDecode(response.body) as Map<String, dynamic>;
      return ApiResponse(data: parsedData, statusCode: response.statusCode);
    } catch (e) {
      log(e.toString());
      throw "LoginOTPVerify Failed...";
    }
  }

  //Get Profile Details
  // Future<ApiResponse<Map<String, dynamic>>> getMyProfileDetails(
  //     {required String authId}) async {
  //   log("Api Inprogress");
  //   try {
  //     var response = await http.get(
  //       Uri.parse(
  //           "https://www.hiyutech.in/truemedex/apis/v1/customers/profile?AuthId=y5ydyqu8ysebujy6um"),
  //     );
  //     log(response.body.toString());
  //     Map<String, dynamic> parsedData =
  //         jsonDecode(response.body) as Map<String, dynamic>;
  //     return ApiResponse(data: parsedData, statusCode: response.statusCode);
  //   } catch (e) {
  //     log(e.toString());
  //     throw "getMyProfile Failed...";
  //   }
  // }

  //GetBanners API
  Future<Map<String, dynamic>> getRunningBanners() async {
    try {
      var response = await http.get(
        Uri.parse(runningBanners),
      );
      log(response.body.toString());
      Map<String, dynamic> parsedData =
          jsonDecode(response.body) as Map<String, dynamic>;
      return parsedData;
    } catch (e) {
      log(e.toString());
      throw "getRunningBanners Failed...";
    }
  }

  //GetProducts API
  Future<Map<String, dynamic>> getProducts() async {
    log("Api Products Inprogress");
    try {
      var response = await http.get(
        Uri.parse(products),
      );
      log(response.body.toString());
      Map<String, dynamic> parsedData =
          jsonDecode(response.body) as Map<String, dynamic>;
      return parsedData;
    } catch (e) {
      log(e.toString());
      throw "getRunningBanners Failed...";
    }
  }
}
