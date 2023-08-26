import 'package:cpims_mobile/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData appTheme() {
  return ThemeData(
    primaryColor: kPrimaryColor,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[50],
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      elevation: 0.4,
      titleTextStyle: TextStyle(
        fontSize: ScreenUtil().setSp(18),
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    ),
    fontFamily: 'IBM Plex Sans',
    textSelectionTheme: const TextSelectionThemeData(
        cursorColor: kPrimaryColor, selectionColor: kPrimaryColor),
    textTheme: Typography.englishLike2021.apply(
        fontSizeFactor: 1.sp,
        bodyColor: Colors.black,
        fontFamily: 'IBM Plex Sans'),
  );
}
