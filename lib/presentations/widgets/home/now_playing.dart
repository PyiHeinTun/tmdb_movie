import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tmdb_movie/blocs/home_bloc.dart';
import 'package:flutter_tmdb_movie/domain/entity/movie.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/shared/loading_indicator.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/shared/navigate_to_detail.dart';
import 'package:flutter_tmdb_movie/res/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class NowPlaying extends StatefulWidget {
  const NowPlaying({Key? key}) : super(key: key);

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  final PageController _controller = PageController(
    keepPage: true,
    viewportFraction: 1,
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.h,
      child: Selector<HomeBloc, List<Movie>?>(
          selector: (context, bloc) => bloc.nowPlayingMovies,
          builder: (context, state, child) {
            if (state != null) {
              return Stack(
                children: [
                  //Image Slider
                  PageView.builder(
                    padEnds: false,
                    controller: _controller,
                    scrollDirection: Axis.horizontal,
                    itemCount: state.take(5).length,
                    itemBuilder: (context, i) {
                      return NavigateToDetail(
                        movie: state[i],
                        child: AbsorbPointer(
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(
                                    "https://image.tmdb.org/t/p/original/" +
                                        state[i].backdropPath),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      stops: const [0.0, 0.8],
                                      colors: [
                                        Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withOpacity(1),
                                        Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withOpacity(0),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 50,
                                  top: 0.0,
                                  left: 0.0,
                                  right: 0.0,
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.play_circle,
                                      size: 68.sp,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 40.h,
                                      horizontal: 20.w,
                                    ),
                                    child: Text(
                                      state[i].title,
                                      style:
                                          MyTextStyle.sliderMovieName(context),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  //Dot Indicator
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SmoothPageIndicator(
                        effect: WormEffect(
                          dotWidth: 10.w,
                          dotHeight: 10.h,
                          activeDotColor:
                              Theme.of(context).colorScheme.secondary,
                          spacing: 15.w,
                        ),
                        controller: _controller,
                        count: state.take(5).length,
                        axisDirection: Axis.horizontal,
                      ),
                    ),
                  ),
                ],
              );
            }
            return const LoadingIndicator();
          }),
    );
  }
}
