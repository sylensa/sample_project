import 'package:flutter/material.dart';
import 'package:sample_project/controllers/user_controller.dart';
import 'package:sample_project/core/helpers/helper.dart';
import 'package:sample_project/views/home_page.dart';
import 'package:sample_project/views/widget/custom_text_fieldd.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController localAreaController = TextEditingController();
  final TextEditingController radiusController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: sText('App Local  Registration',size: 20,weight: FontWeight.bold),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              placeholder: "Username",
              controller: usernameController,
              onChange: (value){},
            ),
            SizedBox(height: 20,),
            CustomTextField(
              placeholder: "Local Area",
              controller: localAreaController,
              onChange: (value){},
            ),
            SizedBox(height: 20,),
            CustomTextField(
              placeholder: "Mile Radius",
              controller: radiusController,
              textInputType: TextInputType.number,
              onChange: (value){},
            ),

            SizedBox(height: 16.0),
            dPurpleGradientButton(
              onPressed: () => UserController().registerUser(context,username: usernameController.text,localArea: localAreaController.text,mileRadius:double.tryParse(radiusController.text) ?? 0.00),
              content: sText("Register",color: Colors.white,weight: FontWeight.bold,size: 20)
            )

          ],
        ),
      ),
    );
  }


}
