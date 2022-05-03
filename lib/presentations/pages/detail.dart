import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tmdb_movie/blocs/movie_detail_bloc.dart';
import 'package:flutter_tmdb_movie/domain/entity/genere.dart';
import 'package:flutter_tmdb_movie/domain/entity/person.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/detail/about_film.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/detail/actors_crews.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/shared/error_alert.dart';
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
  int numberOfLetters = 0;
  int runningTime = 0;

  @override
  Widget build(BuildContext context) {
    final bloc = MovieDetailBloc(movieId: widget.movie.id.toString());
    return ChangeNotifierProvider(
      create: (context) => bloc,
      child: Scaffold(
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
            child: Stack(
              children: [
                //Alert Dialog
                Selector<MovieDetailBloc, bool?>(
                  selector: (context, bloc) => bloc.errorFlag,
                  builder: (context, state, child) {
                    if (state == true) {
                      errorAlert(context, bloc);
                    }
                    return Container();
                  },
                ),
                //LIST OF DETAIL ITEM
                ListView(
                  padding: const EdgeInsets.all(0),
                  children: [
                    //Genere List
                    Selector<MovieDetailBloc, Movie?>(
                      selector: (context, bloc) => bloc.movieDetail,
                      builder: (context, state, child) {
                        if (state != null) {
                          final List<Genere> genere = state.generes;
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
                                      time: state.runTime,
                                    ),
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

                    //StoryLine
                    StoryLine(
                      movie: widget.movie,
                    ),

                    //Actors
                    Selector<MovieDetailBloc, List<Person>?>(
                      selector: (context, bloc) => bloc.actors,
                      builder: (context, state, child) {
                        if (state != null) {
                          return ActorsCrews(
                            person: state,
                            isActor: true,
                          );
                        }
                        return Container(
                          color: Theme.of(context).colorScheme.background,
                          height: 280.h,
                          child: const LoadingIndicator(),
                        );
                      },
                    ),

                    //About Film
                    Selector<MovieDetailBloc, Movie?>(
                      selector: (context, bloc) => bloc.movieDetail,
                      builder: (context, state, child) {
                        if (state != null) {
                          return AboutFilm(
                            movie: state,
                          );
                        }
                        return SizedBox(
                          height: 280.h,
                          child: const LoadingIndicator(),
                        );
                      },
                    ),

                    //Creators
                    Selector<MovieDetailBloc, List<Person>?>(
                      selector: (context, bloc) => bloc.actors,
                      builder: (context, state, child) {
                        if (state != null) {
                          return ActorsCrews(
                            person: state,
                            isActor: false,
                          );
                        }
                        return Container(
                          color: Theme.of(context).colorScheme.background,
                          height: 280.h,
                          child: const LoadingIndicator(),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
