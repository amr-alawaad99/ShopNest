import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopnest/const/constants.dart';
import 'package:shopnest/models/home_model.dart';
import 'package:shopnest/widgets/custom_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../widgets/custom_input_field.dart';

class ProductPageScreen extends StatelessWidget {
  final ProductModel productModel;
  final PageController pageController = PageController();

  ProductPageScreen({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            CupertinoIcons.back,
            color: Colors.white,
          ),
        ),
        title: const CustomInputField(
          hintText: "Search",
          filled: true,
          haveBorder: true,
          prefixIcon: true,
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(size.height * 0.01),
          child: Container(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Images Slider (PageView) and Favorite button
            Stack(
              children: [
                /// Images Slider (PageView)
                Container(
                  color: Colors.white,
                  height: size.height * 0.4,
                  child: PageView.builder(
                    itemCount: productModel.images!.length,
                    controller: pageController,
                    itemBuilder: (context, index) =>
                        Image(image: NetworkImage(productModel.images![index])),
                  ),
                ),

                /// Add to favorite button
                Positioned(
                  right: size.aspectRatio * 30,
                  top: size.aspectRatio * 30,
                  child: Container(
                    width: size.aspectRatio * 100,
                    height: size.aspectRatio * 100,
                    decoration: BoxDecoration(
                        color: Constants.secondaryColor,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
                    child: Icon(
                      Icons.favorite_border,
                      color: Constants.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.01,
            ),

            /// Images Page Indicator
            SmoothPageIndicator(
              effect: ScaleEffect(
                activeDotColor: Constants.primaryColor,
                dotHeight: size.aspectRatio * 30,
                dotWidth: size.aspectRatio * 30,
              ),
              count: productModel.images!.length,
              controller: pageController,
            ),

            /// The Rest of the page
            Padding(
              padding: EdgeInsets.all(size.aspectRatio * 30),
              child: Column(
                children: [
                  /// Product Name
                  Text(
                    productModel.name!,
                    style: TextStyle(fontSize: size.aspectRatio * 45),
                  ),

                  /// Product Price
                  Row(
                    children: [
                      Text(
                        "EGP",
                        style: TextStyle(
                            fontSize: size.aspectRatio * 40,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        productModel.price.toString(),
                        style: TextStyle(
                            fontSize: size.aspectRatio * 60,
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
                              fontSize: size.aspectRatio * 40,
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey[700],
                              decorationColor: Colors.grey[700]),
                        ),
                        SizedBox(
                          width: size.width * 0.015,
                        ),
                        Text(
                          "Save ${productModel.oldPrice - productModel.price}",
                          style: TextStyle(
                              fontSize: size.aspectRatio * 40,
                              color: const Color(0xffD00000),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  SizedBox(
                    height: size.aspectRatio * 50,
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
                            height: size.aspectRatio * 10,
                          ),
                          const Text("Cash on delivery"),
                          SizedBox(
                            height: size.aspectRatio * 10,
                          ),
                          Text(
                            "Cash on card",
                            style: TextStyle(color: Colors.grey[700]),
                          )
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.1),
                        child: Container(
                          height: size.height * 0.1,
                          width: 0.5,
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
                            height: size.aspectRatio * 10,
                          ),
                          const Text("Return for free"),
                          SizedBox(
                            height: size.aspectRatio * 10,
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
                    height: size.aspectRatio * 50,
                  ),

                  /// Add to cart button
                  CustomButton(
                    innerText: "Add to cart",
                    havePrefix: true,
                    borderRadius: 10,
                    onPressed: () {},
                  ),
                  SizedBox(
                    height: size.aspectRatio * 50,
                  ),
                ],
              ),
            ),

            /// small shadow divider
            Container(
              width: double.infinity,
              height: size.height * 0.02,
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
              padding: EdgeInsets.all(size.aspectRatio * 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.aspectRatio * 50,
                  ),
                  Text(
                    "About product",
                    style: TextStyle(
                        fontSize: size.aspectRatio * 45,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: size.aspectRatio * 30,
                  ),
                  Text(
                    productModel.description!,
                    style: TextStyle(
                        fontSize: size.aspectRatio * 35,
                        height: size.height * 0.003),
                  ),
                  SizedBox(
                    height: size.aspectRatio * 70,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
