import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tmdb_movie/domain/entity/movie.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/detail/film_detail_text.dart';
import 'package:flutter_tmdb_movie/res/app_theme.dart';

class AboutFilm extends StatelessWidget {
  final Movie movie;
  const AboutFilm({Key? key, required this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DateTime tempDate;
    final String type = movie.generes.map((e) => e.name).toList().toString();
    try {
      tempDate = DateFormat("yyyy-MM-dd").parse(movie.releaseDate);
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
            text: movie.originalTitle,
          ),
          FlimDetailText(
            title: "Type:",
            text: type.substring(1, type.length - 1),
          ),
          FlimDetailText(
            title: "Production:",
            text: movie.productionCountries,
          ),
          FlimDetailText(
            title: "Premiere:",
            text: DateFormat("dd MMMM yyyy").format(tempDate),
          ),
          FlimDetailText(
            title: "Description:",
            text: movie.overview,
          ),
        ],
      ),
    );
  }
}
