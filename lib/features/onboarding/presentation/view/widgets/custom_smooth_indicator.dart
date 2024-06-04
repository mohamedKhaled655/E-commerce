import 'package:e_shop/core/constant.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomSmoothIndicator extends StatelessWidget {
  const CustomSmoothIndicator({
    Key? key,
    required this.pageController,required this.count, this.dotHeight=10,
  }) : super(key: key);

  final PageController pageController;
  final int count;
  final double dotHeight;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: pageController,
      count: count,
      effect:  ExpandingDotsEffect(
        dotColor: Colors.grey,
        activeDotColor: kPrimaryColor,
        dotHeight: dotHeight,
      ),
    );
  }
}