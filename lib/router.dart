import 'package:amazon_clone/features/product_details/screens/product_detail_screen.dart';
import 'package:amazon_clone/features/search/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/features/account/screens/account_screen.dart';
import 'package:amazon_clone/features/admin/screens/addProducts_screen.dart';
import 'package:amazon_clone/features/admin/screens/admin_screen.dart';
import 'package:amazon_clone/features/home/screens/category_deals_screen.dart';

import 'package:amazon_clone/provider/user_provider.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>(
  (ref) {
    final user = ref.watch(userProvider);

    return GoRouter(
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
            ),
            GoRoute(
              path: 'categoryScreen',
              builder: (context, state) {
                return const CategoryDealsScreen();
              },
            ),
            GoRoute(
              path: 'searchScreen',
              builder: (context, state) {
                return const SearchScreen();
              },
            ),
            GoRoute(
              path: 'productDetails',
              builder: (context, state) {
                return const ProductDetailScreen();
              },
            )
          ],
          path: '/',
          builder: (context, state) {
            return user.token.isNotEmpty
                ? user.type == 'user'
                    ? const BottomBar()
                    : const AdminScreen()
                : const AuthScreen();
          },
        )
      ],
    );
  },
);
