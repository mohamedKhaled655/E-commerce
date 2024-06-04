
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../constant.dart';

class GridViewShimmer extends StatelessWidget {
  const GridViewShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: h10 *40,
      
      child: GridView.builder(
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: kbackground!,
            highlightColor: Colors.white12,
            enabled: true,
            child: Container(
              height: h10 * 250,
              width: MediaQuery.of(context).size.width * .45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Theme.of(context).bottomAppBarColor,
              ),
            ),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 2.35/4,
        ),
        itemCount: 10,
      ),
    );
  }
}
