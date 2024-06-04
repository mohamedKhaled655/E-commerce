import 'package:flutter/material.dart';

late bool themeSaved;

late double getHeight;
late double h5 = getHeight / 179.88;
late double h10 = getHeight / 89.5;

const kPrimaryColor = Color(0xffD69877);
final kbackground=Colors.blueGrey[50];
SnackBar showSnakBar({required String message,required BuildContext context,required Color backgroundColor,TextStyle? style}) {
  SnackBar snakBar = SnackBar(
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
    content: Text(
      message,
      style: style,
      textAlign: TextAlign.center,
    ),
    backgroundColor: backgroundColor,
    padding: const EdgeInsets.all(20),
    behavior: SnackBarBehavior.floating,
  );
  return snakBar;
}

String token="";
String language="en";
String name="";
String profileImage="https://img.freepik.com/free-photo/close-up-young-successful-man-smiling-camera-standing-casual-outfit-against-blue-background_1258-66609.jpg?w=996&t=st=1679187400~exp=1679188000~hmac=24958191102813240a24d739aa3b649b53902894aef815ed2e5ad386b99988c4";
String phone="";
String email="";

Map <int,bool>favorites={};

//int count=1;
Map<int,int>count={};
Map<int,int>price={};
int total=0;