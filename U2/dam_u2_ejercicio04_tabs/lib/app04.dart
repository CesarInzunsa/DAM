import 'package:flutter/material.dart';

List<String> imagenes = [
  "assets/computacion/ic280.png",
  "assets/computacion/ic281.png",
  "assets/computacion/ic282.png",
  "assets/computacion/ic283.png",
  "assets/computacion/ic284.png",
  "assets/computacion/ic285.png",
  "assets/computacion/ic286.png",
  "assets/computacion/ic287.png",
  "assets/computacion/ic288.png",
  "assets/computacion/ic289.png",
  "assets/computacion/ic290.png",
  "assets/computacion/ic291.png",
  "assets/computacion/ic292.png",
  "assets/computacion/ic293.png",
  "assets/computacion/ic294.png",
  "assets/computacion/ic295.png",
  "assets/computacion/ic296.png",
  "assets/computacion/ic297.png",
];

List<String> textos = [
  "Firefox",
  "Finder",
  "Edge",
  "Excel",
  "Chrome",
  "Apple",
  "Android",
  "AppStore",
  "Hoja Calculo",
  "GMail",
  "Windows",
  "Word",
  "Ittec",
  "PlayStore",
  "PowerPoint",
  "Maps",
  "Tuxito",
  "Google",
];

class App04 extends StatefulWidget {
  const App04({super.key});

  @override
  State<App04> createState() => _App04State();
}

class _App04State extends State<App04> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            "TABS y GRIDVIEW",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          bottom: TabBar(
              labelStyle: TextStyle(color: Colors.white),
              unselectedLabelStyle: TextStyle(color: Colors.grey),
              tabs: [
                Tab(
                  text: 'CARD',
                ),
                Tab(
                  text: 'GRID VIEW COUNT',
                ),
                Tab(
                  text: 'GRID VIEW BUILDER',
                ),
              ]),
        ),
        body: TabBarView(children: [
          list1(),
          list2(),
          list3(),
        ]),
      ),
    );
  }

  Widget list1() {
    return ListView.builder(
        itemCount: imagenes.length,
        itemBuilder: (context, index) {
          return Card(
            child: Container(
                width: 500,
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(imagenes[index]),
                    Text(
                      textos[index],
                      style: TextStyle(fontSize: 25),
                    )
                  ],
                )),
          );
        });
  }

  Widget list2() {
    return GridView.count(
      crossAxisCount: 3,
      children: [
        itemGrid(0),
        itemGrid(1),
        itemGrid(2),
        itemGrid(3),
        itemGrid(4),
        itemGrid(5),
        itemGrid(6),
        itemGrid(7),
        itemGrid(8),
        itemGrid(9),
        itemGrid(10),
        itemGrid(11),
        itemGrid(12),
        itemGrid(13),
        itemGrid(14),
        itemGrid(15),
        itemGrid(16),
        itemGrid(17),
      ],
    );
  }

  Widget list3() {
    return GridView.builder(
        itemCount: imagenes.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(textos[index])),
              );
            },
            child: Container(
              width: 50,
              height: 50,
              child: Image.asset(imagenes[index]),
            ),
          );
        });
  }

  Widget itemGrid(int i) {
    return Container(
      width: 50,
      height: 50,
      color: Colors.red,
      child: Image.asset(imagenes[i]),
    );
  }
}
