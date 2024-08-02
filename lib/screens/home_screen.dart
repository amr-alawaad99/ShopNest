import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopnest/cubit/main_cubit.dart';
import 'package:shopnest/cubit/main_state.dart';
import 'package:shopnest/widgets/home_products_widget.dart';
import '../widgets/banner_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        if (state is GetHomeDataSuccessState) {}
      },
      builder: (context, state) {
        return Scaffold(
          body: state is GetHomeDataLoadingState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : state is GetHomeDataSuccessState
                  ? SingleChildScrollView(
                    child: Column(
                        children: [
                          BannerWidget(homeModel: context.read<MainCubit>().homeModel!),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.all(size.aspectRatio*50),
                            child: Text("For You",
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: size.aspectRatio*50),),
                          ),
                          HomeProductsWidget(homeModel: context.read<MainCubit>().homeModel!),
                        ],
                      ),
                  )
                  : Container(),
        );
      },
    );
  }
}
