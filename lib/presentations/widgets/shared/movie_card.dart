import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tmdb_movie/domain/entity/movie.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/shared/loading_indicator.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/shared/navigate_to_detail.dart';
import 'package:flutter_tmdb_movie/res/app_theme.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:smooth_star_rating/smooth_star_rating.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavigateToDetail(
      movie: movie,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 230.h * 0.7,
              width: 120.w,
              child: CachedNetworkImage(
                cacheKey: movie.id.toString(),
                imageUrl: "https://image.tmdb.org/t/p/w300_and_h450_face/" +
                    movie.backdropPath,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    const LoadingIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              width: 120.w,
              height: 35.sp,
              child: Text(
                movie.title,
                style: MyTextStyle.movieCardTitle(context),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            SizedBox(
                child: Row(
              children: [
                Text(
                  movie.voteAverage.toString().replaceAll('.', ','),
                  style: MyTextStyle.movieCardSubtitle(context),
                ),
                SizedBox(
                  width: 10.w,
                ),
                SmoothStarRating(
                  allowHalfRating: false,
                  onRated: (v) {},
                  starCount: 5,
                  rating: 5 * (movie.voteAverage / 10),
                  size: 12.sp,
                  isReadOnly: true,
                  color: Theme.of(context).colorScheme.secondary,
                  borderColor: Theme.of(context).colorScheme.secondary,
                  spacing: 0.0,
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
