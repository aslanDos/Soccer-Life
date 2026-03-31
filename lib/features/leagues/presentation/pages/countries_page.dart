import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:soccer_life/core/entities/country/country_entity.dart';
import 'package:soccer_life/core/shared/widgets/app_list_tile.dart';
import 'package:soccer_life/core/shared/widgets/country_tile.dart';
import 'package:soccer_life/features/favorites/presentation/provider/favorite_leagues_provider.dart';
import 'package:soccer_life/features/leagues/domain/entity/league_entity.dart';
import 'package:soccer_life/features/leagues/presentation/provider/countries_provider.dart';

class CountriesPage extends StatefulWidget {
  const CountriesPage({super.key});

  @override
  State<CountriesPage> createState() => _CountriesPageState();
}

class _CountriesPageState extends State<CountriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<CountriesProvider>().fetchCountries();
    });
  }

  List<Object> _buildItems(List<CountryEntity> countries) {
    final sorted = [...countries]..sort((a, b) => a.name.compareTo(b.name));

    final items = <Object>[];
    String? currentLetter;

    for (final country in sorted) {
      final letter = country.name[0].toUpperCase();
      if (letter != currentLetter) {
        currentLetter = letter;
        items.add(_Header(letter));
      }
      items.add(country);
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer2<CountriesProvider, FavoriteLeaguesProvider>(
      builder: (context, provider, favs, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.error != null) {
          return Center(child: Text(provider.error!));
        }

        if (provider.countries.isEmpty) {
          return const Center(child: Text('No countries found'));
        }

        final favorites = favs.favorites;
        final items = _buildItems(provider.countries);
        // favorites section occupies: 1 header + N tiles + 1 divider
        final favOffset = favorites.isEmpty ? 0 : favorites.length + 2;

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: items.length + favOffset,
          itemBuilder: (context, index) {
            // ── Favorites section ──
            if (favorites.isNotEmpty) {
              if (index == 0) return const _LetterHeader(letter: 'Favorites');
              if (index <= favorites.length) {
                return _FavoriteTile(league: favorites[index - 1]);
              }
              if (index == favorites.length + 1) {
                return Divider(
                  height: 1,
                  indent: 60,
                  endIndent: 60,
                  color: theme.colorScheme.secondary,
                );
              }
              index -= favOffset;
            }

            // ── Countries section ──
            final item = items[index];

            if (item is _Header) {
              return _LetterHeader(letter: item.letter);
            }

            final country = item as CountryEntity;
            final isLast =
                index == items.length - 1 || items[index + 1] is _Header;

            return Column(
              children: [
                CountryTile(
                  country: country,
                  onTap: () => context.push(
                    '/leagues/${country.code}?name=${Uri.encodeComponent(country.name)}',
                  ),
                ),
                if (!isLast)
                  Divider(
                    height: 1,
                    indent: 60,
                    endIndent: 60,
                    color: theme.colorScheme.secondary,
                  ),
              ],
            );
          },
        );
      },
    );
  }
}

class _Header {
  final String letter;
  const _Header(this.letter);
}

class _SectionHeader extends StatelessWidget {
  final String label;

  const _SectionHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Text(
        label.toUpperCase(),
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

class _FavoriteTile extends StatelessWidget {
  final LeagueEntity league;

  const _FavoriteTile({required this.league});

  @override
  Widget build(BuildContext context) {
    return AppListTile(
      leading: _FlagLeading(league.countryFlag),
      title: league.countryName,
      subtitle: league.name,
      onTap: () =>
          context.push('/leagues/${league.countryCode}/league', extra: league),
    );
  }
}

class _FlagLeading extends StatelessWidget {
  final String url;

  const _FlagLeading(this.url);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: url.isNotEmpty
          ? SvgPicture.network(
              url,
              width: 36,
              height: 24,
              fit: BoxFit.cover,
              placeholderBuilder: (_) => _placeholder(),
            )
          : _placeholder(),
    );
  }

  Widget _placeholder() {
    return Container(
      width: 36,
      height: 24,
      color: Colors.grey.shade300,
      child: const Icon(Icons.flag, size: 16),
    );
  }
}

class _LetterHeader extends StatelessWidget {
  final String letter;

  const _LetterHeader({required this.letter});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      margin: const EdgeInsets.only(top: 8, bottom: 4),
      decoration: BoxDecoration(color: theme.colorScheme.secondary),
      child: Text(
        letter,
        style: theme.textTheme.titleSmall?.copyWith(
          color: theme.colorScheme.onSecondary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
