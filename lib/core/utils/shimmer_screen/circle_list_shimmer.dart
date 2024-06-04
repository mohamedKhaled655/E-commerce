import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../constant.dart';

class CircleListShimmer extends StatelessWidget {
  const CircleListShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: h10 * 11,
      
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: kbackground!,
            highlightColor: Colors.white12,
            enabled: true,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).bottomAppBarColor,
              radius: h10 * 3,
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          width: 10,
        ),
        itemCount: 6,
      ),
    );
  }
}
