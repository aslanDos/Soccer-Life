import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:soccer_life/core/di/dependency_injection.dart';
import 'package:soccer_life/features/leagues/presentation/pages/countries_page.dart';
import 'package:soccer_life/features/leagues/presentation/provider/countries_provider.dart';

class LeaguesPage extends StatelessWidget {
  const LeaguesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => di<CountriesProvider>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Leagues'),
          leading: context.canPop()
              ? IconButton(
                  icon: const Icon(Ionicons.arrow_back),
                  onPressed: () => context.pop(),
                )
              : null,
        ),
        body: const CountriesPage(),
      ),
    );
  }
}
