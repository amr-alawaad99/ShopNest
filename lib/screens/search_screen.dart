import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopnest/cubit/main_cubit.dart';
import 'package:shopnest/models/home_model.dart';
import 'package:shopnest/screens/product_page_screen.dart';
import 'package:shopnest/screens/searchResultScreen.dart';
import 'package:shopnest/widgets/home_products_widget.dart';

import '../const/constants.dart';
import '../cubit/main_state.dart';
import '../widgets/custom_input_field.dart';

class SearchScreen extends StatelessWidget {
  final HomeModel homeModel;
  List<ProductModel> productsName = [];
  static final TextEditingController searchController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  SearchScreen({super.key, required this.homeModel});


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: Form(
              key: formKey,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Constants.secondaryColor,
                ),
              ),
            ),
            title: CustomInputField(
              hintText: "Search",
              filled: true,
              haveBorder: true,
              prefixIcon: true,
              isDense: true,
              controller: searchController,
              onChanged: (text) {
                productsName = homeModel.homeData!.products.where((element) =>
                    element.name!.toLowerCase().contains(
                        searchController.text.toLowerCase()),).toList();
                context.read<MainCubit>().updateState();
              },
              textInputAction: TextInputAction.search,
              onFieldSubmitted: (text) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SearchResultScreen(productModel: productsName),));
              },
            ),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(10.h),
              child: Container(),
            ),
          ),
          body: ListView.builder(
            itemCount: productsName.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProductPageScreen(productModel: productsName[index]))),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                      child: Row(
                        children: [
                          const Icon(Icons.search),
                          SizedBox(width: 20.w,),
                          Expanded(child: Text(productsName.map((e) => e.name!,).toList()[index], maxLines: 1, overflow: TextOverflow.ellipsis,)),
                          SizedBox(width: 20.w,),
                          const Icon(CupertinoIcons.arrow_up_left)
                        ],
                      ),
                    ),
                    Container(width: double.infinity, height: 0.1, color: Colors.black,),
                  ],
                ),
              );
            },
          ),

        );
      },
    );
  }
}
