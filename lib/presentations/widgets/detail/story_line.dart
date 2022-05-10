import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../datas/vos/movie_vo.dart';
import 'play_button.dart';
import '../../../res/app_theme.dart';

class StoryLine extends StatelessWidget {
  final MovieVO? movie;
  const StoryLine({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 30.h, bottom: 0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "detail.storyline".tr(),
            style: MyTextStyle.titleName(context),
          ),
          Container(
            padding: EdgeInsets.only(top: 20.h),
            child: Text(
              movie?.overview ?? '',
              style: MyTextStyle.movieCardSubtitle(context)
                  .copyWith(fontSize: 14.sp),
            ),
          ),
          Container(
            width: ScreenUtil().screenWidth * 0.8,
            padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PlayButton(
                  backgroudBlur: false,
                  icon: Icons.play_circle,
                  text: 'detail.play_trailer'.tr(),
                ),
                PlayButton(
                  backgroudBlur: true,
                  icon: Icons.star,
                  text: 'detail.rate_movie'.tr(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
