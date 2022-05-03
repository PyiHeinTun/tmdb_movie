import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tmdb_movie/domain/entity/person.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/shared/person_card.dart';
import 'package:flutter_tmdb_movie/res/app_theme.dart';
import 'package:flutter_tmdb_movie/utlity/no_glow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActorsCrews extends StatefulWidget {
  final List<Person> person;
  final bool isActor;

  ///TO USE THIS YOU MUST CALL BLOC FOR ACTORS AND CREWS
  ///
  ///
  const ActorsCrews({Key? key, required this.isActor, required this.person})
      : super(key: key);

  @override
  State<ActorsCrews> createState() => _ActorsCrewsState();
}

class _ActorsCrewsState extends State<ActorsCrews>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 280.h,
          color: Theme.of(context).colorScheme.background,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: 20.w, right: 20.h, top: 30.h, bottom: 15.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.isActor
                        ? Text(
                            "detail.actors".tr(),
                            style: MyTextStyle.titleName(context),
                          )
                        : Text(
                            "detail.creators".tr(),
                            style: MyTextStyle.titleName(context),
                          ),
                    !widget.isActor
                        ? Text(
                            "home.more_actors".tr(),
                            style:
                                MyTextStyle.movieCardSubtitle(context).copyWith(
                              decoration: TextDecoration.underline,
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              SizedBox(
                height: 180.h,
                child: NoGLow(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: EdgeInsets.only(
                          left: i == 0 ? 20.w : 0,
                          right: i + 1 == widget.person.length ? 20.w : 0,
                        ),
                        child: PersonCard(
                          person: widget.person[i],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 10.w,
                      );
                    },
                    itemCount: widget.person.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
