import 'package:flutter/material.dart';

import 'config/config.dart';
import 'query_subjects_screen.dart';
import 'query_tasks_screen.dart';
import 'today_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Config.getAppBar(_currentIndex),
      body: _displayBody(),
      bottomNavigationBar: Config.getNavigationBar(
        _currentIndex,
        _onBottomDestinationSelected,
      ),
    );
  }

  Widget _displayBody() {
    switch (_currentIndex) {
      case 0:
        return const TodayScreen();
      case 1:
        return const QuerySubjectsScreen();
      case 2:
        return const QueryTasksScreen();
      default:
        return const TodayScreen();
    }
  }

  _onBottomDestinationSelected(int index) =>
      setState(() => _currentIndex = index);
}
