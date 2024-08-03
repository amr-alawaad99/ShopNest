import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopnest/cubit/main_cubit.dart';
import 'package:shopnest/cubit/main_state.dart';
import 'package:shopnest/widgets/home_products_widget.dart';
import '../widgets/banner_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: context.read<MainCubit>().homeModel?.homeData == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : context.read<MainCubit>().homeModel?.homeData != null
                  ? SingleChildScrollView(
                    child: Column(
                        children: [
                          BannerWidget(homeModel: context.read<MainCubit>().homeModel!),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.all(20.h),
                            child: Text("For You",
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.sp),),
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
