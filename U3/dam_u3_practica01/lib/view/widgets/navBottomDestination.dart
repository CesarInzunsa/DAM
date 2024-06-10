import 'package:flutter/material.dart';

class NavBottomDestination {
  static List<NavigationDestination> getNavBottomDestination(
      List<Icon> icons, List<Icon> filled_icons) {
    return [
      NavigationDestination(
        icon: icons[0],
        selectedIcon: filled_icons[0],
        label: 'Materia',
      ),
      NavigationDestination(
        icon: icons[1],
        selectedIcon: filled_icons[1],
        label: 'Horario',
      ),
      NavigationDestination(
        icon: icons[2],
        selectedIcon: filled_icons[2],
        label: 'Profesor',
      ),
      NavigationDestination(
        icon: icons[3],
        selectedIcon: filled_icons[3],
        label: 'Asistencia',
      ),
    ];
  }
}
