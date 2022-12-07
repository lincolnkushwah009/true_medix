import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:true_medix/app/services/apiResponse/apiresponse.dart';
import 'package:true_medix/app/services/apis/apis.dart';

class ApiServices {
  Future<ApiResponse<dynamic>> loginWithOTP({required String phone}) async {
    log(phone.toString());
    try {
      var response = await http.post(
        Uri.parse(
            "$loginWithOtp&source=TRUMDX&dmobile=$phone&dlttempid=1707166824662138961&message=`Your OTP for login is 121221 It is valid till 10 minutes TRUMDX`"),
        body: {"email_mobile": phone},
      );
      dynamic parsedData = response.body;
      return ApiResponse(data: parsedData, statusCode: response.statusCode);
    } catch (e) {
      log(e.toString());
      throw "LoginWithOTP Failed...";
    }
  }
}
