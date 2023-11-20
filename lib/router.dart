import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/features/account/screens/account_screen.dart';
import 'package:amazon_clone/features/admin/screens/addProducts_screen.dart';
import 'package:amazon_clone/features/admin/screens/admin_screen.dart';
import 'package:flutter/material.dart';

import 'package:amazon_clone/provider/user_provider.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MyAppRouter {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        routes: <RouteBase>[
          GoRoute(
            path: 'home',
            builder: (BuildContext context, GoRouterState state) {
              return const HomeScreen();
            },
          ),
          GoRoute(
            path: 'dashboard',
            builder: (context, state) {
              return const BottomBar();
            },
          ),
          GoRoute(
            path: 'account',
            builder: (context, state) {
              return const AccountScreen();
            },
          ),
          GoRoute(
            path: 'admin',
            builder: (context, state) {
              return const AdminScreen();
            },
          ),
          GoRoute(
            path: 'addProduct',
            builder: (context, state) {
              return const AddProductScreen();
            },
          )
        ],
        path: '/',
        builder: (context, state) {
          return Provider.of<UserProvider>(context).user.token.isNotEmpty
              ? Provider.of<UserProvider>(context).user.type == 'user'
                  ? const BottomBar()
                  : const AdminScreen()
              : const AuthScreen();
        },
      )
    ],
  );
}
