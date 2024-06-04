import 'package:e_shop/core/utils/languages/app_localizations.dart';
import 'package:e_shop/features/onboarding/data/repo/onboarding_data.dart';
import 'package:flutter/material.dart';

class PageViewBody extends StatelessWidget {
  final int index;
  const PageViewBody({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(flex: 2, child: Image.asset(onbordingList[index].image)),
        const SizedBox(
          height: 30,
        ),
        Text(
          onbordingList[index].title.tr(context),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Text(
            onbordingList[index].body.tr(context),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}