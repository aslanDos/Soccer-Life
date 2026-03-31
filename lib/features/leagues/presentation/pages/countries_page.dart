import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:soccer_life/core/entities/country/country_entity.dart';
import 'package:soccer_life/features/leagues/presentation/widgets/list_tiles/country_tile.dart';
import 'package:soccer_life/features/leagues/presentation/widgets/list_tiles/league_tile.dart';
import 'package:soccer_life/features/favorites/presentation/provider/favorite_leagues_provider.dart';
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
        // favorites section occupies: 1 header + N tiles
        final favOffset = favorites.isEmpty ? 0 : favorites.length + 1;

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: items.length + favOffset,
          itemBuilder: (context, index) {
            // ── Favorites section ──
            if (favorites.isNotEmpty) {
              if (index == 0) {
                return const _SectionHeader(
                  label: 'Favorites',
                  isFavorites: true,
                );
              }
              if (index <= favorites.length) {
                return LeagueTile(
                  league: favorites[index - 1],
                  onTap: () => context.push(
                    '/leagues/${favorites[index - 1].countryCode}/league',
                    extra: favorites[index - 1],
                  ),
                  includeCountryName: true,
                );
                // return _FavoriteTile(league: favorites[index - 1]);
              }
              index -= favOffset;
            }

            // ── Countries section ──
            final item = items[index];

            if (item is _Header) {
              return _SectionHeader(label: item.letter);
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
  final bool isFavorites;

  const _SectionHeader({required this.label, this.isFavorites = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const favoritesColor = Color(0xFFF5A623);
    final bgColor = isFavorites ? favoritesColor : theme.colorScheme.secondary;
    final textColor = isFavorites
        ? theme.colorScheme.onPrimary
        : theme.colorScheme.onSecondary;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      margin: const EdgeInsets.only(top: 8, bottom: 4),
      decoration: BoxDecoration(color: bgColor),
      child: Text(
        label,
        style: theme.textTheme.titleSmall?.copyWith(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
