import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopnest/const/constants.dart';
import 'package:shopnest/cubit/main_cubit.dart';
import 'package:shopnest/cubit/main_state.dart';
import 'package:shopnest/models/home_model.dart';
import 'package:shopnest/widgets/home_products_widget.dart';

class MyFavoritesScreen extends StatelessWidget {
  const MyFavoritesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HomeModel? productModel = context.read<MainCubit>().homeModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favorite products",
          style: TextStyle(color: Constants.secondaryColor),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(10.h),
          child: Container(),
        ),
      ),
      body: FutureBuilder<HomeModel?>(
        // if the data already loaded don't call the method
        future: productModel == null
            ? context.read<MainCubit>().getHomeData()
            : null,
        initialData: productModel,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error Getting data: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            return BlocBuilder<MainCubit, MainState>(
              builder: (context, state) {
                return HomeProductsWidget(
                    isScrollable: true,
                    productModel: snapshot.data!.homeData!.products
                        .where(
                          (element) => element.inFavorites!,
                        )
                        .toList());
              },
            );
          } else {
            return const Center(child: Text("No Data Available"));
          }
        },
      ),
    );
  }
}
