import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tmdb_movie/domain/entity/movie.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/detail/detail_chip.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/shared/loading_indicator.dart';
import 'package:flutter_tmdb_movie/res/app_theme.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:smooth_star_rating/smooth_star_rating.dart';

class MyAppSpace extends StatelessWidget {
  final Movie movie;
  const MyAppSpace({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime tempDate = movie.releaseDate.isNotEmpty
        ? DateFormat("yyyy-MM-dd").parse(movie.releaseDate)
        : DateTime.now();
    return LayoutBuilder(
      builder: (context, c) {
        final settings = context
            .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
        final deltaExtent = settings!.maxExtent - settings.minExtent;
        final t =
            (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent)
                .clamp(0.0, 1.0);
        final fadeStart = math.max(0.0, 1.0 - kToolbarHeight / deltaExtent);
        const fadeEnd = 1.0;
        final opacity = 1.0 - Interval(fadeStart, fadeEnd).transform(t);
        final ValueNotifier<double> _opacity = ValueNotifier(opacity);
        return Stack(
          children: [
            Opacity(
              opacity: opacity,
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: "https://image.tmdb.org/t/p/w1000_and_h563_face/" +
                      movie.backdropPath,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      const LoadingIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: const [0.0, 0.8],
                  colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(1),
                    Theme.of(context).colorScheme.primary.withOpacity(0),
                  ],
                ),
              ),
            ),
            ValueListenableBuilder<double>(
              valueListenable: _opacity,
              builder: (context, value, child) {
                return Positioned(
                  left: (value + 4) / 5 == 1 ? 20.w : (value + 5) * 12,
                  right: (value + 4) / 5 == 1 ? 20 : (value + 5) * 5,
                  bottom: value < 1
                      ? movie.title.length > 38
                          ? -12.h
                          : -25
                      : 10.h,
                  child: SizedBox(
                    width: ScreenUtil().screenWidth * 0.98,
                    height: 60.h,
                    child: Text(
                      movie.title,
                      style: MyTextStyle.sliderMovieName(context).copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize:
                            (value + 4) / 5 == 1 ? 24.sp : (value + 5) * 3,
                      ),
                    ),
                  ),
                );
              },
            ),
            Positioned(
              bottom: 80.h,
              left: 20.w,
              right: 20.w,
              child: Opacity(
                opacity: opacity < 1 ? 0 : 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DetailChip(
                      name: tempDate.year.toString(),
                      width: 50.w,
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.8),
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            SmoothStarRating(
                              allowHalfRating: false,
                              onRated: (v) {},
                              starCount: 5,
                              rating: 5 * (movie.voteAverage / 10),
                              size: 12.sp,
                              isReadOnly: true,
                              color: Theme.of(context).colorScheme.secondary,
                              borderColor:
                                  Theme.of(context).colorScheme.secondary,
                              spacing: 0.0,
                            ),
                            Text(
                              "${movie.voteCount} VOTES",
                              style: MyTextStyle.movieCardSubtitle(context)
                                  .copyWith(color: Colors.white54),
                            ),
                          ],
                        ),
                        Text(
                          movie.voteAverage.toString().replaceAll('.', ','),
                          style:
                              MyTextStyle.movieCardSubtitle(context).copyWith(
                            fontSize: 40.sp,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
