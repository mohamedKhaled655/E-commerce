import 'package:e_shop/core/constant.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final Widget icon;
  final void Function()? onPressed;
  final String title;
  
  const CategoryItem({
    Key? key,required this.icon, this.onPressed,required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Theme.of(context).textTheme.headlineLarge!.color,
          radius: h10*3,
          child: IconButton(
            icon: icon,
            
            onPressed: onPressed,
          ),
        ),
        SizedBox(height: h5,),
        SizedBox(
            width: h10*6.5,
            child: Text(
              title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 12,
                    
                  ),
            )),
      ],
    );
  }
}
