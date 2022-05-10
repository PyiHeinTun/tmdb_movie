import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../blocs/home_bloc.dart';
import '../../../datas/vos/movie_vo.dart';
import '../shared/loading_indicator.dart';
import '../shared/movie_card.dart';
import '../../../utlity/no_glow.dart';
import 'package:provider/provider.dart';
import '../../../res/app_theme.dart';

class PopularMovies extends StatefulWidget {
  const PopularMovies({Key? key}) : super(key: key);

  @override
  State<PopularMovies> createState() => _PopularMoviesState();
}

class _PopularMoviesState extends State<PopularMovies> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Title for popular movies
        Padding(
          padding:
              EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h, bottom: 0.h),
          child: Text(
            'home.popular_movie'.tr(),
            style: MyTextStyle.titleName(context),
          ),
        ),

        //Movie List
        SizedBox(
          height: 270.h,
          child: NoGLow(
            child: Selector<HomeBloc, List<MovieVO>?>(
              selector: (context, bloc) => bloc.popularMovies,
              builder: (context, state, child) {
                if (state != null) {
                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 20.w,
                      );
                    },
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: EdgeInsets.only(
                          left: i == 0 ? 20.w : 0,
                          right: i + 1 == state.length ? 20.w : 0,
                        ),
                        child: MovieCard(
                          movie: state[i],
                        ),
                      );
                    },
                    itemCount: state.length,
                  );
                }
                return const LoadingIndicator();
              },
            ),
          ),
        ),
      ],
    );
  }
}
