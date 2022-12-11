import 'dart:convert';

String baseUrlProd = "https://www.hiyutech.in/truemedex/apis/v1/";

//? Login With OTP Endpoint
//!========================

String loginWithOtp = "${baseUrlProd}customers/loginOtp";
String loginOtpVerify = "${baseUrlProd}customers/loginOTPVerify";
String getMyProfile = "${baseUrlProd}customers/profile?AuthId=";
String runningBanners = "${baseUrlProd}contents/banners";
String products = "${baseUrlProd}contents/products";
