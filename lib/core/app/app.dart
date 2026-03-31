import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soccer_life/core/app/router/app_router.dart';
import 'package:soccer_life/core/constants/app_constants.dart';
import 'package:soccer_life/core/di/dependency_injection.dart';
import 'package:soccer_life/core/shared/theme/app_theme.dart';
import 'package:soccer_life/features/favorites/presentation/provider/favorite_leagues_provider.dart';
import 'package:soccer_life/features/players/presentation/provider/players_provider.dart';

class SoccerLifeApp extends StatelessWidget {
  const SoccerLifeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PlayersProvider>(create: (_) => di<PlayersProvider>()),
        ChangeNotifierProvider<FavoriteLeaguesProvider>(create: (_) => di<FavoriteLeaguesProvider>()),
      ],
      child: MaterialApp.router(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
