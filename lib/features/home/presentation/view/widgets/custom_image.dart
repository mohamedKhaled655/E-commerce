import 'package:flutter/material.dart';

import '../../../../../core/constant.dart';

class CustomImage extends StatelessWidget {
  final String? image;
  final void Function()? onTap;
  const CustomImage({
    Key? key,
    this.image,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Theme.of(context).primaryColor.withOpacity(.3),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: CircleAvatar(
          radius: 75,
          backgroundColor: Theme.of(context).primaryColor.withOpacity(.3),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(75),
                image: DecorationImage(
                    image: NetworkImage(
                    image??"https://img.freepik.com/free-photo/close-up-young-successful-man-smiling-camera-standing-casual-outfit-against-blue-background_1258-66609.jpg?w=996&t=st=1679187400~exp=1679188000~hmac=24958191102813240a24d739aa3b649b53902894aef815ed2e5ad386b99988c4",
                    ),
                    fit: BoxFit.fill)),
          ),
        ),
      ),
    );
  }
}
