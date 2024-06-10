import 'package:flutter/material.dart';

import '../share/nav_destinations.dart';

class HomeViewMobile extends StatefulWidget {
  const HomeViewMobile({super.key});

  @override
  State<HomeViewMobile> createState() => _HomeViewMobileState();
}

class _HomeViewMobileState extends State<HomeViewMobile> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile view'),
      ),
      body: _drawBody(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _changeDestination,
        destinations: NavDestinations.getMobileDestinations(),
      ),
    );
  }

  _changeDestination(int index) => setState(() => _selectedIndex = index);

  Widget _drawBody() {
    return NavDestinations.getScreen(_selectedIndex);
  }
}
