import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:soccer_life/core/entities/country/country_entity.dart';
import 'package:soccer_life/core/shared/widgets/country_tile.dart';
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

  /// Builds a flat list of items: alternating [_Header] and [CountryEntity],
  /// grouped by the first letter of the country name.
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

    return Consumer<CountriesProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.error != null) {
          return Center(child: Text(provider.error!));
        }

        if (provider.countries.isEmpty) {
          return const Center(child: Text('No countries found'));
        }

        final items = _buildItems(provider.countries);

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: items.length,
          itemBuilder: (context, index) {
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
