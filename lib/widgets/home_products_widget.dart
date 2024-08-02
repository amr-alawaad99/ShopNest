import 'package:flutter/material.dart';
import 'package:shopnest/const/constants.dart';
import 'package:shopnest/models/home_model.dart';
import 'package:shopnest/screens/product_page_screen.dart';

class HomeProductsWidget extends StatelessWidget {
  final HomeModel homeModel;

  const HomeProductsWidget({super.key, required this.homeModel});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: size.height * 0.01,
      crossAxisSpacing: size.width * 0.02,
      padding: EdgeInsets.symmetric(horizontal: size.aspectRatio * 20),
      childAspectRatio: 0.6,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: homeModel.homeData!.products
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
                        width: size.width * 0.49,
                        height: size.width * 0.49,
                        color: Colors.white,
                        child: Image(
                          image: NetworkImage(e.image!),
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
                      fontSize: size.aspectRatio * 40,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  /// Product Price
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: size.aspectRatio * 7),
                        child: Text(
                          "EGP",
                          style: TextStyle(fontSize: size.aspectRatio * 25),
                        ),
                      ),
                      Text(
                        e.price.toString(),
                        style: TextStyle(
                          fontSize: size.aspectRatio * 40,
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
                            fontSize: size.aspectRatio * 30,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "EGP ${e.oldPrice.toString()}",
                          style: TextStyle(
                            fontSize: size.aspectRatio * 30,
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
  }
}
