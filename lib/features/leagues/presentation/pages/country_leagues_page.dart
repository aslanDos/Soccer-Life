import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:soccer_life/core/di/dependency_injection.dart';
import 'package:soccer_life/features/leagues/presentation/widgets/list_tiles/league_tile.dart';
import 'package:soccer_life/features/leagues/presentation/provider/leagues_provider.dart';

class CountryLeaguesPage extends StatelessWidget {
  final String countryCode;
  final String countryName;

  const CountryLeaguesPage({
    super.key,
    required this.countryCode,
    required this.countryName,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => di<LeaguesProvider>()..fetchLeagues(countryCode),
      child: Scaffold(
        appBar: AppBar(
          title: Text(countryName),
          leading: IconButton(
            icon: const Icon(Ionicons.arrow_back),
            onPressed: () => context.pop(),
          ),
        ),
        body: Consumer<LeaguesProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.error != null) {
              return Center(child: Text(provider.error!));
            }

            if (provider.leagues.isEmpty) {
              return const Center(child: Text('No leagues found'));
            }

            return ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: provider.leagues.length,
              separatorBuilder: (_, _) => Divider(
                height: 1,
                indent: 60,
                endIndent: 60,
                color: Theme.of(context).colorScheme.secondary,
              ),
              itemBuilder: (context, index) {
                final league = provider.leagues[index];

                return LeagueTile(
                  league: league,
                  onTap: () => context.push(
                    '/leagues/${league.countryCode}/league',
                    extra: league,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
