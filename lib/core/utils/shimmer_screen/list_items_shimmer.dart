import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../constant.dart';

class ItemsListShimmer extends StatelessWidget {
  const ItemsListShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: h10 * 30,
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: kbackground!,
            highlightColor: Colors.white12,
            enabled: true,
            child: Container(
              height: h10 * 15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).bottomAppBarColor,
              ),
              
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(
          indent: 50,
          endIndent: 50,
          thickness: 1.8,
        ),
        itemCount: 6,
      ),
    );
  }
}
