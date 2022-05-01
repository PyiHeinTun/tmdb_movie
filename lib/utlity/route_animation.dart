import 'package:flutter/cupertino.dart';

class RouteAnimation extends PageRouteBuilder {
  final Widget child;
  RouteAnimation({required this.child})
      : super(
          pageBuilder: (context, animation, secondAnimation) {
            return child;
          },
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position:
          Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))
              .animate(animation),
      child: child,
    );
  }
}
