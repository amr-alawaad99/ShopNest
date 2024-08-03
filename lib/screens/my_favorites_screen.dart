import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopnest/cubit/main_cubit.dart';
import 'package:shopnest/models/favorites_model.dart';
import 'package:shopnest/models/home_model.dart';
import 'package:shopnest/widgets/home_products_widget.dart';


class MyFavoritesScreen extends StatelessWidget {
  const MyFavoritesScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    FavoritesData? favoritesModel = context.read<MainCubit>().favoritesModel;
    List<ProductModel>? productModel = context.read<MainCubit>().homeModel?.homeData?.products;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite products", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(10.h),
          child: Container(),
        ),
      ),
      body: FutureBuilder<FavoritesData?>(
        // if the data already loaded don't call the method
        future: favoritesModel == null? context.read<MainCubit>().getMyFavorites() : null,
        initialData: favoritesModel,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error Getting data: ${snapshot.error}"));
          } else if(snapshot.hasData ){
            return HomeProductsWidget(productModel: snapshot.data!.data);
          } else {
            return const Center(child: Text("No Data Available"));
          }
        },
      ),
    );
  }
}
