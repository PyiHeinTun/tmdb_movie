import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../datas/vos/movie_vo.dart';
import 'film_detail_text.dart';
import '../../../res/app_theme.dart';

class AboutFilm extends StatelessWidget {
  final MovieVO? movie;
  const AboutFilm({Key? key, required this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DateTime tempDate;
    try {
      tempDate = DateFormat("yyyy-MM-dd").parse(movie?.releaseDate ?? '');
    } catch (e) {
      tempDate = DateTime.now();
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Text(
              'detail.about_film'.tr(),
              style: MyTextStyle.titleName(context),
            ),
          ),
          FlimDetailText(
            title: "Original Title:",
            text: movie?.originalTitle ?? '',
          ),
          FlimDetailText(
            title: "Type:",
            text: movie?.generes?.first.name ?? '',
          ),
          FlimDetailText(
            title: "Production:",
            text: movie?.productionCountries?.first.name ?? '',
          ),
          FlimDetailText(
            title: "Premiere:",
            text: DateFormat("dd MMMM yyyy").format(tempDate),
          ),
          FlimDetailText(
            title: "Description:",
            text: movie?.overview ?? '',
          ),
        ],
      ),
    );
  }
}
