import 'package:flutter/material.dart';
import 'package:soccer_life/core/app/router/app_router.dart';

class SoccerLifeApp extends StatelessWidget {
  const SoccerLifeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}
