import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../constant.dart';

class CarouselShimmer extends StatelessWidget {
  const CarouselShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: h10 * 17,
      width: 300,
      child: ListView.separated(
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: kbackground!,
            highlightColor: Colors.white12,
            enabled: true,
            child: Container(
              height: h10 * 17,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Theme.of(context).bottomAppBarColor,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          width: 10,
        ),
        itemCount: 5,
      ),
    );
  }
}
