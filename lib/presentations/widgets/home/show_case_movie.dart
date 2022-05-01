import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tmdb_movie/presentations/bloc/movie_bloc/movie_bloc.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/shared/error_indicator.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/shared/loading_indicator.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/shared/navigate_to_detail.dart';
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
  void initState() {
    Provider.of<MovieBloc>(context, listen: false).add(GetShowCaseMovies());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.h,
      color: Colors.transparent,
      child: Column(
        children: [
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
          SizedBox(
            height: 170.h,
            width: double.infinity,
            child: NoGLow(
              child: BlocBuilder<MovieBloc, MovieState>(
                buildWhen: (previous, current) {
                  if (current is GetShowCaseMoviesError ||
                      current is GetShowCaseMoviesLoading ||
                      current is GetShowCaseMoviesLoaded) {
                    return true;
                  }
                  return false;
                },
                builder: (context, state) {
                  if (state is GetShowCaseMoviesError) {
                    return const ErrorIndicator();
                  } else if (state is GetShowCaseMoviesLoading) {
                    return const LoadingIndicator();
                  } else if (state is GetShowCaseMoviesLoaded) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, i) {
                        DateTime tempDate = DateFormat("yyyy-MM-dd")
                            .parse(state.movieList[i].releaseDate);
                        return NavigateToDetail(
                          movie: state.movieList[i],
                          child: SizedBox(
                            width: ScreenUtil().screenWidth * 0.75,
                            child: Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 20.w,
                                    right:
                                        state.movieList.take(5).length == i + 1
                                            ? 20.w
                                            : 0,
                                    top: 0.h,
                                    bottom: 0.h,
                                  ),
                                  height: double.infinity,
                                  width: double.infinity,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "https://image.tmdb.org/t/p/original/" +
                                            state.movieList[i].backdropPath,
                                    fit: BoxFit.cover,
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            const LoadingIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  top: 0.0,
                                  left: 20.w,
                                  right: 0.0,
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.play_circle,
                                      size: 50.sp,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 20.w,
                                  bottom: 0,
                                  child: Container(
                                    height: 170.h,
                                    width: ScreenUtil().screenWidth * 0.75,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.center,
                                        stops: const [0.0, 0.9],
                                        colors: [
                                          Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(0.8),
                                          Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(0),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 30.w,
                                  bottom: 10.h,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 120.w,
                                        child: Text(
                                          state.movieList[i].title,
                                          style: MyTextStyle.showCaseTitle(
                                              context),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 200.w,
                                        child: Text(
                                          DateFormat("dd MMMM yyyy")
                                              .format(tempDate),
                                          style: MyTextStyle.titleName(context)
                                              .copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.sp,
                                            color: Colors.white54,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: state.movieList.take(5).length,
                    );
                  }
                  return const LoadingIndicator();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
