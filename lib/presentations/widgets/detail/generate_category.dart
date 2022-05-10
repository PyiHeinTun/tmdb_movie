import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../datas/vos/genere_vo.dart';
import 'detail_chip.dart';
import '../../../res/app_theme.dart';
import '../../../utlity/minute_to_hm.dart';

List<Widget> generateCategory({
  required List<GenereVO>? genere,
  required BuildContext context,
  required int time,
}) {
  var list = <Widget>[];
  list.add(
    SizedBox(
      height: 35.h,
      width: 90.w,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Icon(
              Icons.watch_later_outlined,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              minuteToHM(time),
              style: MyTextStyle.movieCardSubtitle(context)
                  .copyWith(fontSize: 14.sp),
            ),
          ),
        ],
      ),
    ),
  );
  for (var data in genere ?? []) {
    list.add(DetailChip(name: data.name ?? ''));
  }
  return list;
}
