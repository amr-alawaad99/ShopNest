import 'package:flutter/material.dart';
import 'package:shopnest/cache/cache_helper.dart';
import 'package:shopnest/core/api/end_points.dart';
import 'package:shopnest/screens/sign_in_screen.dart';
import 'package:shopnest/widgets/custom_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomButton(innerText: "Logout", onPressed: () {
          CacheHelper().removeData(key: ApiKey.token);
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignInScreen(),), (route) => false,);

        },),
      ),
    );;
  }
}
