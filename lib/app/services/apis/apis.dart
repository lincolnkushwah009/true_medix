String baseUrlProd = "https://truemedix.in/apis/v1/";

//? Login With OTP Endpoint
//!========================

String loginWithOtp = "${baseUrlProd}customers/loginOtp";
String loginOtpVerify = "${baseUrlProd}customers/loginOTPVerify";
String getMyProfile = "${baseUrlProd}customers/profile?AuthId=";
String runningBanners = "${baseUrlProd}contents/banners";
String products = "${baseUrlProd}contents/products";
String cartProducts = "${baseUrlProd}carts/getCartProducts?AuthId=";
String addCart = "${baseUrlProd}carts/cartProducts";
String profile = "${baseUrlProd}customers/profile?AuthId=";
String account = "${baseUrlProd}customers/register";
String loginPassword = "${baseUrlProd}customers/login";
String addAddressApi = "${baseUrlProd}customers/addressForm";
String getAddressApi = "${baseUrlProd}customers/myaddress?AuthId=";
String placeOrderApi = "${baseUrlProd}orders/placeOrder";
String orderApi = "${baseUrlProd}orders/myOrders?AuthId=";
String statusList = "${baseUrlProd}orders/getStatusList?AuthId=";
String updateProfileApi = "$baseUrlProd/customers/updateProfile";
String deleteAddressApi = "$baseUrlProd/customers/deleteAddress/";
String orderDetailsApi = "$baseUrlProd/orders/myOrderDetail?";
