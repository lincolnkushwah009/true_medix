import 'dart:developer';

import 'package:get_storage/get_storage.dart';

class LocalStorage {
  GetStorage authIdGetStorage = GetStorage();
  String authIdGetStorageKey = "AUTHID";

  void storeUserDetails(Map<String, dynamic> value) async {
    log('LOCAL STORAGE SETTER');
    await authIdGetStorage.write(authIdGetStorageKey, value).then((value) {
      log("CUSTOMER STORED SUCCESSFULLY....");
      getCustomer;
    }).onError((error, stackTrace) {
      log("CUSTOMER STORED FAILED....");
    });
  }

  dynamic get getCustomer {
    log('LOCAL STORAGE GETTER');
    log(authIdGetStorage.read(authIdGetStorageKey).toString());
    return authIdGetStorage.read(authIdGetStorageKey);
  }
}
