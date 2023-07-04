part of '../widgets.dart';

class FadeInOpacity extends StatelessWidget {
  final Widget child;

  const FadeInOpacity({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.easeIn,
      duration: Duration(milliseconds: 750),
      child: child,
      builder: (BuildContext context, double value, Widget? child) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
    );
  }
}
