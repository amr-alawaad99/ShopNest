
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopnest/const/constants.dart';
import 'package:shopnest/cubit/main_state.dart';

import 'package:shopnest/screens/sign_in_screen.dart';

import '../cubit/main_cubit.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input_field.dart';
import 'layout_screen.dart';

class SignUpScreen extends StatelessWidget {
  static final TextEditingController nameController = TextEditingController();
  static final TextEditingController emailController = TextEditingController();
  static final TextEditingController phoneNumberController = TextEditingController();
  static final TextEditingController addressController = TextEditingController();
  static final TextEditingController passwordController = TextEditingController();
  static final TextEditingController confirmPasswordController = TextEditingController();
  static final GlobalKey<FormState> formKey = GlobalKey();


  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        if (state is SignUpSuccessState && !state.state) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is SignUpSuccessState && state.state) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LayoutScreen(),), (route) => false,);
        } else if (state is SignUpFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(0.1.sw),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      // /// Profile Image & Image Picker
                      // Container(
                      //   alignment: Alignment.center,
                      //   child: Stack(
                      //     alignment: Alignment.bottomRight,
                      //     children: [
                      //       context.read<MainCubit>().profilePic == null
                      //           ? CircleAvatar(
                      //               radius: size.aspectRatio * 200,
                      //               backgroundImage: Constants.defaultUserImage,
                      //               backgroundColor: Colors.white,
                      //             )
                      //           : CircleAvatar(
                      //               radius: size.aspectRatio * 200,
                      //               backgroundImage: FileImage(File(context
                      //                   .read<MainCubit>()
                      //                   .profilePic!
                      //                   .path)),
                      //               backgroundColor: Colors.white,
                      //             ),
                      //       GestureDetector(
                      //         onTap: () {
                      //           context.read<MainCubit>().pickProfileImage();
                      //         },
                      //         child: Container(
                      //           width: size.aspectRatio * 100,
                      //           height: size.aspectRatio * 100,
                      //           decoration: BoxDecoration(
                      //               border:
                      //                   Border.all(color: Colors.white, width: 3),
                      //               borderRadius: BorderRadius.circular(25),
                      //               color: Colors.blue),
                      //           child: const Icon(
                      //             Icons.camera_alt,
                      //             color: Colors.white,
                      //           ),
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: size.height * 0.03,
                      // ),

                      /// Header Image
                      SizedBox(
                        width: double.infinity,
                        height: 270.h,
                        child: Image.asset('assets/images/signin_background_pic.png'),
                      ),

                      /// Header Text (Sign-in)
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text("Sign-up",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 50.sp,
                            fontWeight: FontWeight.bold,
                          ),),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),

                      /// Name field
                      CustomInputField(
                        hintText: 'Name',
                        labelText: "Name",
                        controller: nameController,
                      ),
                      SizedBox(
                        height: 25.h,
                      ),

                      /// Email field
                      CustomInputField(
                        hintText: 'Email',
                        labelText: "Email",
                        controller: emailController,
                      ),
                      SizedBox(
                        height: 25.h,
                      ),

                      /// Phone Number field
                      CustomInputField(
                        hintText: 'Phone Number',
                        labelText: "Phone Number",
                        controller: phoneNumberController,
                      ),
                      SizedBox(
                        height: 25.h,
                      ),

                      /// Password field
                      CustomInputField(
                        hintText: 'Password',
                        labelText: "Password",
                        obscureText: true,
                        suffixIcon: true,
                        controller: passwordController,
                      ),
                      SizedBox(
                        height: 25.h,
                      ),

                      /// Sign-up Button
                      state is SignUpLoadingState? CircularProgressIndicator(color: Constants.secondaryColor,) : CustomButton(
                        innerText: 'Sign-up',
                        onPressed: () {
                          context.read<MainCubit>().signUp(
                                name: nameController.text,
                                email: emailController.text,
                                phoneNumber: phoneNumberController.text,
                                password: passwordController.text,
                                profilePic:
                                    "https://preview.redd.it/k2w4z9gp9gq71.png?width=1024&format=png&auto=webp&s=09f98ca9d27f720a4e981d03f3cd62e62bae1b94",
                              );
                        },
                      ),
                      SizedBox(
                        height: 25.h,
                      ),

                      /// "Already have an account? Sign-in"
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account?'),
                          TextButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const SignInScreen(),), (route) => false,);
                              }, child: Text("Sign-in", style: TextStyle(color: Constants.secondaryColor),),),
                        ],
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
