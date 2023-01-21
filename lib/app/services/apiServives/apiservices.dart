import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:true_medix/app/global/customermodel.dart';
import 'package:true_medix/app/modules/activeorders/model/ordermodel.dart';
import 'package:true_medix/app/modules/booking/model/placeorderresponsemodel.dart';
import 'package:true_medix/app/modules/home/models/bannermodel.dart';
import 'package:true_medix/app/modules/pamentsummary/models/orderresponsemodel.dart';
import 'package:true_medix/app/modules/productdetail/models/productmodel.dart';
import 'package:true_medix/app/modules/profile/model/addressmodel.dart';
import 'package:true_medix/app/modules/profile/model/getaddressmodel.dart';
import 'package:true_medix/app/modules/profile/model/profilemodel.dart';
import 'package:true_medix/app/modules/profile/model/updateprofilemodel.dart';
import 'package:true_medix/app/modules/register/model/registermodel.dart';
import 'package:true_medix/app/services/apiResponse/apiresponse.dart';
import 'package:true_medix/app/services/apis/apis.dart';
import 'package:true_medix/app/services/sessionmanager.dart';

class ApiServices {
  String authIdGetStorageKey = "AUTHID";
  SessionManager sessionManager = SessionManager();

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
  Future<List<ProductModel>> getProducts(
      {String page = "1", String? query = "arunodaya"}) async {
    log("Api Products Inprogress");
    log("$products?page=$page&q=$query");
    try {
      var response = await http.get(
        Uri.parse("$products?page=$page&q=$query"),
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
    CustomerModel customerDetails = (await sessionManager.getAuthToken());
    log("===========GETCARTPRODUCTS===============");
    log(customerDetails.toString());
    log(customerDetails.authId.toString());
    log("$cartProducts" "${customerDetails.authId}");
    log("===========GETCARTPRODUCTS===============");
    log(customerDetails.toString());

    try {
      var response = await http.get(
        Uri.parse("$cartProducts" "${customerDetails.authId}"),
      );
      log(response.body.toString());
      Map<String, dynamic> parsedData =
          jsonDecode(response.body) as Map<String, dynamic>;
      List<ProductModel> tryList = [];
      tryList = (parsedData['data'] as List<dynamic>).map((e) {
        return ProductModel.fromJson(e);
      }).toList();
      log("====================$tryList");
      return tryList;
    } catch (e) {
      log("ERROR HERE...");
      log(e.toString());
      throw Error();
    }
  }

  //Add To Cart API
  Future<Map<String, dynamic>> addToCart(
      Map<String, dynamic> cartPayload) async {
    log("AddToCart Products Inprogress");
    CustomerModel customerDetails = await sessionManager.getAuthToken();
    log("===========ADDTOCART===============");
    log(customerDetails.authId.toString());
    log(customerDetails.mobileNo.toString());
    log("===========ADDTOCART===============");
    cartPayload['mobile_no'] = customerDetails.mobileNo.toString();
    try {
      var response = await http.post(
        Uri.parse(
          addCart.toString(),
        ),
        headers: {"AuthId": customerDetails.authId.toString()},
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
    CustomerModel customerDetails = await sessionManager.getAuthToken();

    log("===========GETMYPROFILE===============");
    log(customerDetails.authId.toString());
    log("$profile" "${customerDetails.authId}");
    log("===========GETMYPROFILE===============");

    try {
      var response = await http.get(
        Uri.parse("$profile" "${customerDetails.authId}"),
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

  //Add Address API

  Future<Map<String, dynamic>> addAddress(AddressModel addressModel) async {
    CustomerModel customerDetails = await sessionManager.getAuthToken();
    log("===========Add Address API===============");
    log(addressModel.id.toString());
    log("===========Add Address API===============");

    try {
      var response = await http.post(
        Uri.parse(addAddressApi),
        headers: {
          "Content-Type": "application/json",
          "AuthId": customerDetails.authId.toString()
        },
        body: jsonEncode(addressModel),
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
      throw "Add Address API Failed...";
    }
  }

  //Get Address API

  Future<List<GetAddressModel>> getAddress() async {
    CustomerModel customerDetails = await sessionManager.getAuthToken();
    log("Get Address APIInprogress");
    try {
      var response = await http.get(
        Uri.parse("$getAddressApi${customerDetails.authId}"),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> parsedData =
            jsonDecode(response.body) as Map<String, dynamic>;
        List<dynamic> dataItems = parsedData['data'] as List<dynamic>;
        log(dataItems.toString());
        return dataItems.map((e) {
          return GetAddressModel.fromJson(e);
        }).toList();
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString());
      throw Exception("Get Address API Failed...");
    }
  }

  //Place Order API

  Future<PlaceOrderResponseModel> placeOrderService(
      Map<String, dynamic> payLoad) async {
    CustomerModel customerDetails = await sessionManager.getAuthToken();
    log("Place Order API In Progress");
    log(payLoad.toString());
    try {
      var response = await http.post(
        Uri.parse(placeOrderApi),
        headers: {
          "Content-Type": "application/json",
          "AuthId": customerDetails.authId.toString()
        },
        body: jsonEncode(payLoad),
      );
      if (response.statusCode == 200) {
        log("88888888888");
        log(response.body);
        Map<String, dynamic> parsedData =
            jsonDecode(response.body) as Map<String, dynamic>;
        PlaceOrderResponseModel responseData =
            PlaceOrderResponseModel.fromJson(parsedData);
        log(responseData.toString());
        return responseData;
      } else {
        log(response.body);
        log("FAILED PLACEORDER API");
        return PlaceOrderResponseModel(message: "", orderId: "");
      }
    } catch (e) {
      log(e.toString());
      throw Exception("PlaceOrder API Failed...");
    }
  }

  //Order API

  Future<List<OrderModel>> orderService() async {
    CustomerModel customerDetails = await sessionManager.getAuthToken();

    log("Order API In Progress");
    log(orderApi + customerDetails.authId.toString());
    try {
      var response = await http.get(
        Uri.parse(orderApi + customerDetails.authId.toString()),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> parsedData =
            jsonDecode(response.body) as Map<String, dynamic>;
        List<OrderModel> activeOrderData = [];
        (parsedData['data'] as List<dynamic>).map((e) {
          activeOrderData.add(OrderModel.fromJson(e));
        }).toList();
        log("========================");
        log(activeOrderData.toList().toString());
        List<OrderModel> tempActiveOrderData = List.from(activeOrderData);
        tempActiveOrderData.removeWhere((element) {
          return element.status == "7" &&
              element.status == "13" &&
              element.status == "14" &&
              element.status == "20";
        });
        log(">>>>>>>>>>>>>>>>>>>>>>>>>");
        log(tempActiveOrderData.toString());
        return tempActiveOrderData;
      } else {
        log(response.body);
        log("FAILED PASTORDER API");
        return [];
      }
    } catch (e) {
      log(e.toString());
      throw Exception("ORDER API Failed...");
    }
  }

  //Past Orders API

  Future<List<OrderModel>> pastrderService() async {
    CustomerModel customerDetails = await sessionManager.getAuthToken();

    log("Past Order API In Progress");
    try {
      var response = await http.get(
        Uri.parse(orderApi + customerDetails.authId.toString()),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> parsedData =
            jsonDecode(response.body) as Map<String, dynamic>;
        List<OrderModel> data = [];
        List<OrderModel> postOrderData = [];
        (parsedData['data'] as List<dynamic>).map((e) {
          data.add(OrderModel.fromJson(e));
        }).toList();
        data.map((e) {
          if (e.status == "7" ||
              e.status == "13" ||
              e.status == "14" ||
              e.status == "20") {
            log(e.toString());
            return postOrderData.add(e);
          }
        }).toList();
        log(postOrderData.toString());
        return postOrderData;
      } else {
        log(response.body);
        log("FAILED PASTORDER API");
        return [];
      }
    } catch (e) {
      log(e.toString());
      throw Exception("PASTORDER API Failed...");
    }
  }

  //getStatusList API

  Future<Map<String, dynamic>> getStatusList() async {
    CustomerModel customerDetails = await sessionManager.getAuthToken();

    log("GetStatus List API In Progress");
    try {
      var response = await http.get(
        Uri.parse(statusList + customerDetails.authId.toString()),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> parsedData =
            jsonDecode(response.body) as Map<String, dynamic>;
        Map<String, dynamic> data = parsedData['data'];
        return data;
      } else {
        log("FAILED STATUSLIST API");
        return {};
      }
    } catch (e) {
      log(e.toString());
      throw Exception("STATUSLIST API Failed...");
    }
  }

  // Update Profile API

  Future<void> updateProfile(UpdateProfileModel updateProfileModel) async {
    CustomerModel customerDetails = await sessionManager.getAuthToken();
    log("Update Profile API In Progress");
    log(updateProfileModel.toString());
    try {
      var response = await http.post(
        Uri.parse(updateProfileApi),
        headers: {
          "Content-Type": "application/json",
          "AuthId": customerDetails.authId.toString()
        },
        body: jsonEncode(updateProfileModel),
      );
      if (response.statusCode == 200) {
        log(response.body);
      } else {}
    } catch (e) {
      log(e.toString());
      throw Exception("UpdateProfile API Failed...");
    }
  }

  //Delete Customer Address API

  Future<int> deleteCustomerAddress(String id) async {
    CustomerModel customerDetails = await sessionManager.getAuthToken();

    log("Delete Address Api API In Progress");
    log("$deleteAddressApi$id?AuthId=${customerDetails.authId}");
    try {
      var response = await http.delete(
        Uri.parse("$deleteAddressApi$id?AuthId=${customerDetails.authId}"),
      );
      if (response.statusCode == 200) {
        int parsedData = jsonDecode(response.body) as int;
        return parsedData;
      } else {
        log("FAILED Delete Customer API");
        return 0;
      }
    } catch (e) {
      log(e.toString());
      throw Exception("Delete Customer API Failed...");
    }
  }

  //Order Details API

  Future<OrderResponseModel?> orderDetailsService(String orderId) async {
    CustomerModel customerDetails = await sessionManager.getAuthToken();
    log("Order Details List API In Progress");
    log("${orderDetailsApi}AuthId=${customerDetails.authId}&Oid=$orderId");
    try {
      var response = await http.get(
        Uri.parse(
            "${orderDetailsApi}AuthId=${customerDetails.authId}&Oid=$orderId"),
      );

      log("=====================================");
      log(response.body.toString());
      log("=====================================");

      if (response.statusCode == 200) {
        Map<String, dynamic> parsedData =
            jsonDecode(response.body) as Map<String, dynamic>;
        OrderResponseModel orderResponseModel =
            OrderResponseModel.fromJson(parsedData);
        return orderResponseModel;
      } else {
        log("Order Details API");
        return null;
      }
    } catch (e) {
      log(e.toString());
      throw Exception("Order Details Failed...");
    }
  }
}
