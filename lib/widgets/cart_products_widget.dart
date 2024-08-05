import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopnest/screens/check_out_screen.dart';
import 'package:shopnest/widgets/custom_button.dart';
import 'package:shopnest/widgets/shake_Icon_button_widget.dart';

import '../const/constants.dart';
import '../cubit/main_cubit.dart';
import '../models/home_model.dart';
import '../screens/product_page_screen.dart';

class CartProductsWidget extends StatelessWidget {
  final List<ProductModel> productModel;
  final bool isScrollable;

  const CartProductsWidget(
      {super.key, required this.productModel, this.isScrollable = false});

  @override
  Widget build(BuildContext context) {
    // Calculate a dynamic aspect ratio for the GridView item
    double itemHeight = 200.h; // by try and error
    double itemWidth = 1.sw -
        16.w; // screen width - the 3 paddings (8.w * 3) divided by 2 (2 items per column)
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(bottom: 110.h),
        child: GridView.count(
          crossAxisCount: 1,
          mainAxisSpacing: 10.h,
          crossAxisSpacing: 8.w,
          childAspectRatio: itemWidth / itemHeight,
          // the calculated ratio
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          shrinkWrap: true,
          physics: isScrollable
              ? const ScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          children: productModel
              .map(
                (e) => InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductPageScreen(productModel: e),
                        ));
                  },
                  child: Container(
                    color: Constants.primaryColor.withGreen(999),
                    child: Row(
                      children: [
                        /// Image Part
                        Stack(
                          children: [
                            /// Product Image
                            Container(
                              width: 150.w,
                              height: itemHeight,
                              color: Colors.white,
                              child: Image(
                                image: NetworkImage(e.image!),
                                fit: BoxFit.contain,
                              ),
                            ),

                            /// Favorite Icon Button
                            Positioned(
                              right: 5.sp,
                              top: 5.sp,
                              child: Container(
                                width: 40.sp,
                                height: 40.sp,
                                decoration: BoxDecoration(
                                    color: Constants.primaryColor,
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5)),
                                child: ShakeIconButton(
                                  onPressed: () {
                                    context
                                        .read<MainCubit>()
                                        .addXdeleteFavorite(e.id!, e);
                                  },
                                  icon: Icon(
                                    e.inFavorites!
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Constants.secondaryColor,
                                  ),
                                ),
                              ),
                            ),

                            /// Discount Container
                            if (e.discount != 0)
                              Positioned(
                                left: 0,
                                bottom: 0,
                                child: Container(
                                  color: Colors.red,
                                  child: Text(
                                    " ${e.discount}% off ",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(
                          width: 20.w,
                        ),

                        /// Name and Price
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Product Name
                              SizedBox(
                                width: 150,
                                child: Text(
                                  e.name!,
                                  style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),

                              /// Product Price
                              FittedBox(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(top: 1.h),
                                      child: Text(
                                        "EGP",
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      e.price.toString(),
                                      style: TextStyle(
                                        fontSize: 19.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              ),

                              /// Product Old price (if there's a discount)
                              if (e.discount != 0)
                                FittedBox(
                                  child: Row(
                                    children: [
                                      Text(
                                        "Was: ",
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        "EGP ${e.oldPrice.toString()}",
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          decoration: TextDecoration.lineThrough,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),

                        /// add/remove and quantity Container
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Constants.secondaryColor.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(25.sp)),
                              height: 118.h,
                              width: 40.w,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.add,
                                        color: Constants.primaryColor,
                                      )),
                                  Text(
                                    "1",
                                    style: TextStyle(
                                      color: Constants.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.remove,
                                        color: Constants.primaryColor,
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Container(
                              padding: EdgeInsets.all(7.sp),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(25.sp),
                              ),
                              child: ShakeIconButton(
                                onPressed: () {
                                  context.read<MainCubit>().addXdeleteCart(e.id!, e);
                                  context.read<MainCubit>().itemsInCart--;
                                },
                                icon: const Icon(CupertinoIcons.trash, color: Colors.red,),),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
      bottomSheet: Container(
        height: 100.h,
        color: Constants.primaryColor,
        child: Padding(
          padding: EdgeInsets.only(bottom: 10.sp, left: 10.sp, right: 10.sp),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text("Subtotal",
                    style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text("EGP ${productModel.fold(0.0, (subtotal, product) {return subtotal + (product.price ?? 0.0);})}",
                  style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 10.h,),
              CustomButton(innerText: "CHECKOUT", onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CheckOutScreen(products: productModel,),));
              },),
            ],
          ),
        ),
      ),
    );
  }
}
