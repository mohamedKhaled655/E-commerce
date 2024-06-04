import 'package:e_shop/core/constant.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final bool isLoading;
  final String title;
  final double borderRadius;
  final void Function()? onTap;
  final Color? color;
  const CustomButton({Key? key, this.onTap, this.isLoading = false, this.title="", this.borderRadius=8, this.color=kPrimaryColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: color,
        ),
        child: Center(
            child: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ))
                : Text(
                    title,
                    style:Theme.of(context).textTheme.headlineMedium ,
                  )),
      ),
    );
  }
}
