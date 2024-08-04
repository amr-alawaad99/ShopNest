import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopnest/models/cart_model.dart';

import '../cubit/main_cubit.dart';
import '../widgets/home_products_widget.dart';

class MyCartScreen extends StatelessWidget {
  const MyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CartModel? cartModel = context.read<MainCubit>().cartModel;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(10.h),
          child: Container(),
        ),
      ),
      body: FutureBuilder<CartModel?>(
        // if the data already loaded don't call the method
        future: cartModel == null? context.read<MainCubit>().getMyCart() : null,
        initialData: cartModel,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error Getting data: ${snapshot.error}"));
          } else if(snapshot.hasData ){
            return HomeProductsWidget(productModel: (snapshot.data!.cartItemModel.map((cartItem) => cartItem.cartProduct!).toList()));
          } else {
            return const Center(child: Text("No Data Available"));
          }
        },
      ),
    );
  }
}
