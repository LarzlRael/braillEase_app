part of '../widgets.dart';

CustomTransitionPage<dynamic> fadeInTransition({
  required Widget child,
  duration = const Duration(milliseconds: 400),
}) {
  return CustomTransitionPage(
    transitionDuration: duration,
    reverseTransitionDuration: duration,
    child: child,
    transitionsBuilder: (
      context,
      animation,
      secondaryAnimation,
      child,
    ) =>
        FadeTransition(
      opacity: animation,
      child: child,
    ),
  );
}
