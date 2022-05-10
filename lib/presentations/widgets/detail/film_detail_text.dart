import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';

import '../../../res/app_theme.dart';

class FlimDetailText extends StatelessWidget {
  final String title;
  final String text;
  const FlimDetailText({Key? key, required this.text, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: ScreenUtil().screenWidth * 0.23,
            child: Text(
              title,
              style: MyTextStyle.titleName(context).copyWith(
                color: Colors.grey[700],
                fontSize: 13.sp,
              ),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Flexible(
            child: Align(
              alignment: Alignment.centerLeft,
              child: ReadMoreText(
                text,
                trimLines: 5,
                colorClickableText: Colors.pink,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'MORE',
                trimExpandedText: 'LESS',
                moreStyle: MyTextStyle.titleName(context).copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                ),
                lessStyle: MyTextStyle.titleName(context).copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
