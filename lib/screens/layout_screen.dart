import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopnest/cubit/main_cubit.dart';
import 'package:shopnest/cubit/main_state.dart';
import 'package:shopnest/screens/profile_screen.dart';

import '../widgets/custom_input_field.dart';
import 'home_screen.dart';
import 'my_cart_screen.dart';
import 'my_favorites_screen.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});



  @override
  Widget build(BuildContext context) {
    final List<Widget> bottomNavBarPages = [
      const HomeScreen(),
      const MyFavoritesScreen(),
      const MyCartScreen(),
      const ProfileScreen()
    ];
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        if (state is GetHomeDataSuccessState) {


        } else if (state is GetUserProfileFailureState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: context.read<MainCubit>().currentPageIndex == 0? AppBar(
            title: const CustomInputField(
              hintText: "Search",
              filled: true,
              haveBorder: true,
              prefixIcon: true,
            ),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(10.h),
              child: Container(),
            ),
          ) : null,
          body: bottomNavBarPages[context.read<MainCubit>().currentPageIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: context.read<MainCubit>().currentPageIndex,
            onTap: (value) {
              context.read<MainCubit>().changeBottomNavBar(value);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: "Home",
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border), label: "Favorite"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_bag_outlined), label: "Cart"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_2_outlined), label: "You"),
            ],
          ),
        );
      },
    );
  }
}
