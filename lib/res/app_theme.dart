import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  //==== Light Theme ====//
  static final light = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF19212D),
      primaryVariant: Colors.white70,
      secondary: Colors.yellow,
      secondaryVariant: Color(0xFF1E2634),
      background: Color(0xFF151B25),
    ),
  );

  //==== Dark Theme ====//
}

class MyTextStyle {
  static TextStyle sliderMovieName(BuildContext context) {
    return TextStyle(
      fontSize: 25.sp,
      color: Colors.white70,
    );
  }

  static TextStyle titleName(BuildContext context) {
    return TextStyle(
      fontSize: 12.sp,
      color: Colors.grey.shade600,
    );
  }

  static TextStyle movieCardTitle(BuildContext context) {
    return TextStyle(
      fontSize: 15.sp,
      color: Colors.white70,
    );
  }

  static TextStyle movieCardSubtitle(BuildContext context) {
    return TextStyle(
      fontSize: 12.sp,
      color: Colors.white70,
    );
  }

  static TextStyle checkMovieShowtime(BuildContext context) {
    return TextStyle(
      fontSize: 22.sp,
      color: Colors.white70,
      height: 1.2.sp,
    );
  }

  static TextStyle showCaseTitle(BuildContext context) {
    return TextStyle(
      fontSize: 15.sp,
      color: Colors.white,
      height: 1.2.sp,
    );
  }
}
