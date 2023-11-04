import 'package:bilal/presentation/screens/admin/manage_parents.dart';
import 'package:bilal/presentation/screens/admin/manage_sections.dart';
import 'package:bilal/presentation/screens/admin/manage_students.dart';
import 'package:bilal/presentation/screens/common/homepage.dart';
import 'package:bilal/presentation/screens/common/login_page.dart';
import 'package:bilal/repository/auth_repository.dart';
import 'package:bilal/routes/route_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoute {
  static GoRouter getRouter(AuthRepository authRepository) {
    User? user = authRepository.user;
    GoRouter route = GoRouter(
      routes: [
        GoRoute(
            path: "/",
            pageBuilder: (context, state) =>
                MaterialPage(child: user == null ? const LogIn() : HomePage())),
        GoRoute(
          path: "/home",
          name: RoutesConst.homePage,
          pageBuilder: (context, state) => MaterialPage(child: HomePage()),
        ),
        GoRoute(
          path: "/${RoutesConst.manageStudents}",
          name: RoutesConst.manageStudents,
          pageBuilder: (context, state) =>
              const MaterialPage(child: ManageStudent()),
        ),
        GoRoute(
          path: "/${RoutesConst.manageParents}",
          name: RoutesConst.manageParents,
          pageBuilder: (context, state) =>
              const MaterialPage(child: ManageParents()),
        ),
        GoRoute(
            path: "/${RoutesConst.manageSections}",
            name: RoutesConst.manageSections,
            pageBuilder: ((context, state) =>
                const MaterialPage(child: ManageSections())))
      ],
    );
    return route;
  }
}
