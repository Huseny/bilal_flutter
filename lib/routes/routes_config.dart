import 'package:bilal/presentation/screens/common/homepage.dart';
import 'package:bilal/presentation/screens/common/login_page.dart';
import 'package:bilal/routes/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoute {
  static GoRouter getRouter(bool isLoggedIn) {
    GoRouter route = GoRouter(routes: [
      GoRoute(
          path: "/",
          pageBuilder: (context, state) => const MaterialPage(child: LogIn())),
      GoRoute(
        path: "/home",
        name: RoutesConst.homePage,
        pageBuilder: (context, state) => MaterialPage(child: HomePage()),
      )
    ]);
    return route;
  }
}
