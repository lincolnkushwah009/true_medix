import 'dart:convert';
import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:true_medix/app/modules/home/models/bannermodel.dart';
import 'package:true_medix/app/modules/productdetail/models/productmodel.dart';
import 'package:true_medix/app/modules/profile/model/profilemodel.dart';
import 'package:true_medix/app/modules/register/model/registermodel.dart';
import 'package:true_medix/app/services/apiResponse/apiresponse.dart';
import 'package:true_medix/app/services/apis/apis.dart';

class ApiServices {
  GetStorage authIdGetStorage = GetStorage();
  String authIdGetStorageKey = "AUTHID";

  Future<ApiResponse<Map<String, dynamic>>> loginWithOTP(
      {required String phone}) async {
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

  //GetBanners API
  Future<List<BannerModel>> getRunningBanners() async {
    try {
      var response = await http.get(
        Uri.parse(runningBanners),
      );
      log(response.body.toString());
      Map<String, dynamic> parsedData =
          jsonDecode(response.body) as Map<String, dynamic>;
      return (parsedData['data'] as List<dynamic>).map((e) {
        return BannerModel.fromJson(e);
      }).toList();
    } catch (e) {
      log(e.toString());
      throw Error();
    }
  }

  //GetProducts API
  Future<List<ProductModel>> getProducts() async {
    log("Api Products Inprogress");
    try {
      var response = await http.get(
        Uri.parse(products),
      );
      log(response.body.toString());
      Map<String, dynamic> parsedData =
          jsonDecode(response.body) as Map<String, dynamic>;
      return (parsedData['records'] as List<dynamic>).map((e) {
        return ProductModel.fromJson(e);
      }).toList();
    } catch (e) {
      log(e.toString());
      throw Error();
    }
  }

  //GetProducts API
  Future<List<ProductModel>> getCartProducts() async {
    log("GetCart Products Inprogress");
    Map<String, dynamic> customerDetails =
        authIdGetStorage.read(authIdGetStorageKey);
    log("===========GETCARTPRODUCTS===============");
    log(customerDetails['auth_id']);
    log("$cartProducts" "${customerDetails['auth_id']}");
    log("===========GETCARTPRODUCTS===============");

    try {
      var response = await http.get(
        Uri.parse("$cartProducts" "${customerDetails['auth_id']}"),
      );
      log(response.body.toString());
      Map<String, dynamic> parsedData =
          jsonDecode(response.body) as Map<String, dynamic>;
      return (parsedData['data'] as List<dynamic>).map((e) {
        return ProductModel.fromJson(e);
      }).toList();
    } catch (e) {
      log(e.toString());
      throw Error();
    }
  }

  //Add To Cart API
  Future<Map<String, dynamic>> addToCart(
      Map<String, dynamic> cartPayload) async {
    log("AddToCart Products Inprogress");
    Map<String, dynamic> customerDetails =
        authIdGetStorage.read(authIdGetStorageKey);
    log("===========ADDTOCART===============");
    log(customerDetails['auth_id']);
    log(customerDetails['mobile_no']);
    log("===========ADDTOCART===============");
    cartPayload['mobile_no'] = customerDetails['mobile_no'];
    try {
      var response = await http.post(
        Uri.parse(
          addCart.toString(),
        ),
        headers: {"AuthId": customerDetails['auth_id']},
        body: jsonEncode(cartPayload),
      );

      log(response.body.toString());
      Map<String, dynamic> parsedData =
          jsonDecode(response.body) as Map<String, dynamic>;
      return parsedData;
    } catch (e) {
      log(e.toString());
      throw Error();
    }
  }

  //Profile Api

  Future<ProfileModel> getMyProfileDetails() async {
    log("Profile Api Inprogress");
    Map<String, dynamic> customerDetails =
        authIdGetStorage.read(authIdGetStorageKey);
    log("===========GETMYPROFILE===============");

    log(customerDetails['auth_id']);
    log("$profile" "${customerDetails['auth_id']}");
    log("===========GETMYPROFILE===============");

    try {
      var response = await http.get(
        Uri.parse("$profile" "${customerDetails['auth_id']}"),
      );
      log(response.body.toString());
      Map<String, dynamic> parsedData =
          jsonDecode(response.body) as Map<String, dynamic>;
      return ProfileModel.fromJson(parsedData['customer']);
    } catch (e) {
      log(e.toString());
      throw "getMyProfile Failed...";
    }
  }

  //Register Account API

  Future<Map<String, dynamic>> registerAccount(
      RegisterModel registerModel) async {
    log("CreateAccount Api Inprogress");
    log("===========CreateAccount===============");
    log(registerModel.toString());
    log(account.toString());
    log(jsonEncode(registerModel).toString());
    log("===========CreateAccount===============");

    try {
      log("API CALLED");
      var response = await http.post(
        Uri.parse(account),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": registerModel.name,
          "email": registerModel.email,
          "mobile_no": registerModel.mobileNo,
          "password": registerModel.password
        }),
      );
      log(response.body.toString());
      if (response.statusCode == 200) {
        Map<String, dynamic> parsedData =
            jsonDecode(response.body) as Map<String, dynamic>;
        return parsedData;
      } else {
        Map<String, dynamic> parsedData =
            jsonDecode(response.body) as Map<String, dynamic>;
        return parsedData;
      }
    } catch (e) {
      log(e.toString());
      throw "CreateAccount Failed...";
    }
  }

  //Login With Password Account API

  Future<Map<String, dynamic>> loginWithPassword(
      {required String emailMobile, required String password}) async {
    log("Login With Password Api Inprogress");
    log("===========Login With Password===============");
    log(emailMobile.toString());
    log(password.toString());
    log("===========Login With Password===============");

    try {
      var response = await http.post(
        Uri.parse(loginPassword),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email_mobile": emailMobile, "password": password}),
      );
      log(response.body.toString());
      if (response.statusCode == 200) {
        Map<String, dynamic> parsedData =
            jsonDecode(response.body) as Map<String, dynamic>;
        return parsedData;
      } else {
        Map<String, dynamic> parsedData =
            jsonDecode(response.body) as Map<String, dynamic>;
        return parsedData;
      }
    } catch (e) {
      log(e.toString());
      throw "CreateAccount Failed...";
    }
  }
}
