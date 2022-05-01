import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tmdb_movie/presentations/bloc/person_bloc/person_bloc.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/shared/error_indicator.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/shared/loading_indicator.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/shared/person_card.dart';
import 'package:flutter_tmdb_movie/res/app_theme.dart';
import 'package:flutter_tmdb_movie/utlity/no_glow.dart';
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
  void initState() {
    Provider.of<PersonBloc>(context, listen: false).add(GetPopularActors());
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
              SizedBox(
                height: 180.h,
                child: BlocBuilder<PersonBloc, PersonState>(
                  buildWhen: (previous, current) {
                    if (current is GetPopularActorsError ||
                        current is GetPopularActorsLoading ||
                        current is GetPopularActorsLoaded) {
                      return true;
                    }
                    return false;
                  },
                  builder: (context, state) {
                    if (state is GetPopularActorsError) {
                      return const ErrorIndicator();
                    } else if (state is GetPopularActorsLoading) {
                      return const LoadingIndicator();
                    } else if (state is GetPopularActorsLoaded) {
                      return NoGLow(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: EdgeInsets.only(
                                left: i == 0 ? 20.w : 0,
                                right:
                                    i + 1 == state.personList.personList.length
                                        ? 20.w
                                        : 0,
                              ),
                              child: PersonCard(
                                  person: state.personList.personList[i]),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              width: 10.w,
                            );
                          },
                          itemCount: state.personList.personList.length,
                        ),
                      );
                    }
                    return const LoadingIndicator();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
