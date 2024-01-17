import 'package:flutter/material.dart';
import 'package:sample_project/controllers/shared_preference.dart';
import 'package:sample_project/core/helpers/helper.dart';
import 'package:sample_project/models/users.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  sText('App Local Home Page',color: appMainTextColor,weight: FontWeight.bold,size: 20),
        actions: [
          IconButton(onPressed: (){
            UserPreferences().logout();
          }, icon: Icon(Icons.logout))
        ],
      ),
      body: FutureBuilder<UserModel?>(
        future: UserPreferences().getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return  Center(child: sText('Error loading user data:${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return  Center(child: sText('No user data found'));
          }
          final user = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                sText('Username: ${user.username}'),
                sText('Local Area: ${user.localArea}'),
                sText('Mile Radius: ${user.mileRadius}'),
              ],
            ),
          );
        },
      ),
    );
  }


}
