import 'package:chart_ganga/constants/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
        scaffoldBackgroundColor: CustomColors.white,
        textTheme: TextTheme(
            headline2: TextStyle(
                fontSize: 18,
                color: CustomColors.black,
                fontFamily: "PoppinsBold"),
            headline3: TextStyle(
                fontSize: 16,
                fontFamily: "PoppinsRegular",
                color: CustomColors.black),
            bodyText1: TextStyle(
                fontFamily: "PoppinsLight",
                fontSize: 14,
                color: CustomColors.black),
            bodyText2: TextStyle(
                fontFamily: "PoppinsRegular",
                fontSize: 14,
                color: CustomColors.greyDark),
            button: TextStyle(
                fontFamily: "PoppinsBold",
                fontSize: 14,
                color: CustomColors.white)));
  }
}
