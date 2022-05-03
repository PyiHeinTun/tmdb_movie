import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tmdb_movie/domain/entity/movie.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/shared/loading_indicator.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/shared/navigate_to_detail.dart';
import 'package:flutter_tmdb_movie/res/app_theme.dart';

class ShowCaseMovieDetail extends StatelessWidget {
  final Movie movie;
  final List<Movie> movieList;
  final int i;
  const ShowCaseMovieDetail({
    Key? key,
    required this.movie,
    required this.movieList,
    required this.i,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime tempDate = DateFormat("yyyy-MM-dd").parse(movie.releaseDate);
    return NavigateToDetail(
      movie: movie,
      child: SizedBox(
        width: ScreenUtil().screenWidth * 0.75,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(
                left: 20.w,
                right: movieList.take(5).length == i + 1 ? 20.w : 0,
                top: 0.h,
                bottom: 0.h,
              ),
              height: double.infinity,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl:
                    "https://image.tmdb.org/t/p/original/" + movie.backdropPath,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    const LoadingIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
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
                  color: Theme.of(context).colorScheme.secondary,
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
                      Theme.of(context).colorScheme.primary.withOpacity(0.8),
                      Theme.of(context).colorScheme.primary.withOpacity(0),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 30.w,
              bottom: 10.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 120.w,
                    child: Text(
                      movie.title,
                      style: MyTextStyle.showCaseTitle(context),
                    ),
                  ),
                  SizedBox(
                    width: 200.w,
                    child: Text(
                      DateFormat("dd MMMM yyyy").format(tempDate),
                      style: MyTextStyle.titleName(context).copyWith(
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
  }
}
