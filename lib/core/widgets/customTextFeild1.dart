import 'package:e_shop/core/constant.dart';
import 'package:flutter/material.dart';

class CustomTextFeild1 extends StatelessWidget {
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final String? hintText;
  const CustomTextFeild1({
    Key? key,
    this.onSaved,
    this.hintText,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Colors.transparent,
        ));
    return Container(
      height: 65,
      decoration: BoxDecoration(
          color: Theme.of(context).textTheme.headlineLarge!.color,
          borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        cursorColor: kPrimaryColor,
        onSaved: onSaved,
        onChanged: onChanged,
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return "Field is required";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          hintText: hintText,
          fillColor: Colors.transparent,
          enabledBorder: outlineInputBorder,
          border: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          
        ),
      ),
    );
  }
}