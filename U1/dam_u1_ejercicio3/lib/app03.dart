import 'package:flutter/material.dart';

class App03 extends StatefulWidget {
  const App03({super.key});

  @override
  State<App03> createState() => _App03State();
}

class _App03State extends State<App03> {
  // this is a private variable to store the index of the selected item
  int _indice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App03'),
        backgroundColor: Colors.blue,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _indice = 1;
              });
            },
            icon: Icon(Icons.school_outlined),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _indice = 2;
              });
            },
            icon: Icon(Icons.table_bar_outlined),
          ),
        ],
      ),
      body: dinamico(),
    );
  }

  // This is a function to create a dynamic layout
  Widget dinamico() {
    switch (_indice) {
      case 1:
        {
          return Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              InkWell(
                child: Image.asset('assets/logo.png'),
                onTap: () {
                  setState(() {
                    _indice = 0;
                  });
                },
              ),
            ]),
          );
        }
      case 2:
        {
          return ListView(
            padding: EdgeInsets.all(50),
            children: [
              TextField(),
              SizedBox(
                height: 10,
              ),
              FilledButton(onPressed: () {}, child: Text("Evaluar"))
            ],
          );
        }
    }

    return Center(
      child: Icon(
        Icons.offline_pin_outlined,
        size: 90,
      ),
    );
  }
}
