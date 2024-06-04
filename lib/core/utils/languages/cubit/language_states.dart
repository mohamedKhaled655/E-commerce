import 'package:flutter/material.dart';

abstract class LanguagesStates{}
class LanguagesInitStates extends LanguagesStates{}
class ChangeLanguageLocalstates extends LanguagesStates{
  final Locale locale;
  ChangeLanguageLocalstates({
    required this.locale,
  });
}