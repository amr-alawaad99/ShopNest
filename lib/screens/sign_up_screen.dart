import 'package:flutter/material.dart';
import 'package:shopnest/const/constants.dart';
import 'package:shopnest/reusable_widgets/custom_button.dart';
import 'package:shopnest/reusable_widgets/custom_input_field.dart';

class SignUpScreen extends StatelessWidget {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(size.width*0.1),
            child: Column(
              children: [
                /// Profile Image & Image Picker
                Container(
                  alignment: Alignment.center,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: size.aspectRatio*200,
                        backgroundImage: Constants.defaultUserImage,
                        backgroundColor: Colors.white,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: size.aspectRatio*100,
                          height: size.aspectRatio*100,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 3),
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.blue
                          ),
                          child: const Icon(Icons.camera_alt, color: Colors.white,),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                /// Name field
                CustomInputField(hintText: 'Name', labelText: "Name", controller: nameController,),
                SizedBox(
                  height: size.height * 0.03,
                ),
                /// Email field
                CustomInputField(hintText: 'Email', labelText: "Email", controller: emailController,),
                SizedBox(
                  height: size.height * 0.03,
                ),
                /// Phone Number field
                CustomInputField(hintText: 'Phone Number', labelText: "Phone Number", controller: phoneNumberController,),
                SizedBox(
                  height: size.height * 0.03,
                ),
                /// Password field
                CustomInputField(hintText: 'Password', labelText: "Password", obscureText: true, suffixIcon: true, controller: passwordController,),
                SizedBox(
                  height: size.height * 0.03,
                ),
                /// Confirm Password field
                CustomInputField(hintText: 'Confirm Password', labelText: "Confirm Password",  obscureText: true, suffixIcon: true, controller: confirmPasswordController,),
                SizedBox(
                  height: size.height * 0.03,
                ),
                /// Sign-up Button
                CustomButton(innerText: 'Sign-up', onPressed: () {},),
                SizedBox(
                  height: size.height * 0.03,
                ),
                /// "Already have an account? Sign-in"
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    TextButton(onPressed: () {}, child: const Text("Sign-in")),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
