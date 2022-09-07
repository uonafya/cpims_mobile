import 'package:cpims_mobile/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      titleTextStyle: GoogleFonts.openSans(
        fontSize: ScreenUtil().setSp(18),
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    ),
    fontFamily: GoogleFonts.openSans().fontFamily,
    textSelectionTheme: const TextSelectionThemeData(
        cursorColor: kPrimaryColor, selectionColor: kPrimaryColor),
    textTheme: Typography.englishLike2021.apply(
        fontSizeFactor: 1.sp,
        bodyColor: Colors.black,
        fontFamily: GoogleFonts.ibmPlexSans().fontFamily),
  );
}
