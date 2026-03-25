import 'package:flutter/material.dart';
import 'package:soccer_life/core/app/router/app_router.dart';
import 'package:soccer_life/core/constants/app_constants.dart';
import 'package:soccer_life/core/shared/theme/app_theme.dart';

class SoccerLifeApp extends StatelessWidget {
  const SoccerLifeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: AppRouter.router,
    );
  }
}
