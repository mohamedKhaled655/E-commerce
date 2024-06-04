import 'package:flutter/material.dart';

class LargeText extends StatelessWidget {
  final String text;
  final Color ?color;
  final double ?fontSize;
  final FontWeight ?fontWeight;
  const LargeText({
    Key? key,required this.text, this.color, this.fontSize, this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(color:color,fontSize: fontSize,fontWeight:fontWeight  ),
    );
  }
}