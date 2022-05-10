import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../blocs/home_bloc.dart';
import '../../../datas/vos/person_vo.dart';
import '../shared/loading_indicator.dart';
import '../shared/person_card.dart';
import '../../../res/app_theme.dart';
import '../../../utlity/no_glow.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopularActors extends StatefulWidget {
  const PopularActors({Key? key}) : super(key: key);

  @override
  State<PopularActors> createState() => _PopularActorsState();
}

class _PopularActorsState extends State<PopularActors>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Title For Popular Actors
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
                    Text(
                      "home.best_actors".tr(),
                      style: MyTextStyle.titleName(context),
                    ),
                    Text(
                      "home.more_actors".tr(),
                      style: MyTextStyle.movieCardSubtitle(context).copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),

              //Actors List
              SizedBox(
                  height: 180.h,
                  child: Selector<HomeBloc, List<PersonVO>?>(
                    selector: (context, bloc) => bloc.popularActors,
                    builder: (context, state, child) {
                      if (state != null) {
                        return NoGLow(
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, i) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  left: i == 0 ? 20.w : 0,
                                  right: i + 1 == state.length ? 20.w : 0,
                                ),
                                child: PersonCard(person: state[i]),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                width: 10.w,
                              );
                            },
                            itemCount: state.length,
                          ),
                        );
                      }
                      return const LoadingIndicator();
                    },
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
