import 'package:bilal/repository/auth_repository.dart';
import 'package:bilal/routes/routes_config.dart';
import 'package:go_router/go_router.dart';

class ClearNav {
  static void clearAndNavigate(String path) {
    GoRouter goRouter = AppRoute.getRouter(AuthRepository());
    while (goRouter.canPop() == true) {
      goRouter.pop();
    }
    goRouter.pushReplacement(path);
  }
}
