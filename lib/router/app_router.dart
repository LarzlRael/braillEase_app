import 'package:go_router/go_router.dart';
import '../pages/pages.dart';
import '../widgets/widgets.dart';

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
      pageBuilder: (context, state) {
        final pageArgs = state.extra as PageRouteParams;
        /* return AbcdarioPage(pageArgs: pageArgs); */
        return fadeInTransition(child: AbcdarioPage(pageArgs: pageArgs));
      },
    ),
    GoRoute(
      path: '/translate',
      pageBuilder: (context, state) {
        final pageRouteParams = state.extra as PageRouteParams;
        return fadeInTransition(
            child: TranslatePage(titlePage: pageRouteParams));
      },
    ),
    GoRoute(
      path: '/settings',
      pageBuilder: (context, state) {
        return fadeInTransition(child: SettingsPage());
      },
    ),
  ],
);
