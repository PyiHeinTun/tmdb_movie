import 'package:flutter/material.dart';
import 'package:flutter_tmdb_movie/domain/entity/movie.dart';
import 'package:flutter_tmdb_movie/presentations/pages/detail.dart';
import 'package:flutter_tmdb_movie/presentations/pages/home.dart';
import 'package:flutter_tmdb_movie/presentations/pages/no_page.dart';
import 'package:flutter_tmdb_movie/utlity/route_animation.dart';

class AppRouter {
  static Route<dynamic> genereateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return RouteAnimation(child: const HomePage());
      case '/detail':
        return RouteAnimation(
          child: DetailPage(
            movie: settings.arguments as Movie,
          ),
        );
      default:
        return RouteAnimation(child: const NoPage());
    }
  }
}
