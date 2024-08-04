import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopnest/cubit/main_cubit.dart';
import 'package:shopnest/cubit/main_state.dart';
import 'package:shopnest/widgets/home_products_widget.dart';
import '../models/home_model.dart';
import '../widgets/banner_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeModel? homeModel = context.read<MainCubit>().homeModel;

    return FutureBuilder<HomeModel?>(
      // if the data already loaded don't call the method
      future: homeModel == null ? context.read<MainCubit>().getHomeData() : null,
      initialData: homeModel,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return BlocBuilder<MainCubit, MainState>(
  builder: (context, state) {
    return SingleChildScrollView(
            child: Column(
              children: [
                BannerWidget(homeModel: snapshot.data!),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(20.h),
                  child: Text(
                    "For You",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 25.sp),
                  ),
                ),
                HomeProductsWidget(productModel: snapshot.data!.homeData!.products),
              ],
            ),
          );
  },
);
        } else if (snapshot.hasError) {
          return Center(
              child: Text("Error Getting data: ${snapshot.error}"));
        } else {
          return const Center(child: Text("No Data Available"));
        }
      },
    );
  }
}
