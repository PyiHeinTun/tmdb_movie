import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../datas/vos/movie_vo.dart';
import 'detail_chip.dart';
import '../shared/loading_indicator.dart';
import '../shared/star_rating.dart';
import '../../../res/app_theme.dart';

class MyAppSpace extends StatelessWidget {
  final MovieVO? movie;
  const MyAppSpace({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime tempDate = movie!.releaseDate!.isNotEmpty
        ? DateFormat("yyyy-MM-dd").parse(movie!.releaseDate!)
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
                  imageUrl: movie?.backdropPath ?? '',
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
                      ? movie!.title!.length > 38
                          ? -12.h
                          : -25
                      : 10.h,
                  child: SizedBox(
                    width: ScreenUtil().screenWidth * 0.98,
                    height: 60.h,
                    child: Text(
                      movie?.title ?? '',
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
                            SizedBox(
                              child: Row(
                                children: getStar(movie?.voteAverage),
                              ),
                            ),
                            Text(
                              "${movie?.voteCount} VOTES",
                              style: MyTextStyle.movieCardSubtitle(context)
                                  .copyWith(color: Colors.white54),
                            ),
                          ],
                        ),
                        Text(
                          movie!.voteAverage.toString().replaceAll('.', ','),
                          key: Key(movie!.voteAverage
                              .toString()
                              .replaceAll('.', ',')),
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
