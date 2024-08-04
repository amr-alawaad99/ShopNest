import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopnest/const/constants.dart';
import 'package:shopnest/cubit/main_cubit.dart';
import 'package:shopnest/cubit/main_state.dart';
import 'package:shopnest/models/home_model.dart';
import 'package:shopnest/screens/product_page_screen.dart';
import 'package:shopnest/widgets/shake_Icon_button_widget.dart';

class HomeProductsWidget extends StatelessWidget {
  final List<ProductModel> productModel;

  const HomeProductsWidget({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    // Calculate a dynamic aspect ratio for the GridView item
    double itemHeight = 305.h; // by try and error
    double itemWidth = (1.sw-24.w)/2; // screen width - the 3 paddings (8.w * 3) divided by 2 (2 items per column)
    return BlocBuilder<MainCubit,MainState>(
      builder: (context, state) =>  GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10.h,
        crossAxisSpacing: 8.w,
        childAspectRatio: itemWidth/itemHeight, // the calculated ratio
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: productModel
            .map(
              (e) => GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPageScreen(productModel: e),));
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
                                color: Constants.secondaryColor.withOpacity(0.5),
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5)),
                            child: ShakeIconButton(
                              onPressed: () {
                                context.read<MainCubit>().addXdeleteFavorite(e.id!, e);
                                },
                              icon: Icon(
                                e.inFavorites!? Icons.favorite : Icons.favorite_border,
                                color: Constants.primaryColor,
                              ),
                            ),
                          ),
                        ),

                        /// Discount Container
                        if (e.discount!=0)
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
                    /// Product Name
                    Text(
                      e.name!,
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
                          e.price.toString(),
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
                    if (e.discount!=0)
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
                            "EGP ${e.oldPrice.toString()}",
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
      ),
    );
  }
}
