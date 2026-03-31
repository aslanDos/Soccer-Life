import 'package:go_router/go_router.dart';
import 'package:soccer_life/core/app/pages/home_page.dart';
import 'package:soccer_life/core/app/pages/schedule_page.dart';
import 'package:soccer_life/core/app/router/app_routes.dart';
import 'package:soccer_life/core/app/shell/main_shell.dart';
import 'package:soccer_life/features/favorites/presentation/pages/favorites_page.dart';
import 'package:soccer_life/features/leagues/domain/entity/league_entity.dart';
import 'package:soccer_life/features/leagues/presentation/pages/country_leagues_page.dart';
import 'package:soccer_life/features/leagues/presentation/pages/league_page.dart';
import 'package:soccer_life/features/leagues/presentation/pages/leagues_page.dart';
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
                    NoTransitionPage(child: HomePage()),
              ),
              GoRoute(
                path: AppRoutes.favorites,
                builder: (context, state) => FavoritesPage(),
              ),
              GoRoute(
                path: AppRoutes.leagues,
                builder: (context, state) => const LeaguesPage(),
                routes: [
                  GoRoute(
                    path: ':code',
                    builder: (context, state) => CountryLeaguesPage(
                      countryCode: state.pathParameters['code']!,
                      countryName: state.uri.queryParameters['name'] ?? '',
                    ),
                    routes: [
                      GoRoute(
                        path: AppRoutes.league,
                        builder: (context, state) =>
                            LeaguePage(league: state.extra as LeagueEntity),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.schedule,
                pageBuilder: (context, state) =>
                    NoTransitionPage(child: SchedulePage()),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
