import 'package:flutter/material.dart';

import '/view/share/nav_destinations.dart';

class HomeViewDesktop extends StatefulWidget {
  const HomeViewDesktop({super.key});

  @override
  State<HomeViewDesktop> createState() => _HomeViewDesktopState();
}

class _HomeViewDesktopState extends State<HomeViewDesktop> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Desktop view'),
      ),
      body: Row(
        children: [
          _drawNavDrawer(),
          Expanded(child: _drawBody()),
        ],
      ),
    );
  }

  _drawNavDrawer() {
    return NavigationDrawer(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shadowColor: Colors.transparent,
      selectedIndex: _selectedIndex,
      onDestinationSelected: _changeDestination,
      children: NavDestinations.getDesktopDestinations(),
    );
  }

  _changeDestination(int index) => setState(() => _selectedIndex = index);

  Widget _drawBody() {
    return NavDestinations.getScreen(_selectedIndex);
  }
}
