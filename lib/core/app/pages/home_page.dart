import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:soccer_life/core/shared/widgets/appbar_widget.dart';
import 'package:soccer_life/core/shared/widgets/drawer/drawer.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const AppDrawer(),
      appBar: CustomAppBar(
        leading: Icon(Ionicons.menu),
        onLeadingTap: () {
          scaffoldKey.currentState?.openDrawer();
        },
        trailing: Icon(Ionicons.notifications),
      ),
      body: Container(child: Center(child: Text('Home'))),
    );
  }
}
