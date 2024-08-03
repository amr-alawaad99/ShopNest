import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopnest/cache/cache_helper.dart';
import 'package:shopnest/const/constants.dart';
import 'package:shopnest/core/api/dio_consumer.dart';
import 'package:shopnest/core/api/end_points.dart';
import 'package:shopnest/cubit/main_cubit.dart';
import 'package:shopnest/screens/layout_screen.dart';
import 'package:shopnest/screens/sign_in_screen.dart';

import 'const/bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper().init();
  Bloc.observer = MyBlocObserver();

  bool isSignedIn = false;
  if (CacheHelper().getData(key: ApiKey.token) != null) {
    isSignedIn = true;
  }
  runApp(
    BlocProvider(
      create: (context) => MainCubit(DioConsumer(dio: Dio())),
      child: MyApp(isSignedIn),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isSignedIn;

  const MyApp(this.isSignedIn, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
      builder: (context, child) =>  MaterialApp(
        theme: ThemeData(
            appBarTheme: AppBarTheme(color: Constants.primaryColor),
            scaffoldBackgroundColor: Constants.secondaryColor,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Constants.primaryColor,
              selectedItemColor: Constants.secondaryColor,
            )),
        debugShowCheckedModeBanner: false,
        home: isSignedIn ? const LayoutScreen() : SignInScreen(),
      ),
    );
  }
}
