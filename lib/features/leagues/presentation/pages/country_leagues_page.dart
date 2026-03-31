import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:soccer_life/core/di/dependency_injection.dart';
import 'package:soccer_life/core/shared/widgets/app_list_tile.dart';
import 'package:soccer_life/features/leagues/domain/entity/league_entity.dart';
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
                return _LeagueTile(league: provider.leagues[index]);
              },
            );
          },
        ),
      ),
    );
  }
}

class _LeagueTile extends StatelessWidget {
  final LeagueEntity league;

  const _LeagueTile({required this.league});

  @override
  Widget build(BuildContext context) {
    return AppListTile(
      leading: _LeagueLogo(league.logo),
      title: league.name,
      subtitle: 'Season ${league.season}',
      onTap: () =>
          context.push('/leagues/${league.countryCode}/league', extra: league),
    );
  }
}

class _LeagueLogo extends StatelessWidget {
  final String url;

  const _LeagueLogo(this.url);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: url.isNotEmpty
          ? Image.network(
              url,
              width: 36,
              height: 36,
              fit: BoxFit.contain,
              errorBuilder: (_, _, _) => _placeholder(),
            )
          : _placeholder(),
    );
  }

  Widget _placeholder() {
    return Container(
      width: 36,
      height: 36,
      color: Colors.grey.shade300,
      child: const Icon(Icons.sports_soccer, size: 20),
    );
  }
}
