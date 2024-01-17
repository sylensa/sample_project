import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/utils.dart';
import 'package:sample_project/controllers/shared_preference.dart';
import 'package:sample_project/core/helpers/helper.dart';
import 'package:sample_project/views/home_page.dart';

class UserController{

  Future<void> registerUser(BuildContext context,{String username = "",String localArea = "", double mileRadius = 0.00}) async {

    if (username.isNotEmpty && localArea.isNotEmpty && mileRadius > 0) {
      // Save user data to shared preferences
    final response = await  UserPreferences().setUser({
       "username":username,
       "localArea":localArea,
       "mileRadius":mileRadius,
     });
    if(response){
      Get.offAll(() => HomePage());
    }else{
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: sText('Alert'),
          content: sText('Saving user etails failed, try again'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: sText('OK'),
            ),
          ],
        ),
      );
    }
    } else {
      // Show an error message or handle invalid input
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: sText('Invalid Input'),
          content: sText('Please fill in all the fields with valid data.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: sText('OK'),
            ),
          ],
        ),
      );

    }
  }
}