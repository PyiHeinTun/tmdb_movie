import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tmdb_movie/presentations/bloc/movie_bloc/movie_bloc.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/shared/error_indicator.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/shared/loading_indicator.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/shared/movie_card.dart';
import 'package:flutter_tmdb_movie/utlity/no_glow.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tmdb_movie/res/app_theme.dart';

class PopularMovies extends StatefulWidget {
  const PopularMovies({Key? key}) : super(key: key);

  @override
  State<PopularMovies> createState() => _PopularMoviesState();
}

class _PopularMoviesState extends State<PopularMovies> {
  @override
  void initState() {
    Provider.of<MovieBloc>(context, listen: false).add(GetPopularMovies());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h, bottom: 0.h),
          child: Text(
            'home.popular_movie'.tr(),
            style: MyTextStyle.titleName(context),
          ),
        ),
        SizedBox(
          height: 270.h,
          child: NoGLow(
            child: BlocBuilder<MovieBloc, MovieState>(
              buildWhen: (previous, current) {
                if (current is GetPopularMoviesError ||
                    current is GetPopularMoviesLoading ||
                    current is GetPopularMoviesLoaded) {
                  return true;
                }
                return false;
              },
              builder: (context, state) {
                if (state is GetPopularMoviesError) {
                  return const ErrorIndicator();
                } else if (state is GetPopularMoviesLoading) {
                  return const LoadingIndicator();
                } else if (state is GetPopularMoviesLoaded) {
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
                          right: i + 1 == state.movieList.length ? 20.w : 0,
                        ),
                        child: MovieCard(
                          movie: state.movieList[i],
                        ),
                      );
                    },
                    itemCount: state.movieList.length,
                  );
                }
                return const LoadingIndicator();
              },
            ),
          ),
        )
      ],
    );
  }
}
