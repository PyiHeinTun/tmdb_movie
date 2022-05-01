import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tmdb_movie/domain/entity/person.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/shared/loading_indicator.dart';
import 'package:flutter_tmdb_movie/res/app_theme.dart';

class PersonCard extends StatelessWidget {
  final Person person;
  PersonCard({Key? key, required this.person}) : super(key: key);

  final ValueNotifier<bool> _isFav = ValueNotifier(false);
  final ValueNotifier<bool> _isLike = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    _isFav.value;
    _isLike.value;
    return Stack(
      children: [
        SizedBox(
          width: ScreenUtil().screenWidth * 0.4,
          height: double.infinity,
          child: CachedNetworkImage(
            imageUrl: "https://image.tmdb.org/t/p/w300_and_h450_face/" +
                person.profilePath,
            fit: BoxFit.cover,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                const LoadingIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        Positioned(
          left: 0.w,
          bottom: 0,
          child: Container(
            height: 170.h,
            width: ScreenUtil().screenWidth * 0.75,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                stops: const [0.0, 1],
                colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(1),
                  Theme.of(context).colorScheme.primary.withOpacity(0),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 10.w,
          bottom: 5.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 120.w,
                child: Text(
                  person.name,
                  style: MyTextStyle.showCaseTitle(context),
                ),
              ),
              SizedBox(
                width: 200.w,
                child: Row(
                  children: [
                    ValueListenableBuilder<bool>(
                      valueListenable: _isLike,
                      builder: (context, value, child) {
                        return GestureDetector(
                          onTap: () {
                            _isLike.value = !_isLike.value;
                          },
                          child: Icon(
                            value ? Icons.thumb_up_alt : Icons.thumb_up_off_alt,
                            color: Colors.yellow,
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "YOU LIKE 18 MOVIES",
                      style: MyTextStyle.titleName(context).copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 10.sp,
                        color: Colors.white54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 5.w,
          top: 5.h,
          child: ValueListenableBuilder<bool>(
            valueListenable: _isFav,
            builder: (context, value, child) {
              return GestureDetector(
                onTap: () {
                  _isFav.value = !_isFav.value;
                },
                child: Icon(
                  value ? Icons.favorite : Icons.favorite_outline,
                  color: value ? Colors.yellow : Colors.white,
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
