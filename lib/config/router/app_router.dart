import 'package:prueba_jun/library.dart';

final appRoute = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(path: "/", builder: (context, state) => const SplashPage()),
    GoRoute(path: "/main", builder: (context, state) => const MainPage()),
  ],
);
