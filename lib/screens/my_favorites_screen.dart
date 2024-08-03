import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopnest/cubit/main_cubit.dart';
import 'package:shopnest/models/favorites_model.dart';
import 'package:shopnest/screens/home_screen.dart';
import 'package:shopnest/screens/product_page_screen.dart';

import '../const/constants.dart';

class MyFavoritesScreen extends StatelessWidget {
  const MyFavoritesScreen({super.key,});


  @override
  Widget build(BuildContext context) {
    final List<FavoritesModel>? favoritesModel = context.read<MainCubit>().favoritesModel?.data;
    // Calculate a dynamic aspect ratio for the GridView item
    double itemHeight = 305.h; // by try and error
    double itemWidth = (1.sw-24.w)/2; // screen width - the 3 paddings (8.w * 3) divided by 2 (2 items per column)
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite products", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(10.h),
          child: Container(),
        ),
      ),
      body: favoritesModel == null? const Center(child: CircularProgressIndicator()) :
      FutureBuilder(
        future: context.read<MainCubit>().getMyFavorites(),
        initialData: const Center(child: CircularProgressIndicator()),
        builder: (context, snapshot) {
          print(snapshot);
          return GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10.h,
            crossAxisSpacing: 8.w,
            childAspectRatio: itemWidth/itemHeight, // the calculated ratio
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: favoritesModel.map((e) => GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPageScreen(
                  /* Here I return a clone of the favorite product from the homeModel products data
                    by comparing the id of the item (cause favorite DB doesn't have product images :) */
                    productModel: context.read<MainCubit>().homeModel!.homeData!.products
                        .singleWhere((element) {return element.id == e.favProductModel!.id;},)),),
                );
              },
              child: Column(
                children: [
                  /// Image Part
                  Stack(
                    children: [
                      /// Product Image
                      Container(
                        width: itemWidth,
                        height: 200.h,
                        color: Colors.white,
                        child: Image(
                          image: NetworkImage(e.favProductModel!.image!),
                          fit: BoxFit.contain,
                        ),
                      ),

                      /// Favorite Icon Button
                      Positioned(
                        right: 0,
                        top: 0,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.favorite_outline,
                            color: Constants.primaryColor,
                          ),
                        ),
                      ),

                      /// Discount Container
                      if (e.favProductModel!.discount!=0)
                        Positioned(
                          left: 0,
                          bottom: 0,
                          child: Container(
                            color: Colors.red,
                            child: Text(
                              " ${e.favProductModel!.discount}% off ",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                    ],
                  ),
                  /// Product Name
                  Text(
                    e.favProductModel!.name!,
                    style: TextStyle(
                      fontSize: 19.sp,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  /// Product Price
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 1.h),
                        child: Text(
                          "EGP",
                          style: TextStyle(fontSize: 13.sp),
                        ),
                      ),
                      Text(
                        e.favProductModel!.price.toString(),
                        style: TextStyle(
                          fontSize: 19.sp,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  /// Product Old price (if there's a discount)
                  if (e.favProductModel!.discount!=0)
                    Row(
                      children: [
                        Text(
                          "Was: ",
                          style: TextStyle(
                            fontSize: 15.sp,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "EGP ${e.favProductModel!.oldPrice.toString()}",
                          style: TextStyle(
                            fontSize: 15.sp,
                            decoration: TextDecoration.lineThrough,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                ],
              ),
            ),
            )
                .toList(),
          );
        },
      ),
    );
  }
}
