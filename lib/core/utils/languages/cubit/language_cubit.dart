

import 'package:e_shop/core/constant.dart';
import 'package:e_shop/core/utils/languages/language_cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'language_states.dart';

class LanguagesCubit extends Cubit<LanguagesStates> {
  LanguagesCubit() : super(LanguagesInitStates());

  static LanguagesCubit get(context)=>BlocProvider.of(context);


  Future<void> getSavedLanguage() async {
    final String cachedLanguageCode =await LanguageCacheHelper().getCachedLanguageCode();
    language=cachedLanguageCode;
    emit(ChangeLanguageLocalstates(locale: Locale(cachedLanguageCode)));
  }

  Future<void> changeLanguage(String languageCode) async {
    await LanguageCacheHelper().cacheLanguageCode(languageCode);
    language=languageCode;
    emit(ChangeLanguageLocalstates(locale: Locale(languageCode)));
  }
}