import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopnest/models/home_model.dart';

class BannerWidget extends StatelessWidget {
  final HomeModel homeModel;

  const BannerWidget({super.key, required this.homeModel});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: homeModel.homeData!.banners
          .map(
            (e) => Image(
              image: NetworkImage(e.image!),
              width: 1.sw,
              height: 230.h,
              fit: BoxFit.cover,
            ),
          )
          .toList(),
      options: CarouselOptions(
        viewportFraction: 1.0,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(seconds: 1),
      ),
    );
  }
}
