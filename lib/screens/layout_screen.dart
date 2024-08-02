import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopnest/cubit/main_cubit.dart';
import 'package:shopnest/cubit/main_state.dart';
import 'package:shopnest/screens/home_screen.dart';

import '../widgets/custom_input_field.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        if (state is GetUserProfileSuccessState) {
        } else if (state is GetUserProfileFailureState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const CustomInputField(
              hintText: "Search",
              filled: true,
              haveBorder: true,
              prefixIcon: true,
            ),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(size.height * 0.01),
              child: Container(),
            ),
          ),
          body: const HomeScreen(),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: 0,
            onTap: (value) {},
            items: [
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
