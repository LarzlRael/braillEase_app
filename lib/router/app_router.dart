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
  ],
);
