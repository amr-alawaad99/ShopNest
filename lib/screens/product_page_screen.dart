import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopnest/const/constants.dart';
import 'package:shopnest/cubit/main_cubit.dart';
import 'package:shopnest/cubit/main_state.dart';
import 'package:shopnest/models/home_model.dart';
import 'package:shopnest/widgets/custom_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../widgets/custom_input_field.dart';
import '../widgets/shake_Icon_button_widget.dart';

class ProductPageScreen extends StatelessWidget {
  final ProductModel productModel;
  final PageController pageController = PageController();

  ProductPageScreen({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            CupertinoIcons.back,
            color: Constants.secondaryColor,
          ),
        ),
        title: const CustomInputField(
          hintText: "Search",
          filled: true,
          haveBorder: true,
          prefixIcon: true,
          isDense: true,
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(10.h),
          child: Container(),
        ),
      ),
      body: BlocBuilder<MainCubit, MainState>(
  builder: (context, state) {
    return SingleChildScrollView(
        child: Column(
          children: [
            /// Images Slider (PageView) and Favorite button
            Stack(
              children: [
                /// Images Slider (PageView)
                Container(
                  color: Colors.white,
                  height: 355.h,
                  child: PageView.builder(
                    itemCount: productModel.images!.length,
                    controller: pageController,
                    itemBuilder: (context, index) =>
                        Image(image: NetworkImage(productModel.images![index])),
                  ),
                ),

                /// Add to favorite button
                Positioned(
                  right: 15.sp,
                  top: 15.sp,
                  child: Container(
                    width: 50.sp,
                    height: 50.sp,
                    decoration: BoxDecoration(
                        color: Constants.primaryColor,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
                    child: ShakeIconButton(
                      onPressed: () {
                        context.read<MainCubit>().addXdeleteFavorite(productModel.id!, productModel);
                      },
                      icon: Icon(
                        productModel.inFavorites!? Icons.favorite : Icons.favorite_border,
                        color: Constants.secondaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),

            /// Images Page Indicator
            SmoothPageIndicator(
              effect: ScaleEffect(
                activeDotColor: Constants.secondaryColor,
                dotHeight: 10.sp,
                dotWidth: 10.sp,
              ),
              count: productModel.images!.length,
              controller: pageController,
            ),

            /// The Rest of the page
            Padding(
              padding: EdgeInsets.all(15.sp),
              child: Column(
                children: [
                  /// Product Name
                  Text(
                    productModel.name!,
                    style: TextStyle(fontSize: 22.sp),
                  ),

                  /// Product Price
                  Row(
                    children: [
                      Text(
                        "EGP",
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        productModel.price.toString(),
                        style: TextStyle(
                            fontSize: 27.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  /// Old Price and How much You'll save
                  if (productModel.discount != 0)
                    Row(
                      children: [
                        Text(
                          productModel.oldPrice.toString(),
                          style: TextStyle(
                              fontSize: 20.sp,
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey[700],
                              decorationColor: Colors.grey[700]),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          "Save ${productModel.oldPrice - productModel.price}",
                          style: TextStyle(
                              fontSize: 20.sp,
                              color: const Color(0xffD00000),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  SizedBox(
                    height: 20.h,
                  ),

                  /// Some Icons and text (Cash on delivery & Return for free)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const Icon(
                            Icons.account_balance_wallet_outlined,
                            color: Color(0xFF009900),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          const Text("Cash on delivery"),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            "Cash on card",
                            style: TextStyle(color: Colors.grey[700]),
                          )
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 45.w),
                        child: Container(
                          height: 90.h,
                          width: 0.5.w,
                          color: Colors.grey[700],
                        ),
                      ),
                      Column(
                        children: [
                          const Icon(
                            Icons.repeat_rounded,
                            color: Color(0xFF009900),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          const Text("Return for free"),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            "Up to 30 days",
                            style: TextStyle(color: Colors.grey[700]),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25.h,
                  ),

                  /// Add to cart button
                  CustomButton(
                    innerText: productModel.inCart!? "In cart" : "Add to cart",
                    havePrefix: productModel.inCart!? false : true,
                    borderRadius: 10,
                    onPressed: () {
                      if(productModel.inCart!){
                        context.read<MainCubit>().changeBottomNavBar(2);
                        Navigator.pop(context);
                      } else {
                        context.read<MainCubit>().itemsInCart++;
                        context.read<MainCubit>().addXdeleteCart(productModel.id!, productModel);
                      }
                    },
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                ],
              ),
            ),

            /// shadow divider
            Container(
              width: double.infinity,
              height: 20.h,
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 50,
                  blurStyle: BlurStyle.inner,
                ),
              ]),
            ),

            /// About product (Product details)
            Padding(
              padding: EdgeInsets.all(0.05.sw),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                    width: double.infinity,
                  ),
                  Text(
                    "About product",
                    style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    productModel.description!,
                    style: TextStyle(
                        fontSize: 18.sp,
                        height: 3.h),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
            /// shadow divider
            Container(
              width: double.infinity,
              height: 20.h,
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 50,
                  blurStyle: BlurStyle.inner,
                ),
              ]),
            ),
          ],
        ),
      );
  },
),
    );
  }
}
