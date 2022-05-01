import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tmdb_movie/domain/entity/genere.dart';
import 'package:flutter_tmdb_movie/presentations/bloc/movie_bloc/movie_bloc.dart';
import 'package:flutter_tmdb_movie/presentations/bloc/person_bloc/person_bloc.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/detail/about_film.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/detail/actors_crews.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/shared/error_indicator.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/shared/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tmdb_movie/domain/entity/movie.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/detail/generate_category.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/detail/sliver_app_bar.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/detail/story_line.dart';
import 'package:flutter_tmdb_movie/utlity/no_glow.dart';

bool firstTime = true;

class DetailPage extends StatefulWidget {
  final Movie movie;
  const DetailPage({Key? key, required this.movie}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  // late List<Genere> genere = widget.movie.generes;
  int numberOfLetters = 0;
  int runningTime = 0;
  @override
  void initState() {
    Provider.of<MovieBloc>(context, listen: false)
        .add(GetMovieDetailById(movieId: widget.movie.id.toString()));
    Provider.of<PersonBloc>(context, listen: false)
        .add(GetActorsAndCrews(movieId: widget.movie.id.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: NestedScrollView(
        headerSliverBuilder: (context, f) {
          return [
            MySliverAppBar(
              movie: widget.movie,
            ),
          ];
        },
        body: NoGLow(
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              BlocBuilder<MovieBloc, MovieState>(
                buildWhen: (previous, current) {
                  if (previous is GetMoviesByGenereLoaded) {
                    firstTime = true;
                  }
                  if (current is GetMovieDetailByIdError ||
                      current is GetMovieDetailByIdLoading ||
                      current is GetMovieDetailByIdLoaded) {
                    return true;
                  }
                  return false;
                },
                builder: (context, state) {
                  if (state is GetMovieDetailByIdError) {
                    return const ErrorIndicator();
                  } else if (state is GetMovieDetailByIdLoading) {
                    return const LoadingIndicator();
                  } else if (state is GetMovieDetailByIdLoaded) {
                    final List<Genere> genere = state.movie.generes;
                    if (genere.isNotEmpty) {
                      runningTime = runningTime + 1;
                      if (runningTime >= 2) {
                        runningTime = 0;
                        for (var element in genere) {
                          numberOfLetters =
                              numberOfLetters + element.name.length;
                        }
                      } else if (firstTime) {
                        firstTime = false;
                        for (var element in genere) {
                          numberOfLetters =
                              numberOfLetters + element.name.length;
                        }
                      }
                    }
                    return SizedBox(
                      width: double.infinity,
                      height: numberOfLetters >= 23 ? 80 : 40,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0.h,
                            left: 20.w,
                            right: 40.w,
                            child: Wrap(
                              runSpacing: 2.w,
                              spacing: 2.w,
                              direction: Axis.horizontal,
                              children: generateCategory(
                                  genere: genere,
                                  context: context,
                                  time: state.movie.runTime),
                            ),
                          ),
                          Positioned(
                            top: 0.h,
                            right: 20.w,
                            child: SizedBox(
                              width: 29.w,
                              height: 35.h,
                              child: Icon(
                                Icons.favorite_border_outlined,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryVariant,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return const LoadingIndicator();
                },
              ),
              StoryLine(
                movie: widget.movie,
              ),
              const ActorsCrews(isActor: true),
              BlocBuilder<MovieBloc, MovieState>(
                buildWhen: (previous, current) {
                  if (current is GetMovieDetailByIdError ||
                      current is GetMovieDetailByIdLoading ||
                      current is GetMovieDetailByIdLoaded) {
                    return true;
                  }
                  return false;
                },
                builder: (context, state) {
                  if (state is GetMovieDetailByIdError) {
                    return const ErrorIndicator();
                  } else if (state is GetMovieDetailByIdLoading) {
                    return SizedBox(
                      height: 280.h,
                      child: const LoadingIndicator(),
                    );
                  } else if (state is GetMovieDetailByIdLoaded) {
                    return AboutFilm(
                      movie: state.movie,
                    );
                  }
                  return const LoadingIndicator();
                },
              ),
              const ActorsCrews(isActor: false),
            ],
          ),
        ),
      ),
    );
  }
}
