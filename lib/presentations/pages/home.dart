import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../blocs/home_bloc.dart';
import '../widgets/shared/error_alert.dart';
import '../widgets/home/popular_actors.dart';
import '../widgets/home/check_movie_time.dart';
import '../widgets/home/get_movie_from_genere.dart';
import '../widgets/home/home_app_bar.dart';
import '../widgets/home/now_playing.dart';
import '../widgets/home/popular_movies.dart';
import '../widgets/home/show_case_movie.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final HomeBloc bloc = HomeBloc();
    return ChangeNotifierProvider(
      create: (context) => bloc,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: homeAppBar(
          title: 'home.title'.tr(),
          context: context,
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              //Alert Dialog
              Selector<HomeBloc, bool?>(
                selector: (context, bloc) => bloc.errorFlag,
                builder: (context, state, child) {
                  if (state == true) {
                    errorAlert(context, bloc);
                  }
                  return Container();
                },
              ),
              //MAIN UI
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  //NOW PLAYING
                  NowPlaying(),
                  //POPULAR MOVIES
                  PopularMovies(),
                  //CHECK MOVIE TIME
                  CheckMovieTime(),
                  //GET MOVIE FROM GENERE
                  GetMovieFromGenere(),
                  //SHOWCASE MOVIE
                  ShowCaseMovie(),
                  //POPULAR ACTORS
                  PopularActors(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
