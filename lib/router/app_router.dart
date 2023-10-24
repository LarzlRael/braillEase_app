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
  initialLocation: '/splash_screen',
  /* refreshListenable: goRouterNotifier, */
  routes: [
    ///* Primera pantalla
    GoRoute(
      path: '/splash_screen',
      builder: (context, state) => SplashScreenPage(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/welcome',
      builder: (context, state) => WelcomePage(),
    ),
    GoRoute(
      path: '/abecedario',
      pageBuilder: (context, state) {
        final pageArgs = state.extra as PageRouteParams;
        return fadeInTransition(
          duration: Duration(milliseconds: 250),
          child: AbecedarioPage(
            pageArgs: pageArgs,
          ),
        );
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
      pageBuilder: (context, state) => fadeInTransition(child: SettingsPage()),
    ),
    GoRoute(
      path: '/details/:letter',
      pageBuilder: (context, state) {
        final letter = state.params['letter'] as String;
        return fadeInTransition(
          child: DetailLetterPage(
            letter: letter,
          ),
          duration: const Duration(milliseconds: 500),
        );
      },
    ),
    GoRoute(
      path: '/print_pdf_page',
      pageBuilder: (context, state) {
        return fadeInTransition(
          child: PrintPdfPage(),
          duration: const Duration(milliseconds: 500),
        );
      },
    ),
    GoRoute(
      path: '/phrase_maker/:phrase',
      pageBuilder: (context, state) {
        return fadeInTransition(
          child: PhraseMakerPage(
            phrase: state.params['phrase'] as String,
          ),
          duration: const Duration(milliseconds: 250),
        );
      },
    ),
    GoRoute(
      path: '/phrase_maker',
      pageBuilder: (context, state) {
        return fadeInTransition(
          child: PhraseMakerPage(),
          duration: const Duration(milliseconds: 250),
        );
      },
    ),
  ],
);
