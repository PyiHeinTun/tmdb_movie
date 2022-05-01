import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/home/popular_actors.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/home/check_movie_time.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/home/get_movie_from_genere.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/home/home_app_bar.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/home/now_playing.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/home/popular_movies.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/home/show_case_movie.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: homeAppBar(
        title: 'home.title'.tr(),
        context: context,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            NowPlaying(),
            PopularMovies(),
            CheckMovieTime(),
            GetMovieFromGenere(),
            ShowCaseMovie(),
            PopularActors(),
          ],
        ),
      ),
    );
  }
}
