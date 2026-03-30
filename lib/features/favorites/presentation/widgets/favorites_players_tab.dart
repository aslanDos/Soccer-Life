import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soccer_life/features/players/presentation/provider/players_provider.dart';
import 'package:soccer_life/features/players/presentation/widgets/player_list_tile.dart';

class FavoritesPlayersTab extends StatefulWidget {
  const FavoritesPlayersTab({super.key});

  @override
  State<FavoritesPlayersTab> createState() => _FavoritesPlayersTabState();
}

class _FavoritesPlayersTabState extends State<FavoritesPlayersTab> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<PlayersProvider>().fetchPlayers(33);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PlayersProvider>();

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.error != null) {
      return Center(child: Text(provider.error!));
    }

    return ListView.builder(
      itemCount: provider.players.length,
      itemBuilder: (context, index) {
        final player = provider.players[index];

        return PlayerListTile(
          name: player.name,
          team: player.nationality!,
          position: player.position!,
          imageUrl: player.photoUrl!,
        );
      },
    );
  }
}
