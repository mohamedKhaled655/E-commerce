import 'package:e_shop/core/constant.dart';
import 'package:e_shop/core/utils/languages/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomSearchBar extends StatelessWidget {
  final void Function()? onPressedPrefix;
  final void Function()? onPressedsuffix;
final void Function(String)? onChanged;
final void Function(String?)? onSaved;
  const CustomSearchBar({
    Key? key, this.onPressedPrefix, this.onPressedsuffix, this.onChanged, this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color:Theme.of(context).textTheme.headlineLarge!.color,
          borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        cursorColor: kPrimaryColor,
        onChanged: onChanged,
        onSaved: onSaved,
        decoration: InputDecoration(
            hintText: "Search".tr(context),
            fillColor: Colors.transparent,
            
            prefixIcon: IconButton(
              icon:const FaIcon(FontAwesomeIcons.magnifyingGlass,size: 25,color: Colors.grey,),
              onPressed: onPressedPrefix,
            ),
            suffixIcon:IconButton(
              padding:const EdgeInsets.only(right: 10),
              icon:const FaIcon(FontAwesomeIcons.barsStaggered,size: 25,color: Colors.grey,),
              onPressed: onPressedsuffix,
            ) ,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                )),
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                )),
                focusedBorder:OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                )),

                
                ),
                

        validator: (value) {
          if (value?.isEmpty ?? true) {
            return "Field is required";
          } else {
            return null;
          }
        },
      ),
    );
  }
}
