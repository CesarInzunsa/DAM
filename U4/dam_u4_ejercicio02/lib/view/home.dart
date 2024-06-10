import 'package:dam_u4_ejercicio02/view/create_view.dart';
import 'package:dam_u4_ejercicio02/view/select_all.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejercicio 02: Firebase CRUD'),
      ),
      body: _displayBody(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onDestinationSelected,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.create), label: 'Create'),
          NavigationDestination(icon: Icon(Icons.list), label: 'Select All'),
        ],
      ),
    );
  }

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _displayBody(){
    switch(_selectedIndex) {
      case 0:
        return const CreateView();
      case 1:
        return const SelectAll();
      default:
        return const CreateView();
    }
  }
}
