import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sample_project/models/users.dart';
import 'package:sample_project/views/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

String FORCE_UPDATE = "shouldForceUpdate";
final sharedPrefsProvider =
Provider<SharedPreferences>((ref) => throw UnimplementedError());
class UserPreferences {
  static late SharedPreferences _prefs;
  static set prefs(SharedPreferences prefs) => _prefs = prefs;

  static SharedPreferences get instance => _prefs;
  Future setSeenOnboard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('seenOnboard', true);
    return true;
  }

  Future setPdfDownload() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('pdf', true);
    return true;
  }

  Future<bool> getPdfDownload() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool value = prefs.getBool("pdf") ?? false;
    return value ;
  }

  Future setUserLoggedIn({bool isLoggedIn = false}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('loggedin', isLoggedIn);
    return true;
  }

  Future setLanguageCode({String languageCode = 'en'}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('languageCode', languageCode);
    return true;
  }
  Future setCountryCode({String countryCode = 'US'}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('countryCode', countryCode);
    return true;
  }
  getLanguageCode()  {
    try{
      String? value = _prefs.getString("languageCode") ?? Platform.localeName.split("_").first.toLowerCase();
      return value ;
    }
    catch(e){
      return "en" ;
    }

  }

  Future<String?> getCountryCode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString("countryCode");
    return value ?? '';
  }

  Future<bool?> getUserLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? value = prefs.getBool("loggedin");
    return value ?? false;
  }

  Future<bool> setUser(var user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user", jsonEncode(user));
    return true;
  }

  Future<UserModel?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString("user");
    if(user != null){
      print("user:$user");
      return UserModel.fromJson(jsonDecode(user)) ;
    }
    return null;
  }

   removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<String?> getUserToken() async {
    return getUserValue("token");
  }

  Future<String?> getUserRefreshToken() async {
    return getUserValue("refresh_token");
  }

  Future<String?> getGender() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString("gender");
    if(value == null){
      value = "male";
    }else{
      if(value.isEmpty){
        value = "male";
      }
    }
    return value;
  }
  Future<String?> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString("userId");
    return value;
  }
  Future<bool?> setUserId(String id) async {
    print("userId setting:$id");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool value = await prefs.setString("userId",id);
    return value;
  }
  Future<bool?> setGender(String gender) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool value = await prefs.setString("gender",gender);
    return value;
  }

  Future<String?> getUserValue(args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString(args);
    return value;
  }


  Future<int?> getIntValue(args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? value = prefs.getInt(args);
    return value;
  }


  Future<bool> shouldForceUpdate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(FORCE_UPDATE) ?? false;
  }

  Future<bool> setShouldForceUpdate(bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setBool(FORCE_UPDATE, value);
  }
  setToken(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('token', value);
  }

  setRefreshToken(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('refresh_token', value);
  }
  getPushNotificationToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString('pushNotificationToken');
    print('push notification token => $token');
    return token;
  }

  setPushNotificationToken(String value) async {
    print("pushNotificationToken:$value");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('pushNotificationToken', value);
  }

  logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    Get.offAll(() =>  RegistrationPage(),);

  }
}
