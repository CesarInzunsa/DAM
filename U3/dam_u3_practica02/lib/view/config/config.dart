import 'package:flutter/material.dart';

class Config {
  static const List<String> _mainTitles = ['Hoy', 'Materias', 'Tareas'];
  static const List<Icon> _mainNavSelectedIcons = [
    Icon(Icons.today),
    Icon(Icons.folder),
    Icon(Icons.home_work)
  ];
  static const List<Icon> _mainNavUnselectedIcons = [
    Icon(Icons.today_outlined),
    Icon(Icons.folder_outlined),
    Icon(Icons.home_work_outlined)
  ];

  // static const List<String> _drawerTitles = [
  //   'Consultar materias',
  //   'Crear materia'
  // ];
  // static const List<Icon> _drawerSelectedIcons = [
  //   Icon(Icons.manage_search),
  //   Icon(Icons.create)
  // ];
  // static const List<Icon> _drawerUnselectedIcons = [
  //   Icon(Icons.manage_search_outlined),
  //   Icon(Icons.create_outlined)
  // ];

  static const TextStyle appBarTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
  );

  // static FloatingActionButton getFloatingActionButton(
  //     int index, onFloatingActionButtonPressed) {
  //   return FloatingActionButton(
  //     onPressed: onFloatingActionButtonPressed,
  //     child: index == 0 || index == 2
  //         ? _secondaryAppBarLeading[0]
  //         : _secondaryAppBarLeading[1],
  //   );
  // }

  static AppBar getAppBar(int selectedIndex) {
    return AppBar(
      surfaceTintColor: Colors.orange,
      leading: _mainNavSelectedIcons[selectedIndex],
      title: Text(
        _mainTitles[selectedIndex],
        style: appBarTextStyle,
      ),
    );
  }

  // static NavigationDrawer getNavigationDrawer(
  //   int selectedIndex,
  //   void Function(int) onDestinationSelected,
  // ) {
  //   return NavigationDrawer(
  //     backgroundColor: Colors.white,
  //     surfaceTintColor: Colors.white,
  //     selectedIndex: selectedIndex,
  //     onDestinationSelected: onDestinationSelected,
  //     children: _getNavigationDrawerDestination(),
  //   );
  // }
  //
  // static List<NavigationDrawerDestination> _getNavigationDrawerDestination() {
  //   return List.generate(_drawerTitles.length, (index) {
  //     return NavigationDrawerDestination(
  //       icon: _drawerUnselectedIcons[index],
  //       selectedIcon: _drawerSelectedIcons[index],
  //       label: Text(_drawerTitles[index]),
  //     );
  //   });
  // }

  static NavigationBar getNavigationBar(
    int selectedIndex,
    void Function(int) onDestinationSelected,
  ) {
    return NavigationBar(
      backgroundColor: Colors.orange[50],
      surfaceTintColor: Colors.orange[50],
      indicatorColor: Colors.orange[200],
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      destinations: _getNavigationDestinations(),
    );
  }

  static List<NavigationDestination> _getNavigationDestinations() {
    return List.generate(_mainTitles.length, (index) {
      return NavigationDestination(
        label: _mainTitles[index],
        selectedIcon: _mainNavSelectedIcons[index],
        icon: _mainNavUnselectedIcons[index],
      );
    });
  }

  static List<String> getSemesters() {
    List<String> semesters = [];
    for (int i = 2019; i < 2030; i++) {
      semesters.add('ENE-JUN/$i');
      semesters.add('VERANO/$i');
      semesters.add('AGO-DIC/$i');
    }
    return semesters;
  }

  static Widget drawTextField(
      String labelText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.black),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }

  static Widget drawButton(
      String text, void Function() onPressed, buttonStyle) {
    return ElevatedButton(
      style: buttonStyle,
      onPressed: onPressed,
      child: Text(text),
    );
  }

  static Widget drawDatePicker(
      TextEditingController controller, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13.0),
      child: TextField(
        controller: controller,
        readOnly: true,
        decoration: const InputDecoration(
          hintText: 'Fecha de entrega de la tarea',
          filled: true,
          prefixIcon: Icon(Icons.calendar_today),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(),
        ),
        onTap: () {
          showDatePicker(
            builder: (context, child){
              return Theme(
                data: ThemeData.light().copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: Colors.orange,
                    onPrimary: Colors.white,
                    onSurface: Colors.black,
                  ),
                ),
                child: child!,
              );
            },
            context: context,
            initialDate: controller.text.isEmpty
                ? DateTime.now()
                : DateTime.utc(
                    int.parse(controller.text.substring(6, 10)),
                    int.parse(controller.text.substring(3, 5)),
                    int.parse(controller.text.substring(0, 2)),
                  ),
            firstDate: DateTime(2019),
            lastDate: DateTime(2030),
          ).then((value) {
            if (value != null) {
              String day = value.day.toString().padLeft(2, '0');
              String month = value.month.toString().padLeft(2, '0');
              String year = value.year.toString();
              controller.text = '$day/$month/$year';
            }
          });
        },
      ),
    );
  }

  static void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(message),
      ),
    );
  }
}
