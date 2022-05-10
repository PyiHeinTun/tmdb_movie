import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../res/app_theme.dart';

class CheckMovieTime extends StatelessWidget {
  const CheckMovieTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 10.h),
      width: double.infinity,
      height: 130.h,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryVariant,
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LayoutBuilder(
                builder: (context, constraint) {
                  return Container(
                    padding: EdgeInsets.all(16.sp),
                    width: constraint.maxWidth * 0.7,
                    child: Text(
                      "home.show_times".tr(),
                      style: MyTextStyle.checkMovieShowtime(context),
                    ),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, top: 20.h),
                child: Text(
                  'home.see_more'.tr(),
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Image.asset('assets/images/location.png'),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 40.w, bottom: 20.h),
              child: Icon(
                Icons.location_on,
                color: Theme.of(context).colorScheme.primaryVariant,
              ),
            ),
          )
        ],
      ),
    );
  }
}
