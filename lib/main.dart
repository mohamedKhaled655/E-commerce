import 'package:e_shop/core/constant.dart';
import 'package:e_shop/core/utils/app_theme/app_theme.dart';
import 'package:e_shop/core/utils/app_theme/theme_cubit/theme_cubit.dart';
import 'package:e_shop/core/utils/app_theme/theme_cubit/theme_states.dart';
import 'package:e_shop/core/utils/languages/cubit/language_cubit.dart';
import 'package:e_shop/core/utils/languages/cubit/language_states.dart';
import 'package:e_shop/features/cart/presentation/view_model/cart_cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/bloc_observer.dart';
import 'core/utils/app_router.dart';
import 'core/utils/languages/app_localizations.dart';
import 'core/utils/service_locator.dart';
import 'core/widgets/custom_loading_widget.dart';
import 'features/home/data/repo/home_repo_imp.dart';
import 'features/setting.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  Bloc.observer = MyBlocObserver();
  //to get the value of theme
  final sharedPreferences = await SharedPreferences.getInstance();
  themeSaved = sharedPreferences.getBool("isDark") ?? false;
  ////

  runApp(MyApp(
    savedThemed: themeSaved,
  ));
}

class MyApp extends StatelessWidget {
  final bool savedThemed;
  const MyApp({Key? key, required this.savedThemed}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit()..changeTheme(cached: savedThemed),
      child: BlocBuilder<ThemeCubit, ThemeStates>(
        builder: (context, state) {
          //var cubit=ThemeCubit.get(context);
          return BlocProvider(
            create: (context) => LanguagesCubit()..getSavedLanguage(),
            child: BlocBuilder<LanguagesCubit, LanguagesStates>(
              builder: (context, state) {
                if (state is ChangeLanguageLocalstates) {
                  return MaterialApp.router(
                    title: 'E-Shop',
                    debugShowCheckedModeBanner: false,
                    theme: lightTheme,
                    darkTheme: darkTheme,
                    themeMode: ThemeCubit.get(context).isDark
                        ? ThemeMode.dark
                        : ThemeMode.light,
                    locale: state.locale,
                    supportedLocales: const [Locale("en"), Locale("ar")],
                    localizationsDelegates: const [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                  
                      ///دا اللي بيحدد اتجاه ال ودجيت
                      GlobalCupertinoLocalizations.delegate
                    ],
                    localeResolutionCallback: (deviceLocale, supportedLocales) {
                      //ال فور لوب دي معموله عشان اشوف اذا كان النطبيق بيتدعم له الهاتف ولا لا
                      // يعني مثلا لغه الهاتف الماني وانا محدد في التطبيق عربي وانجليزي بس فكان هيحصل مشكله
                      for (var locale in supportedLocales) {
                        if (deviceLocale != null &&
                            deviceLocale.languageCode == locale.languageCode) {
                          return deviceLocale;
                        }
                      }
                      return supportedLocales.first;
                    },
                    //home: const MainPage(),
                    routeInformationParser:
                        AppRouter.router.routeInformationParser,
                    routerDelegate: AppRouter.router.routerDelegate,
                  );
                } else {
                  return const CustomLoadingWidget();
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("appTitle".tr(context)),
        actions: [
          IconButton(
              onPressed: () {
                ThemeCubit.get(context).changeTheme();
              },
              icon: const Icon(Icons.brightness_4_outlined)),
          IconButton(
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const SettingsPage())),
              icon: const Icon(Icons.settings))
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    ThemeCubit.get(context).changeTheme();
                  },
                  icon: const Icon(Icons.brightness_4_outlined),
                ),
                BlocBuilder<LanguagesCubit, LanguagesStates>(
                  builder: (context, state) {
                    if (state is ChangeLanguageLocalstates) {
                      return DropdownButton<String>(
                        value: state.locale.languageCode,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: ['ar', 'en'].map((String items) {
                          return DropdownMenuItem<String>(
                            value: items,
                            child: Text(items == "en" ? "English" : "عربي"),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            BlocProvider.of<LanguagesCubit>(context)
                                .changeLanguage(newValue);
                            //context.read<LanguagesCubit>().changeLanguage(newValue);
                            // Navigator.pop(context);
                          }
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
