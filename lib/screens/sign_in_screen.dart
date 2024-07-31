import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopnest/const/constants.dart';
import 'package:shopnest/cubit/main_cubit.dart';
import 'package:shopnest/cubit/main_state.dart';
import 'package:shopnest/reusable_widgets/custom_button.dart';
import 'package:shopnest/reusable_widgets/custom_input_field.dart';
import 'package:shopnest/screens/sign_up_screen.dart';

class SignInScreen extends StatelessWidget {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {
          if(state is SignInSuccessState && state.state){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          } else if(state is SignInSuccessState && !state.state){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          } else if(state is SignInFailureState){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width*0.1),
                child: Column(
                  children: [
                    /// Header Image
                    SizedBox(
                      width: double.infinity,
                      height: size.height * 0.3,
                      child: Image.asset('assets/images/signin_background_pic.png'),
                    ),
                    /// Header Text (Sign-in)
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text("Sign-in",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: size.aspectRatio*110,
                          fontWeight: FontWeight.bold,
                        ),),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    /// Email
                    CustomInputField(labelText: 'Email', hintText: 'Your Email', controller: emailController,),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    /// Password
                    CustomInputField(labelText: 'Password', hintText: 'Your Password', suffixIcon: true, obscureText: true, controller: passwordController,),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    /// "Forgot password?" TextButton
                    Container(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text("Forgot password?"),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    /// Sign-in button
                    state is SignInLoadingState? const CircularProgressIndicator() : CustomButton(
                      onPressed: () {
                        context.read<MainCubit>().signIn(email: emailController.text, password: passwordController.text);
                      },
                      innerText: "Sign-in",
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    /// "Don't have and account? Sign-up"
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have and account?"),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Sign-up'),),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.03,
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
