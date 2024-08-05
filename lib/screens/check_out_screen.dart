import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopnest/const/constants.dart';
import 'package:shopnest/cubit/main_cubit.dart';
import 'package:shopnest/cubit/main_state.dart';
import 'package:shopnest/screens/layout_screen.dart';
import 'package:shopnest/widgets/custom_button.dart';
import '../models/home_model.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key, required this.products});

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final double totalPrice = products.fold(0.0, (subtotal, product) {
      return subtotal + (product.price ?? 0.0);
    });
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Constants.secondaryColor,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.zero,
          child: Container(
            width: double.infinity,
            height: 0.5,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: 110.h),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.sp),
            child: Column(
              children: [
                /// privacy notice and conditions text
                RichText(
                  text: TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13.sp,
                      ),
                      children: [
                        const TextSpan(
                            text:
                                "By placing your order, you agree to ShopNest's "),
                        TextSpan(
                            text: "privacy notice",
                            style: TextStyle(
                                color: Constants.secondaryColor,
                                decoration: TextDecoration.underline)),
                        const TextSpan(text: " and "),
                        TextSpan(
                            text: "condition of use",
                            style: TextStyle(
                                color: Constants.secondaryColor,
                                decoration: TextDecoration.underline)),
                        const TextSpan(text: "."),
                      ]),
                ),
                SizedBox(height: 20.h),

                /// Address box
                Container(
                  padding: EdgeInsets.all(15.sp),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Address",
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: double.infinity,
                        height: 0.1,
                        color: Colors.black,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Row(
                          children: [
                            const Icon(Icons.location_on_outlined),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Diliver to",
                                    style: TextStyle(fontSize: 14.sp),
                                  ),
                                  Text(
                                    "9 PortSaaid st, Mansoura, Dakahlia, Egypt",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            const Icon(Icons.arrow_forward_ios),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 0.1,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),

                /// Shipment and items box
                Container(
                  padding: EdgeInsets.all(15.sp),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// box title
                      Text(
                        "Shipment of ${products.length} item${products.length > 1 ? "s" : ""}",
                        style: TextStyle(fontSize: 15.sp),
                      ),

                      /// items
                      Column(
                        children: List.generate(
                          products.length,
                          (index) => Container(
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            child: Row(
                              children: [
                                Image(
                                  image: NetworkImage(products[index].image!),
                                  height: 100.h,
                                  width: 100.w,
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(10.sp),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          products[index].name!,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          "EPG ${products[index].price.toString()}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),

                      /// get it by ###
                      const Row(
                        children: [
                          Text(
                            "Get it by ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Tomorrow",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),

                /// Order summary and total cost box
                Container(
                  padding: EdgeInsets.all(15.sp),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order Summary",
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "subtotal",
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          ),
                          Text(
                            "EGP $totalPrice",
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Shipping Fee",
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          ),
                          const Text(
                            "FREE",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Container(
                        width: double.infinity,
                        height: 0.1,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  "Total ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp),
                                ),
                                Text(
                                  "Icl. VAT ",
                                  style: TextStyle(
                                      fontSize: 20.sp, color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "EGP $totalPrice",
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        height: 100.h,
        color: Constants.primaryColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.sp),
          child: Column(
            children: [
              CustomButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => BlocBuilder<MainCubit, MainState>(
                      builder: (context, state) {
                        return state is RemoveAllCartItemsLoadingState || state is GetHomeDataLoadingState? const Center(child: CircularProgressIndicator()) : Dialog(
                          child: Container(
                            width: 100.w,
                            height: 300.h,
                            padding: EdgeInsets.all(30.sp),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Are you sure you want to place this order?",
                                  style: TextStyle(fontSize: 20.sp),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 50.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Constants.secondaryColor,
                                          borderRadius:
                                              BorderRadius.circular(25.sp)),
                                      clipBehavior: Clip.antiAlias,
                                      child: MaterialButton(
                                        child: const Text(
                                          "Yes",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () async {
                                          await context.read<MainCubit>().removeAllItemsInCart(products.map((product) => product.id!).toList());
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Your order was successfully placed"),backgroundColor: Colors.green,),);
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const LayoutScreen(),
                                            ),
                                            (route) => false,
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30.w,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Constants.secondaryColor,
                                          borderRadius:
                                              BorderRadius.circular(25.sp)),
                                      clipBehavior: Clip.antiAlias,
                                      child: MaterialButton(
                                        child: const Text(
                                          "No",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                innerText: "Place Order",
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "${products.length} Items",
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    "EGP $totalPrice",
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
