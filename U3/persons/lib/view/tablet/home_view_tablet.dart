import 'package:flutter/material.dart';

import '../share/nav_destinations.dart';

class HomeViewTablet extends StatefulWidget {
  const HomeViewTablet({super.key});

  @override
  State<HomeViewTablet> createState() => _HomeViewTabletState();
}

class _HomeViewTabletState extends State<HomeViewTablet> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tablet view'),
      ),
      body: Row(
        children: [
          _widgetNavRail(),
          Expanded(child: _drawBody()),
        ],
      ),
    );
  }

  Widget _widgetNavRail() {
    return NavigationRail(
      labelType: NavigationRailLabelType.all,
      selectedIndex: _selectedIndex,
      onDestinationSelected: _changeDestination,
      destinations: NavDestinations.getTabletDestinations(),
    );
  }

  _changeDestination(int index) => setState(() => _selectedIndex = index);

  Widget _drawBody() {
    return NavDestinations.getScreen(_selectedIndex);
  }
}
