import 'package:e_shop/features/home/presentation/view/favorite_view_body.dart';
import 'package:flutter/material.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const FavoriteViewBody(
      isArrowBack: false,
    );
  }
}