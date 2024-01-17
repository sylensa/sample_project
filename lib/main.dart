import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sample_project/controllers/shared_preference.dart';
import 'package:sample_project/core/helpers/helper.dart';
import 'package:sample_project/models/users.dart';
import 'package:sample_project/views/home_page.dart';
import 'package:sample_project/views/register.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  UserPreferences.prefs = await SharedPreferences.getInstance();
  runApp(
      const ProviderScope(child: MyApp())
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final Widget redirectPage;
  getPageRedirection() {
    return FutureBuilder(
      future: UserPreferences().getUser(),
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          default:
            if (snapshot.data != null) {
              return   HomePage();
            } else if (snapshot.data == null) {
              return  const RegistrationPage();
            } else {
              return const CircularProgressIndicator(
                color: appMainTextColor,
              );
            }
        }
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    redirectPage = getPageRedirection();
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'App Local',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: redirectPage

     ,
    );
  }
}


