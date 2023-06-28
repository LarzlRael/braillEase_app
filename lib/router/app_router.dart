import 'package:go_router/go_router.dart';
import '../pages/pages.dart';

class PageRouteParams {
  final String titlePage;
  final String phase;
  PageRouteParams({
    required this.titlePage,
    required this.phase,
  });
}

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
      builder: (context, state) {
        final pageArgs = state.extra as PageRouteParams;
        return AbcdarioPage(pageArgs: pageArgs);
      },
    ),
    GoRoute(
      path: '/translate',
      builder: (context, state) {
        final pageRouteParams = state.extra as PageRouteParams;
        return TranslatePage(titlePage: pageRouteParams);
      },
    ),
  ],
);
