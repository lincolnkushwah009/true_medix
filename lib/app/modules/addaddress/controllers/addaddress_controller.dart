// ignore_for_file: constant_identifier_names, unnecessary_null_comparison

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:true_medix/app/services/localstorage.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import '../../../services/apiServives/apiservices.dart';

class AddaddressController extends GetxController {
  ApiServices apiServices = ApiServices();
  LocalStorage localStorage = LocalStorage();
  RxString validationMessageName = "".obs;
  RxString validationMessageAge = "".obs;
  RxString validationMessageGender = "".obs;
  RxString validationMessageDob = "".obs;
  RxString validationMessageEmail = "".obs;
  RxString validationMessagePhone = "".obs;
  RxString validationMessageAddress = "".obs;
  RxString validationMessageCountry = "".obs;
  RxString validationMessageState = "".obs;
  RxString validationMessagePincode = "".obs;

  //Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController goolePlacesController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();

  //Dropdowns and Target Variables
  RxInt selectedAge = 0.obs;
  List<int> dropdownAge = List.generate(101, (index) => index);
  RxString selectedGender = "Male".obs;
  List<String> dropdownGender = ["Male", "Female", "Other"];
  RxString selectedDob = ("${DateTime.now()}").obs;

  Map<String, dynamic> countries = {
    "1": "AFGHANISTAN",
    "2": "ALBANIA",
    "3": "ALGERIA",
    "4": "AMERICAN SAMOA",
    "5": "ANDORRA",
    "6": "ANGOLA",
    "7": "ANGUILLA",
    "8": "ANTARCTICA",
    "9": "ANTIGUA AND BARBUDA",
    "10": "ARGENTINA",
    "11": "ARMENIA",
    "12": "ARUBA",
    "13": "AUSTRALIA",
    "14": "AUSTRIA",
    "15": "AZERBAIJAN",
    "16": "BAHAMAS",
    "17": "BAHRAIN",
    "18": "BANGLADESH",
    "19": "BARBADOS",
    "20": "BELARUS",
    "21": "BELGIUM",
    "22": "BELIZE",
    "23": "BENIN",
    "24": "BERMUDA",
    "25": "BHUTAN",
    "26": "BOLIVIA",
    "27": "BOSNIA AND HERZEGOVINA",
    "28": "BOTSWANA",
    "29": "BOUVET ISLAND",
    "30": "BRAZIL",
    "31": "BRITISH INDIAN OCEAN TERRITORY",
    "32": "BRUNEI DARUSSALAM",
    "33": "BULGARIA",
    "34": "BURKINA FASO",
    "35": "BURUNDI",
    "36": "CAMBODIA",
    "37": "CAMEROON",
    "38": "CANADA",
    "39": "CAPE VERDE",
    "40": "CAYMAN ISLANDS",
    "41": "CENTRAL AFRICAN REPUBLIC",
    "42": "CHAD",
    "43": "CHILE",
    "44": "CHINA",
    "45": "CHRISTMAS ISLAND",
    "46": "COCOS (KEELING) ISLANDS",
    "47": "COLOMBIA",
    "48": "COMOROS",
    "49": "CONGO",
    "50": "CONGO, THE DEMOCRATIC REPUBLIC OF THE",
    "51": "COOK ISLANDS",
    "52": "COSTA RICA",
    "53": "COTE D'IVOIRE",
    "54": "CROATIA",
    "55": "CUBA",
    "56": "CYPRUS",
    "57": "CZECH REPUBLIC",
    "58": "DENMARK",
    "59": "DJIBOUTI",
    "60": "DOMINICA",
    "61": "DOMINICAN REPUBLIC",
    "62": "ECUADOR",
    "63": "EGYPT",
    "64": "EL SALVADOR",
    "65": "EQUATORIAL GUINEA",
    "66": "ERITREA",
    "67": "ESTONIA",
    "68": "ETHIOPIA",
    "69": "FALKLAND ISLANDS (MALVINAS)",
    "70": "FAROE ISLANDS",
    "71": "FIJI",
    "72": "FINLAND",
    "73": "FRANCE",
    "74": "FRENCH GUIANA",
    "75": "FRENCH POLYNESIA",
    "76": "FRENCH SOUTHERN TERRITORIES",
    "77": "GABON",
    "78": "GAMBIA",
    "79": "GEORGIA",
    "80": "GERMANY",
    "81": "GHANA",
    "82": "GIBRALTAR",
    "83": "GREECE",
    "84": "GREENLAND",
    "85": "GRENADA",
    "86": "GUADELOUPE",
    "87": "GUAM",
    "88": "GUATEMALA",
    "89": "GUINEA",
    "90": "GUINEA-BISSAU",
    "91": "GUYANA",
    "92": "HAITI",
    "93": "HEARD ISLAND AND MCDONALD ISLANDS",
    "94": "HOLY SEE (VATICAN CITY STATE)",
    "95": "HONDURAS",
    "96": "HONG KONG",
    "97": "HUNGARY",
    "98": "ICELAND",
    "99": "INDIA",
    "100": "INDONESIA",
    "101": "IRAN, ISLAMIC REPUBLIC OF",
    "102": "IRAQ",
    "103": "IRELAND",
    "104": "ISRAEL",
    "105": "ITALY",
    "106": "JAMAICA",
    "107": "JAPAN",
    "108": "JORDAN",
    "109": "KAZAKHSTAN",
    "110": "KENYA",
    "111": "KIRIBATI",
    "112": "KOREA, DEMOCRATIC PEOPLE'S REPUBLIC OF",
    "113": "KOREA, REPUBLIC OF",
    "114": "KUWAIT",
    "115": "KYRGYZSTAN",
    "116": "LAO PEOPLE'S DEMOCRATIC REPUBLIC",
    "117": "LATVIA",
    "118": "LEBANON",
    "119": "LESOTHO",
    "120": "LIBERIA",
    "121": "LIBYAN ARAB JAMAHIRIYA",
    "122": "LIECHTENSTEIN",
    "123": "LITHUANIA",
    "124": "LUXEMBOURG",
    "125": "MACAO",
    "126": "MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF",
    "127": "MADAGASCAR",
    "128": "MALAWI",
    "129": "MALAYSIA",
    "130": "MALDIVES",
    "131": "MALI",
    "132": "MALTA",
    "133": "MARSHALL ISLANDS",
    "134": "MARTINIQUE",
    "135": "MAURITANIA",
    "136": "MAURITIUS",
    "137": "MAYOTTE",
    "138": "MEXICO",
    "139": "MICRONESIA, FEDERATED STATES OF",
    "140": "MOLDOVA, REPUBLIC OF",
    "141": "MONACO",
    "142": "MONGOLIA",
    "143": "MONTSERRAT",
    "144": "MOROCCO",
    "145": "MOZAMBIQUE",
    "146": "MYANMAR",
    "147": "NAMIBIA",
    "148": "NAURU",
    "149": "NEPAL",
    "150": "NETHERLANDS",
    "151": "NETHERLANDS ANTILLES",
    "152": "NEW CALEDONIA",
    "153": "NEW ZEALAND",
    "154": "NICARAGUA",
    "155": "NIGER",
    "156": "NIGERIA",
    "157": "NIUE",
    "158": "NORFOLK ISLAND",
    "159": "NORTHERN MARIANA ISLANDS",
    "160": "NORWAY",
    "161": "OMAN",
    "162": "PAKISTAN",
    "163": "PALAU",
    "164": "PALESTINIAN TERRITORY, OCCUPIED",
    "165": "PANAMA",
    "166": "PAPUA NEW GUINEA",
    "167": "PARAGUAY",
    "168": "PERU",
    "169": "PHILIPPINES",
    "170": "PITCAIRN",
    "171": "POLAND",
    "172": "PORTUGAL",
    "173": "PUERTO RICO",
    "174": "QATAR",
    "175": "REUNION",
    "176": "ROMANIA",
    "177": "RUSSIAN FEDERATION",
    "178": "RWANDA",
    "179": "SAINT HELENA",
    "180": "SAINT KITTS AND NEVIS",
    "181": "SAINT LUCIA",
    "182": "SAINT PIERRE AND MIQUELON",
    "183": "SAINT VINCENT AND THE GRENADINES",
    "184": "SAMOA",
    "185": "SAN MARINO",
    "186": "SAO TOME AND PRINCIPE",
    "187": "SAUDI ARABIA",
    "188": "SENEGAL",
    "189": "SERBIA AND MONTENEGRO",
    "190": "SEYCHELLES",
    "191": "SIERRA LEONE",
    "192": "SINGAPORE",
    "193": "SLOVAKIA",
    "194": "SLOVENIA",
    "195": "SOLOMON ISLANDS",
    "196": "SOMALIA",
    "197": "SOUTH AFRICA",
    "198": "SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS",
    "199": "SPAIN",
    "200": "SRI LANKA",
    "201": "SUDAN",
    "202": "SURINAME",
    "203": "SVALBARD AND JAN MAYEN",
    "204": "SWAZILAND",
    "205": "SWEDEN",
    "206": "SWITZERLAND",
    "207": "SYRIAN ARAB REPUBLIC",
    "208": "TAIWAN, PROVINCE OF CHINA",
    "209": "TAJIKISTAN",
    "210": "TANZANIA, UNITED REPUBLIC OF",
    "211": "THAILAND",
    "212": "TIMOR-LESTE",
    "213": "TOGO",
    "214": "TOKELAU",
    "215": "TONGA",
    "216": "TRINIDAD AND TOBAGO",
    "217": "TUNISIA",
    "218": "TURKEY",
    "219": "TURKMENISTAN",
    "220": "TURKS AND CAICOS ISLANDS",
    "221": "TUVALU",
    "222": "UGANDA",
    "223": "UKRAINE",
    "224": "UNITED ARAB EMIRATES",
    "225": "UNITED KINGDOM",
    "226": "UNITED STATES",
    "227": "UNITED STATES MINOR OUTLYING ISLANDS",
    "228": "URUGUAY",
    "229": "UZBEKISTAN",
    "230": "VANUATU",
    "231": "VENEZUELA",
    "232": "VIET NAM",
    "233": "VIRGIN ISLANDS, BRITISH",
    "234": "VIRGIN ISLANDS, U.S.",
    "235": "WALLIS AND FUTUNA",
    "236": "WESTERN SAHARA",
    "237": "YEMEN",
    "238": "ZAMBIA",
    "239": "ZIMBABWE",
    "240": "DR Congo"
  };

  Map<String, dynamic> states = {
    "1": "Andaman & Nicobar Islands",
    "2": "Andhra Pradesh",
    "3": "Arunachal Pradesh",
    "4": "Assam",
    "5": "Bihar",
    "6": "Chandigarh",
    "7": "Chhattisgarh",
    "8": "Dadra & Nagar Haveli",
    "9": "Daman & Diu",
    "10": "Delhi",
    "11": "Goa",
    "12": "Gujarat",
    "13": "Haryana",
    "14": "Himachal Pradesh",
    "15": "Jammu & Kashmir",
    "16": "Jharkhand",
    "17": "Karnataka",
    "18": "Kerala",
    "19": "Lakshadweep",
    "20": "Madhya Pradesh",
    "21": "Maharashtra",
    "22": "Manipur",
    "23": "Meghalaya",
    "24": "Mizoram",
    "25": "Nagaland",
    "26": "Odisha",
    "27": "Puducherry",
    "28": "Punjab",
    "29": "Rajasthan",
    "30": "Sikkim",
    "31": "Tamil Nadu",
    "32": "Telangana",
    "33": "Tripura",
    "34": "Uttar Pradesh",
    "35": "Uttarakhand",
    "36": "West Bengal"
  };
  //Google Maps Place API
  Uuid uuid = const Uuid();
  RxString sessionToken = "".obs;
  RxString selectedAddress = "".obs;
  static const String kGOOGLE_API_KEY =
      "AIzaSyDg3FAxoRh2n3HwRQ2O61ueAXUKmNIAGSQ";
  static const String googlePlacesApiUrl =
      "https://maps.googleapis.com/maps/api/place/autocomplete/json";
  RxList responseGooglePlacesApi = [].obs;

  Future<void> getPlacesFromGoogleApi() async {
    String url =
        "$googlePlacesApiUrl?input=${selectedAddress.value.toString()}&key=$kGOOGLE_API_KEY&sessiontoken=$sessionToken";
    log(url.toString());
    try {
      var response = await http.get(Uri.parse(url));
      log(response.body.toString());
      if (response.statusCode == 200) {
        Map<String, dynamic> parsedData = jsonDecode(response.body);
        responseGooglePlacesApi.value = parsedData['predictions'];
      } else {}
    } catch (e) {
      throw Exception("FAILED TO GET DATA GOOGLE PLACES API");
    }
  }

  Future<String> getAddressFromLatLng(double lat, double lng) async {
    String host = 'https://maps.google.com/maps/api/geocode/json';
    final url = '$host?key=$kGOOGLE_API_KEY&language=en&latlng=$lat,$lng';
    if (lat != null && lng != null) {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        String formattedAddress = data["results"][0]["formatted_address"];
        log(" $formattedAddress");
        return formattedAddress;
      } else {
        return "null";
      }
    } else {
      return "";
    }
  }

  @override
  void onInit() async {
    log("AddAddress init");
    super.onInit();
  }

  @override
  void onClose() {
    log("AddAddress onClose");
    super.onClose();
  }
}
