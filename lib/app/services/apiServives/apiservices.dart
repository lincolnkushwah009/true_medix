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
      var response = await http.post(
        Uri.parse(loginWithOtp),
        body: {"email_mobile": phone},
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
}