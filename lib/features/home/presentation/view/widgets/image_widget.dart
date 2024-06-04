import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_shop/core/constant.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_theme/theme_cubit/theme_cubit.dart';

class ImageWidget extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;

  const ImageWidget({
    Key? key,
    required this.imageUrl,
    this.height = 200,
    this.width = 120,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              height: height,
              width: width,
              fit: BoxFit.fill,
              fadeInCurve: Curves.fastLinearToSlowEaseIn,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                child: CircularProgressIndicator(
                  value: downloadProgress.progress,
                  color: kPrimaryColor,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            )),
        Positioned(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                      height: height,
                      width: width,
                      color:ThemeCubit.get(context).isDark?const Color(0xff1f222a).withOpacity(.3):Colors.white.withOpacity(0),
                    ),
            )),
      ],
    );
  }
}
