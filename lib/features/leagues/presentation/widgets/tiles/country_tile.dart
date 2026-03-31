import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:soccer_life/core/entities/country/country_entity.dart';
import 'package:soccer_life/core/shared/widgets/app_list_tile.dart';

class CountryTile extends StatelessWidget {
  final CountryEntity country;
  final VoidCallback? onTap;

  const CountryTile({super.key, required this.country, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppListTile(
      onTap: onTap,
      child: Row(
        children: [
          _Flag(country.flagUrl),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(country.name, style: theme.textTheme.headlineSmall),
                Text(country.code, style: theme.textTheme.bodySmall),
              ],
            ),
          ),
          Icon(Ionicons.chevron_forward, color: theme.colorScheme.onSecondary),
        ],
      ),
    );
  }
}

class _Flag extends StatelessWidget {
  final String? url;

  const _Flag(this.url);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: url != null && url!.isNotEmpty
          ? SvgPicture.network(
              url!,
              width: 25,
              height: 20,
              fit: BoxFit.cover,
              placeholderBuilder: (_) => _placeholder(),
            )
          : _placeholder(),
    );
  }

  Widget _placeholder() {
    return Container(
      width: 25,
      height: 20,
      color: Colors.grey.shade300,
      child: const Icon(Icons.flag, size: 16),
    );
  }
}
