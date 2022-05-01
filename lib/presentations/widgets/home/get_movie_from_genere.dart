import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tmdb_movie/presentations/bloc/genere_bloc/genere_bloc.dart';
import 'package:flutter_tmdb_movie/presentations/bloc/movie_bloc/movie_bloc.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/shared/error_indicator.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/shared/loading_indicator.dart';
import 'package:flutter_tmdb_movie/utlity/no_glow.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/shared/movie_card.dart';

class GetMovieFromGenere extends StatefulWidget {
  const GetMovieFromGenere({Key? key}) : super(key: key);

  @override
  State<GetMovieFromGenere> createState() => _GetMovieFromGenereState();
}

class _GetMovieFromGenereState extends State<GetMovieFromGenere>
    with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    Provider.of<GenereBloc>(context, listen: false).add(GetAllGenere());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GenereBloc, GenereState>(
      listener: (context, state) {
        if (state is GenereLoaded) {
          _controller = TabController(
            length: state.genereList.length,
            vsync: this,
          );
          Provider.of<MovieBloc>(context, listen: false).add(GetMoviesByGenere(
            genereId: state.genereList[1].id,
          ));
        }
      },
      child: Column(
        children: [
          BlocBuilder<GenereBloc, GenereState>(
            builder: (context, state) {
              if (state is GenereError) {
                return const ErrorIndicator();
              } else if (state is GenereLoading) {
                return const LoadingIndicator();
              } else if (state is GenereLoaded) {
                return Theme(
                  data: ThemeData().copyWith(splashColor: Colors.transparent),
                  child: TabBar(
                    indicatorColor: Theme.of(context).colorScheme.secondary,
                    indicatorPadding: EdgeInsets.only(left: 10.w),
                    labelPadding: EdgeInsets.symmetric(horizontal: 10.w),
                    isScrollable: true,
                    unselectedLabelColor: Colors.grey.shade600,
                    controller: _controller,
                    tabs: List.generate(
                      state.genereList.length,
                      (index) => Padding(
                        padding: EdgeInsets.only(
                          left: 10.w,
                        ),
                        child: Tab(
                          text: state.genereList[index].name,
                        ),
                      ),
                    ),
                    onTap: (value) {
                      Provider.of<MovieBloc>(context, listen: false)
                          .add(GetMoviesByGenere(
                        genereId: state.genereList[value].id,
                      ));
                    },
                  ),
                );
              }
              return const LoadingIndicator();
            },
          ),
          Container(
            height: 270.h,
            color: Theme.of(context).colorScheme.background,
            child: BlocBuilder<MovieBloc, MovieState>(
                buildWhen: (previous, current) {
              if (current is GetMoviesByGenereError ||
                  current is GetMoviesByGenereLoading ||
                  current is GetMoviesByGenereLoaded) {
                return true;
              }
              return false;
            }, builder: (context, state) {
              if (state is GetMoviesByGenereError) {
                return const ErrorIndicator();
              } else if (state is GetMoviesByGenereLoading) {
                return const LoadingIndicator();
              } else if (state is GetMoviesByGenereLoaded) {
                return NoGLow(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 20.w,
                      );
                    },
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: EdgeInsets.only(
                          left: i == 0 ? 20.w : 0,
                          right: i + 1 == state.movieList.length ? 20.w : 0,
                          top: 0.h,
                          bottom: 0.h,
                        ),
                        child: MovieCard(
                          movie: state.movieList[i],
                        ),
                      );
                    },
                    itemCount: state.movieList.length,
                  ),
                );
              }
              return const LoadingIndicator();
            }),
          ),
        ],
      ),
    );
  }
}
