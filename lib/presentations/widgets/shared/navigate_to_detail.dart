import 'package:flutter/material.dart';
import 'package:flutter_tmdb_movie/domain/entity/movie.dart';

class NavigateToDetail extends StatelessWidget {
  final Widget child;
  final Movie movie;
  const NavigateToDetail({Key? key, required this.child, required this.movie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: child,
      onTap: () {
        Navigator.of(context).pushNamed('/detail', arguments: movie);
      },
    );
  }
}
