import 'package:go_router/go_router.dart';
import '../pages/pages.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  /* refreshListenable: goRouterNotifier, */
  routes: [
    ///* Primera pantalla
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/abcdario',
      builder: (context, state) => Abcdario(),
    ),
    GoRoute(
      path: '/translate',
      builder: (context, state) {
        final titlePage = state.extra as String;
        return TranslatePage(titlePage: titlePage);
      },
    ),
  ],
);
