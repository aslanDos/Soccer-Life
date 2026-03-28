import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:soccer_life/core/shared/widgets/custom_appbar_widget.dart';
import 'package:soccer_life/features/favorites/presentation/widgets/favorites_tab.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Favorites"),
          leading: IconButton(
            icon: Icon(Ionicons.arrow_back),
            onPressed: () {
              context.pop();
            },
          ),
          bottom: FavoritesTab(),
        ),
        body: TabBarView(
          children: FavoritesTabType.values
              .map((tab) => tab.buildView())
              .toList(),
        ),
      ),
    );
  }
}
