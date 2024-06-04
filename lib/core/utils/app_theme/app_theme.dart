
import 'package:e_shop/core/constant.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme=ThemeData.light().copyWith(
  primaryColor: kPrimaryColor,
  bottomAppBarColor: Colors.white,
  backgroundColor: kPrimaryColor,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: kbackground,

  ),
  useMaterial3: true,
  textTheme: TextTheme(
    titleLarge:const TextStyle(
       fontSize: 25,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ) ,
    titleMedium:const TextStyle(
      fontSize: 16,
      height: 1.3,
      fontWeight: FontWeight.w500,
      color: Colors.black26,
    ),
    titleSmall:const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Colors.black38,
    ),
    headlineMedium:const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    headlineSmall:const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.black45,
    ),
    headlineLarge: TextStyle(
     
      color: kbackground,
      backgroundColor: Colors.white
    ),
    
    
  ),
  appBarTheme:const AppBarTheme(
    backgroundColor: Colors.white10,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: kPrimaryColor,
      fontSize: 22,
      fontWeight: FontWeight.bold
    ) ,
    

  ), 
  iconTheme: IconThemeData(
    color: kPrimaryColor.withOpacity(.1),
  ),
  buttonTheme:const ButtonThemeData(
    buttonColor: Colors.black,
  )
);

/////////

ThemeData darkTheme=ThemeData.dark().copyWith(
  primaryColor: Colors.white,
  bottomAppBarColor: Colors.black12,
  
  useMaterial3: true,
  bottomNavigationBarTheme:const BottomNavigationBarThemeData(
    backgroundColor: Colors.black12,
    
  ),
  appBarTheme:const AppBarTheme(
    backgroundColor: Colors.black12,
    elevation: 0,
    titleTextStyle:TextStyle(
      color: Colors.white,
      fontSize: 22,
      fontWeight: FontWeight.bold
    ) ,
    foregroundColor: kPrimaryColor,
    shadowColor: kPrimaryColor,
  ),
  
  textTheme: const TextTheme(
    
    titleLarge: TextStyle(
       fontSize: 25,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ) ,
    titleMedium: TextStyle(
      fontSize: 16,
      height: 1.3,
      fontWeight: FontWeight.w500,
      color: Colors.white24,
    ),
    titleSmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: Colors.white24,
    ),
    headlineMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    //دا بتاع لون السيرش
    headlineLarge: TextStyle(
     
      color: Colors.white12,
      backgroundColor: Colors.black
    ),
    
    
  ),
  iconTheme: IconThemeData(
    color: const Color(0xff1f222a).withOpacity(.2),

  ),

  buttonTheme:const ButtonThemeData(
    buttonColor:  Colors.white,
  )
);