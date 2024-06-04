import 'package:e_shop/core/utils/icon_broken.dart';
import 'package:e_shop/core/widgets/large_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomBar extends StatelessWidget {
  final String text;
  final void Function()? onPressedSearch;
  const CustomBar({
    Key? key,required this.text, this.onPressedSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          FaIcon(FontAwesomeIcons.joomla,color: Theme.of(context).backgroundColor,size: 35,),
         const SizedBox(width: 15,),
          LargeText(text: text),
         const Spacer(),
          IconButton(
            onPressed: onPressedSearch,
             icon: Icon(IconBroken.Search,color: Theme.of(context).backgroundColor,size: 30,),
             ),
        ],
      ),
    );
  }
}