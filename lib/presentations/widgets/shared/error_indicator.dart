import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tmdb_movie/res/app_theme.dart';

class ErrorIndicator extends StatelessWidget {
  const ErrorIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "something_wrong".tr(),
        style: MyTextStyle.titleName(context),
      ),
    );
  }
}
