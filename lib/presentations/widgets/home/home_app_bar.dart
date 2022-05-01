import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

AppBar homeAppBar({required String title, required BuildContext context}) {
  return AppBar(
    elevation: 0,
    backgroundColor: Theme.of(context).colorScheme.primary,
    centerTitle: true,
    leading: Icon(
      EvaIcons.menu2Outline,
      color: Theme.of(context).colorScheme.primaryVariant,
    ),
    title: Text(title),
    actions: <Widget>[
      IconButton(
        onPressed: () {},
        icon: Icon(
          EvaIcons.searchOutline,
          color: Theme.of(context).colorScheme.primaryVariant,
        ),
      )
    ],
  );
}
