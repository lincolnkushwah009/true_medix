import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:true_medix/app/global/customermodel.dart';

class SessionManager {
  final String authToken = "AUTHID";
//set data into shared preferences like this
  Future<void> setAuthToken(Map<String, dynamic> value) async {
    log("Sharedpreference setAuthToken Called...");
    log(value.toString());
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(authToken, value.toString());
  }

  jsonStringToMap(String data) {
    List<String> str = data
        .replaceAll("{", "")
        .replaceAll("}", "")
        .replaceAll("\"", "")
        .replaceAll("'", "")
        .split(",");
    Map<String, dynamic> result = {};
    for (int i = 0; i < str.length; i++) {
      List<String> s = str[i].split(":");
      result.putIfAbsent(s[0].trim(), () => s[1].trim());
    }
    log(result.toString());
    return result;
  }

//get value from shared preferences
  Future<CustomerModel> getAuthToken() async {
    log("Sharedpreference getAuth Called...");
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String authToken = pref.getString(this.authToken) ?? "null";
    if (authToken == "null") {
      return CustomerModel(authId: null);
    } else {
      log(authToken.toString());
      jsonStringToMap(authToken);
      log('SESSION DATA');
      CustomerModel customerModel =
          CustomerModel.fromJson(jsonStringToMap(authToken));
      log(customerModel.email.toString());
      return customerModel;
    }
  }

  // Session Getter
  Map<String, dynamic> get getCustomer {
    return {};
  }
}
