import 'package:flutter/material.dart';
import '../../../datas/vos/movie_vo.dart';

class NavigateToDetail extends StatelessWidget {
  final Widget child;
  final MovieVO? movie;
  const NavigateToDetail({Key? key, required this.child, required this.movie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: child,
      onTap: () {
        // print(movie?.id ?? '');
        Navigator.of(context).pushNamed('/detail', arguments: movie);
      },
    );
  }
}
