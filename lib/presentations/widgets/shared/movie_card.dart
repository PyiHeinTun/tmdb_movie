import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../datas/vos/movie_vo.dart';
import 'loading_indicator.dart';
import 'navigate_to_detail.dart';
import 'star_rating.dart';
import '../../../res/app_theme.dart';
// ignore: import_of_legacy_library_into_null_safe
// import 'package:smooth_star_rating/smooth_star_rating.dart';

class MovieCard extends StatelessWidget {
  final MovieVO? movie;
  const MovieCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavigateToDetail(
      key: Key(movie?.id.toString() ?? ''),
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
                cacheKey: movie?.id.toString(),
                imageUrl: movie?.backdropPath ?? '',
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
                movie?.title ?? '',
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
                  movie?.voteAverage.toString().replaceAll('.', ',') ?? '',
                  style: MyTextStyle.movieCardSubtitle(context),
                ),
                SizedBox(
                  width: 10.w,
                ),
                SizedBox(
                  child: Row(
                    children: getStar(movie?.voteAverage),
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
