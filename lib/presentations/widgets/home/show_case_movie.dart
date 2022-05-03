import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tmdb_movie/blocs/home_bloc.dart';
import 'package:flutter_tmdb_movie/domain/entity/movie.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/home/show_case_movie_detail.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/shared/loading_indicator.dart';

import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tmdb_movie/res/app_theme.dart';
import 'package:flutter_tmdb_movie/utlity/no_glow.dart';

class ShowCaseMovie extends StatefulWidget {
  const ShowCaseMovie({Key? key}) : super(key: key);

  @override
  State<ShowCaseMovie> createState() => _ShowCaseMovieState();
}

class _ShowCaseMovieState extends State<ShowCaseMovie> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.h,
      color: Colors.transparent,
      child: Column(
        children: [
          //Title for showcase Movies
          Padding(
            padding: EdgeInsets.only(
                left: 20.w, right: 20.w, top: 20.h, bottom: 20.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "home.show_cases".tr(),
                  style: MyTextStyle.titleName(context),
                ),
                Text(
                  "home.more_showcases".tr(),
                  style: MyTextStyle.movieCardSubtitle(context).copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),

          //Show Case Movies
          SizedBox(
            height: 170.h,
            width: double.infinity,
            child: NoGLow(
                child: Selector<HomeBloc, List<Movie>?>(
              selector: (context, bloc) => bloc.showCaseMovies,
              builder: (context, state, child) {
                if (state != null) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, i) {
                      return ShowCaseMovieDetail(
                        i: i,
                        movie: state[i],
                        movieList: state,
                      );
                    },
                    itemCount: state.take(5).length,
                  );
                }
                return const LoadingIndicator();
              },
            )),
          ),
        ],
      ),
    );
  }
}
