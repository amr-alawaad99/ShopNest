import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopnest/const/constants.dart';
import 'package:shopnest/cubit/main_cubit.dart';
import 'package:shopnest/cubit/main_state.dart';

import 'package:shopnest/screens/layout_screen.dart';
import 'package:shopnest/screens/sign_up_screen.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_input_field.dart';

class SignInScreen extends StatelessWidget {

  const SignInScreen({super.key});

  static final TextEditingController emailController = TextEditingController();
  static final TextEditingController passwordController = TextEditingController();
  static final GlobalKey<FormState> formKey = GlobalKey();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) async {
        if (state is SignInSuccessState && !state.state) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is SignInSuccessState && state.state) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LayoutScreen(),), (route) => false,);
        } else if (state is SignInFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 35.w),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [

                      /// Header Image
                      SizedBox(
                        width: double.infinity,
                        height: 270.h,
                        child: Image.asset(
                            'assets/images/signin_background_pic.png'),
                      ),

                      /// Header Text (Sign-in)
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text("Sign-in",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 50.sp,
                            fontWeight: FontWeight.bold,
                          ),),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),

                      /// Email
                      CustomInputField(labelText: 'Email',
                        hintText: 'Your Email',
                        controller: emailController,),
                      SizedBox(
                        height: 25.h,
                      ),

                      /// Password
                      CustomInputField(labelText: 'Password',
                        hintText: 'Your Password',
                        suffixIcon: true,
                        obscureText: true,
                        controller: passwordController,),
                      SizedBox(
                        height: 25.h,
                      ),

                      /// "Forgot password?" TextButton
                      Container(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text("Forgot password?", style: TextStyle(color: Constants.secondaryColor),),
                        ),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),

                      /// Sign-in button
                      state is SignInLoadingState
                          ? CircularProgressIndicator(color: Constants.secondaryColor,)
                          : CustomButton(
                        onPressed: () {
                          context.read<MainCubit>().signIn(email: emailController
                              .text, password: passwordController.text);
                        },
                        innerText: "Sign-in",
                      ),
                      SizedBox(
                        height: 25.h,
                      ),

                      /// "Don't have and account? Sign-up"
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have and account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => const SignUpScreen(),));
                            },
                            child: Text('Sign-up', style: TextStyle(color: Constants.secondaryColor),),),
                        ],
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
