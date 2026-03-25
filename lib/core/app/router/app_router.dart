import 'package:go_router/go_router.dart';
import 'package:soccer_life/core/app/pages/home_page.dart';
import 'package:soccer_life/core/app/pages/schedule_page.dart';
import 'package:soccer_life/core/app/router/app_routes.dart';
import 'package:soccer_life/core/app/shell/main_shell.dart';
import 'package:soccer_life/features/splash/presentation/pages/splash_page.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: SplashPage()),
      ),

      StatefulShellRoute.indexedStack(
        pageBuilder: (context, state, navigationShell) {
          return NoTransitionPage(
            child: MainShell(navigationShell: navigationShell),
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: HomePage()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.schedule,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: SchedulePage()),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
