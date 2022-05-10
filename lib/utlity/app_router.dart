import 'package:flutter/material.dart';
import '../datas/vos/movie_vo.dart';
import '../presentations/pages/detail.dart';
import '../presentations/pages/home.dart';
import '../presentations/pages/no_page.dart';
import 'route_animation.dart';

class AppRouter {
  static Route<dynamic> genereateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return RouteAnimation(child: const HomePage());
      case '/detail':
        return RouteAnimation(
          child: DetailPage(
            movie: settings.arguments as MovieVO,
          ),
        );
      default:
        return RouteAnimation(child: const NoPage());
    }
  }
}
