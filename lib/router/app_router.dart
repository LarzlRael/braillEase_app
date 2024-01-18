import 'package:go_router/go_router.dart';
import '../pages/pages.dart';
import '../widgets/widgets.dart';

/* class PageRouteParams {
  final String titlePage;
  final String phase;
  PageRouteParams({
    required this.titlePage,
    required this.phase,
  });
}
 */
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
      path: '/splash_screen',
      builder: (context, state) => SplashScreenPage(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/welcome_page',
      builder: (context, state) => WelcomePage(),
    ),
    GoRoute(
      path: '/abcedario_page/:titlePage/:phrase',
      pageBuilder: (context, state) {
        /* final pageArgs = state.extra as PageRouteParams; */
        final titlePage = state.params['titlePage'] as String;
        final phrase = state.params['phrase'] as String;
        return fadeInTransition(
          duration: Duration(milliseconds: 250),
          child: AbecedarioPage(
            titlePage: titlePage,
            phase: phrase,
          ),
        );
      },
    ),
    GoRoute(
      path: '/translate_page/:titlePage',
      pageBuilder: (context, state) {
        final pageRouteParams = state.params['titlePage'] as String;
        return fadeInTransition(
          child: TranslatePage(
            titlePage: pageRouteParams,
          ),
        );
      },
      routes: [
        GoRoute(
          path: ':phrase',
          pageBuilder: (context, state) {
            final phrase = state.params['phrase'] as String;
            final titlePage = state.params['titlePage'] as String;

            return fadeInTransition(
              child: TranslatePage(
                titlePage: titlePage,
                phraseArg: phrase,
              ),
              duration: const Duration(milliseconds: 500),
            );
          },
        ),
      ],
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
      path: '/phrase_maker_page/:titlePage',
      routes: [
        GoRoute(
          path: ':phrase',
          pageBuilder: (context, state) {
            return fadeInTransition(
              duration: const Duration(milliseconds: 250),
              child: PhraseMakerPage(
                phraseArg: state.params['phrase'] as String,
              ),
            );
          },
        ),
      ],
      pageBuilder: (context, state) {
        return fadeInTransition(
          child: PhraseMakerPage(
            phraseArg: null,
          ),
          duration: const Duration(milliseconds: 250),
        );
      },
    ),
  ],
);
