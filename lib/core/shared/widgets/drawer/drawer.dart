import 'package:flutter/material.dart';
import 'package:soccer_life/core/shared/widgets/drawer/drawer_config.dart';
import 'package:soccer_life/core/shared/widgets/drawer/drawer_item.dart';
import 'package:soccer_life/core/shared/widgets/drawer/drawer_section.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomDrawer(sections: buildDrawerSections(context));
  }
}

class CustomDrawer extends StatelessWidget {
  final List<DrawerSection> sections;

  const CustomDrawer({super.key, required this.sections});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: SafeArea(
        child: Column(
          children: [
            // Header
            _DrawerHeader(),

            // Content
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  for (final section in sections) ...[
                    if (section.title != null)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                        child: Text(
                          section.title!,
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ),

                    ...section.items.map(
                      (item) => _DrawerItemWidget(item: item),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const CircleAvatar(radius: 24),

          const SizedBox(width: 12),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Aslan Dossymzhan'),
              Text('Premium', style: TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}

class _DrawerItemWidget extends StatelessWidget {
  final DrawerItem item;

  const _DrawerItemWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: item.onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(item.icon, size: 20),

            const SizedBox(width: 16),

            Text(item.title),
          ],
        ),
      ),
    );
  }
}
