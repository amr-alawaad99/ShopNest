import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shopnest/models/home_model.dart';

class BannerWidget extends StatelessWidget {
  final HomeModel homeModel;

  const BannerWidget({super.key, required this.homeModel});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return CarouselSlider(
      items: homeModel.homeData!.banners
          .map(
            (e) => Image(
              image: NetworkImage(e.image!),
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          )
          .toList(),
      options: CarouselOptions(
        height: size.height*0.26,
        viewportFraction: 1.0,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(seconds: 1),
      ),
    );
  }
}
