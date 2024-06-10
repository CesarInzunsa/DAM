import 'package:flutter/material.dart';
import '../controller/musicManager.dart';
import '../model/music.dart';
import 'case01.dart';
import 'case02.dart';
import 'case03.dart';

class App01 extends StatefulWidget {
  const App01({super.key});

  @override
  State<App01> createState() => _App01State();
}

class _App01State extends State<App01> {
  int _index = 0;
  List<Music> musicList = MusicManager().musicList;
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: const Text('Practice 01'),
      ),
      body: _drawBody(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: (currentIndex) {
          setState(() {
            _index = currentIndex;
          });
        },
        currentIndex: _index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.my_library_music),
            label: 'Library',
          ),
        ],
      ),
    );
  }

  Widget _drawBody() {
    switch (_index) {
      case 1:
        return Case02(musicList: musicList);
      case 2:
        return Case03(musicList: musicList, nameController: nameController);
      default:
        return Case01().drawCase01(musicList);
    }
  }
}
