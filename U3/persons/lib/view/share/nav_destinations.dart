import 'package:flutter/material.dart';

import '/view/screens/view_all_screen.dart';
import '/view/screens/insert_one_screen.dart';

class NavDestinations {
  static const List<String> titles = ['Insert one', 'View all'];

  static const List<Icon> selectedIcon = [
    Icon(Icons.create),
    Icon(Icons.view_list)
  ];

  static const List<Icon> unselectedIcon = [
    Icon(Icons.create_outlined),
    Icon(Icons.view_list_outlined)
  ];

  static getMobileDestinations() {
    return List.generate(titles.length, (index) {
      return NavigationDestination(
        icon: unselectedIcon[index],
        selectedIcon: selectedIcon[index],
        label: titles[index],
      );
    });
  }

  static getDesktopDestinations() {
    return List.generate(titles.length, (index) {
      return NavigationDrawerDestination(
        icon: unselectedIcon[index],
        selectedIcon: selectedIcon[index],
        label: Text(titles[index]),
      );
    });
  }

  static getTabletDestinations() {
    return List.generate(titles.length, (index) {
      return NavigationRailDestination(
        icon: unselectedIcon[index],
        selectedIcon: selectedIcon[index],
        label: Text(titles[index]),
      );
    });
  }

  static getScreen(int index) {
    switch (index) {
      case 0:
        return const InsertOneScreen();
      case 1:
        return const ViewAllScreen();
      default:
        return const InsertOneScreen();
    }
  }
}
