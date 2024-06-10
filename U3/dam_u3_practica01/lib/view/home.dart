import 'package:flutter/material.dart';

import './widgets/navBottomDestination.dart';
import './materia.dart';
import './horario.dart';
import './profesor.dart';
import './asistencia.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _index = 0;
  final List<String> _titles = ['Materia', 'Horario', 'Profesor', 'Asistencia'];
  final List<Icon> _icons = [
    const Icon(Icons.view_list_outlined),
    const Icon(Icons.watch_later_outlined),
    const Icon(Icons.person_outline),
    const Icon(Icons.assessment_outlined),
  ];

  final List<Icon> _filled_icons = [
    const Icon(Icons.view_list),
    const Icon(Icons.watch_later),
    const Icon(Icons.person),
    const Icon(Icons.assessment),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _drawAppBar(),
      body: _drawBody(),
      bottomNavigationBar: _drawBottomNavigationBar(),
    );
  }

  AppBar _drawAppBar() {
    return AppBar(
      //backgroundColor: Colors.orange[50],
      centerTitle: true,
      leading: _icons[_index],
      title: Text(_titles[_index]),
    );
  }

  Widget _drawBody() {
    switch (_index) {
      case 0:
        return const Materia();
      case 1:
        return const Horario();
      case 2:
        return const Profesor();
      case 3:
        return const Asistencia();
      default:
        return const Center(
          child: Text('Error!'),
        );
    }
  }

  NavigationBar _drawBottomNavigationBar() {
    return NavigationBar(
      selectedIndex: _index,
      //surfaceTintColor: Colors.orange[50],
      //backgroundColor: Colors.orange[50],
      //indicatorColor: Colors.orange[100],
      onDestinationSelected: (index) {
        setState(() {
          _index = index;
        });
      },
      destinations: NavBottomDestination.getNavBottomDestination(_icons, _filled_icons),
    );
  }
}
