import 'package:flutter/material.dart';

class NoGLow extends StatelessWidget {
  final Widget child;
  const NoGLow({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowIndicator();
        return true;
      },
      child: child,
    );
  }
}
