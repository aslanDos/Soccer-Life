import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soccer_life/core/entities/country/country_entity.dart';
import 'package:soccer_life/core/shared/widgets/app_list_tile.dart';

class CountryTile extends StatelessWidget {
  final CountryEntity country;
  final VoidCallback? onTap;

  const CountryTile({super.key, required this.country, this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppListTile(
      leading: _Flag(country.flagUrl),
      title: country.name,
      subtitle: country.code.isNotEmpty ? country.code : null,
      onTap: onTap,
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
