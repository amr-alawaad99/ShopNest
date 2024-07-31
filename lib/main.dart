import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopnest/const/constants.dart';
import 'package:shopnest/core/api/dio_consumer.dart';
import 'package:shopnest/cubit/main_cubit.dart';
import 'package:shopnest/screens/sign_in_screen.dart';

import 'const/bloc_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(
    BlocProvider(
      create: (context) => MainCubit(DioConsumer(dio: Dio())),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Constants.secondaryColor,
      ),
      debugShowCheckedModeBanner: false,
      home: SignInScreen(),
    );
  }
}

