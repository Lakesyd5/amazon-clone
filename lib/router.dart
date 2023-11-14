import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:go_router/go_router.dart';

class MyAppRouter {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        routes: <RouteBase>[
          // GoRoute(path: 'path')
        ],
        path: '/',
        builder: (context, state) {
          return const AuthScreen();
        },
      )
    ],
  );
}
