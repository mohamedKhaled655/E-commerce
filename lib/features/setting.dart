import 'package:e_shop/core/utils/languages/app_localizations.dart';
import 'package:e_shop/core/utils/languages/cubit/language_cubit.dart';
import 'package:e_shop/core/utils/languages/cubit/language_states.dart';
import 'package:e_shop/features/home/presentation/view_model/product_cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("settings".tr(context)),
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocConsumer<LanguagesCubit, LanguagesStates>(
              listener: (context, state) {
                if(state is ChangeLanguageLocalstates){
                 // Navigator.of(context).pop();
                 //GoRouter.of(context).pop();
                 print("change sec= ""${state.locale.languageCode}");
                 
                 GoRouter.of(context).push("/");
                }
              },
              builder: (context, state) {
                if(state is ChangeLanguageLocalstates){
                  return  DropdownButton<String>(
                  value: state.locale.languageCode,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: ['ar', 'en'].map((String items) {
                    return DropdownMenuItem<String>(
                      value: items,
                      child: Text(items=="en"?"English":"عربي"),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      context.read<LanguagesCubit>().changeLanguage(newValue);
                    }
                  },
                );

                }else{
                  return Container();
                }
              },
            )),
      ),
    );
  }
}