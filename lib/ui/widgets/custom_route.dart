import 'package:flutter/material.dart';

class CustomRoute extends PageRouteBuilder {
  final Widget page;
  CustomRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            curve: Curves.easeInOutQuart,
            parent: animation
          )),
          child: child,
        ),
  );
}