import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tmdb_movie/res/app_theme.dart';

// ignore: must_be_immutable
class DetailChip extends StatelessWidget {
  final String name;
  double width;
  Color color;
  DetailChip(
      {Key? key, required this.name, this.width = 0, this.color = Colors.grey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    color =
        color == Colors.grey ? const Color(0xFF242A32).withOpacity(0.8) : color;
    return Container(
      padding: EdgeInsets.all(12.h),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.black, width: 0.0),
        borderRadius: BorderRadius.circular(30.sp),
      ),
      child: Text(
        name,
        style: MyTextStyle.movieCardSubtitle(context).copyWith(fontSize: 12.sp),
      ),
    );
  }
}
