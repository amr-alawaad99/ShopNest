import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopnest/cache/cache_helper.dart';
import 'package:shopnest/const/constants.dart';
import 'package:shopnest/core/api/end_points.dart';
import 'package:shopnest/cubit/main_cubit.dart';
import 'package:shopnest/models/user_model.dart';
import 'package:shopnest/screens/sign_in_screen.dart';
import 'package:shopnest/widgets/account_row_card.dart';
import 'package:shopnest/widgets/custom_button.dart';
import 'package:shopnest/widgets/custom_input_field.dart';

import '../cubit/main_state.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserModel? userModel = context.read<MainCubit>().userModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Account settings",
          style: TextStyle(color: Constants.secondaryColor),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(10.h),
          child: Container(width: double.infinity, height: 0.5, color: Colors.black,),
        ),
      ),
      body: FutureBuilder<UserModel?>(
        // if the data already loaded don't call the method
        future: userModel == null
            ? context.read<MainCubit>().getUserProfile()
            : null,
        initialData: userModel,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error Getting data: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            return BlocBuilder<MainCubit, MainState>(
              builder: (context, state) {
                return Column(
                  children: [
                    AccountRowCard(title: "Name", text: snapshot.data!.name!, onTap: () {},),
                    AccountRowCard(title: "PhoneNumber", text: snapshot.data!.phone!, onTap: () {},),
                    AccountRowCard(title: "Email address", text: snapshot.data!.email!, onTap: () {},),
                    AccountRowCard(title: "Logout", text: "Logout and return to sign-in page", onTap: () {
                      context.read<MainCubit>().logout();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInScreen(),
                        ),
                            (route) => false,
                      );
                    },),
                  ],
                );
              },
            );
          } else {
            return const Center(child: Text("No Data Available"));
          }
        },
      ),
    );
  }
}
