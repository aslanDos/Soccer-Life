import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soccer_life/core/app/router/app_routes.dart';
import 'package:soccer_life/core/shared/widgets/drawer/drawer_item.dart';
import 'package:soccer_life/core/shared/widgets/drawer/drawer_section.dart';

List<DrawerSection> buildDrawerSections(BuildContext context) {
  return [
    DrawerSection(
      title: 'Navigation',
      items: [
        DrawerItem(
          title: 'Favorites',
          icon: Icons.star,
          onTap: () {
            context.push(AppRoutes.favorites);
          },
        ),
        DrawerItem(title: 'Leagues', icon: Icons.emoji_events, onTap: () {}),
      ],
    ),
    DrawerSection(
      title: 'Settings',
      items: [
        DrawerItem(title: 'Dark Mode', icon: Icons.dark_mode, onTap: () {}),
      ],
    ),
  ];
}
