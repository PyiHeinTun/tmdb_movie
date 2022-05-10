import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../datas/vos/movie_vo.dart';
import 'detail_app_bar.dart';

class MySliverAppBar extends StatelessWidget {
  final MovieVO? movie;
  const MySliverAppBar({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          margin: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF292527).withOpacity(0.8),
          ),
          child: Icon(
            EvaIcons.arrowIosBackOutline,
            color: Theme.of(context).colorScheme.primaryVariant,
          ),
        ),
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {},
          icon: Icon(
            EvaIcons.searchOutline,
            color: Theme.of(context).colorScheme.primaryVariant,
          ),
        )
      ],
      pinned: true,
      snap: false,
      floating: false,
      expandedHeight: 300.h,
      flexibleSpace: MyAppSpace(
        movie: movie,
      ),
    );
  }
}
