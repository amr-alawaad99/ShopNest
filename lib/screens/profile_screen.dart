import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopnest/cache/cache_helper.dart';
import 'package:shopnest/core/api/end_points.dart';
import 'package:shopnest/cubit/main_cubit.dart';
import 'package:shopnest/models/user_model.dart';
import 'package:shopnest/screens/sign_in_screen.dart';
import 'package:shopnest/widgets/custom_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserModel? userModel = context.read<MainCubit>().userModel;
    userModel == null? context.read<MainCubit>().getUserProfile() : null;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Profile", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(10.h),
          child: Container(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(35.sp),
        child: Column(
          children: [
            Text("Name  ${userModel!.name}"),
            Text("Email: ${userModel.email}"),
            Text("Phone Number: ${userModel.phone}"),

            CustomButton(innerText: "Logout", onPressed: () {
              CacheHelper().removeData(key: ApiKey.token);
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const SignInScreen(),), (route) => false,);

            },),
          ],
        ),
      ),
    );;
  }
}
