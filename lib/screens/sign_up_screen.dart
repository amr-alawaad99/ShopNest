
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopnest/cubit/main_state.dart';

import 'package:shopnest/screens/sign_in_screen.dart';

import '../cubit/main_cubit.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input_field.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {
          if(state is SignUpSuccessState){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          } else if(state is SignUpFailureState){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(size.width * 0.1),
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
                      height: size.height * 0.3,
                      child: Image.asset('assets/images/signin_background_pic.png'),
                    ),

                    /// Header Text (Sign-in)
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text("Sign-up",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: size.aspectRatio*110,
                          fontWeight: FontWeight.bold,
                        ),),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),

                    /// Name field
                    CustomInputField(
                      hintText: 'Name',
                      labelText: "Name",
                      controller: nameController,
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),

                    /// Email field
                    CustomInputField(
                      hintText: 'Email',
                      labelText: "Email",
                      controller: emailController,
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),

                    /// Phone Number field
                    CustomInputField(
                      hintText: 'Phone Number',
                      labelText: "Phone Number",
                      controller: phoneNumberController,
                    ),
                    SizedBox(
                      height: size.height * 0.03,
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
                      height: size.height * 0.03,
                    ),

                    /// Sign-up Button
                    state is SignUpLoadingState? const CircularProgressIndicator() : CustomButton(
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
                      height: size.height * 0.03,
                    ),

                    /// "Already have an account? Sign-in"
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?'),
                        TextButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignInScreen(),), (route) => false,);
                            }, child: const Text("Sign-in"),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
