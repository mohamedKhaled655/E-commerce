import 'package:e_shop/core/constant.dart';
import 'package:flutter/material.dart';

class CustomTextFeild extends StatelessWidget {
  final String hint;
  final int maxLine;
  final String text;
  final bool obscureText;
  final bool isShowprefix;
  final IconData? prefixIcon;
  final void Function(String?)? onSave;
  final Function(String)? onChange;
  const CustomTextFeild({
    Key? key,
    required this.hint,
    this.maxLine = 1,
    this.onSave,
    this.onChange,
    this.text = "",
    this.obscureText = false,
    this.prefixIcon,
    this.isShowprefix = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).iconTheme.color,
          borderRadius: BorderRadius.circular(12)),
      child: TextFormField(
        initialValue: text,
        onChanged: onChange,
        onSaved: onSave,
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return "Field is required";
          } else {
            return null;
          }
        },
        cursorColor: kPrimaryColor,
        maxLines: maxLine,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: isShowprefix
              ? CustomPrefixIcon(prefixIcon: prefixIcon)
              : Container(),
          hintStyle: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: kPrimaryColor.withOpacity(.7)),
          border: buildBorder(),
          enabledBorder: buildBorder(),
          focusedBorder: buildBorder(kPrimaryColor),
        ),
      ),
    );
  }

  OutlineInputBorder buildBorder([Color]) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Color ?? Colors.transparent));
  }
}

class CustomPrefixIcon extends StatelessWidget {
  const CustomPrefixIcon({
    Key? key,
    required this.prefixIcon,
  }) : super(key: key);

  final IconData? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 45,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: kPrimaryColor.withOpacity(.2),
          borderRadius: BorderRadius.circular(10)),
      child: Icon(
        prefixIcon,
        color: kPrimaryColor,
        size: h10 * 3,
      ),
    );
  }
}
