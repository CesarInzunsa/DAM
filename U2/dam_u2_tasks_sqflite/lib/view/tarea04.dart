import 'package:dam_u2_tasks_sqflite/controller/taskManager.dart';
import 'package:flutter/material.dart';
import '../model/task.dart';
import 'dart:developer';

class HomeWork04 extends StatefulWidget {
  const HomeWork04({super.key});

  @override
  State<HomeWork04> createState() => _HomeWork04State();
}

List<Task> toDoListV2 = [];

Future<void> loadTasks() async {
  toDoListV2 = await TaskManager().getTasks();
}

class _HomeWork04State extends State<HomeWork04> {
  int screen = 1;
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To Do App", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: _drawActions(),
      ),
      body: _drawBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            screen = 3;
          });
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  List<Widget> _drawActions() {
    return [
      IconButton(
        onPressed: () {
          setState(() {
            screen = 1;
          });
        },
        icon: const Icon(Icons.home, color: Colors.white),
      ),
      TextButton(
          onPressed: () {
            setState(() {
              screen = 2;
            });
          },
          child: const Text('Info', style: TextStyle(color: Colors.white))),
    ];
  }

  Widget _drawBody() {
    switch (screen) {
      case 2:
        return ListView(
          padding: const EdgeInsets.all(40),
          children: _drawInfo(),
        );
      case 3:
        return Padding(
          padding: const EdgeInsets.all(30),
          child: _drawAddTask(),
        );
      case 1:
        return FutureBuilder(
            future: loadTasks(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text("Error");
                }
                return ListView(
                  children: _drawTasks(),
                );
              } else {
                return const CircularProgressIndicator();
              }
            });
      default:
        return ListView(
          children: _drawTasks(),
        );
    }
  }

  Widget _drawAddTask() {
    return Column(children: [
      const Text("New task",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      const SizedBox(height: 10),
      TextField(
          controller: descriptionController,
          decoration: const InputDecoration(
              labelText: "Description", border: OutlineInputBorder())),
      const SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FilledButton(
              style: FilledButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                setState(() {
                  screen = 1;
                });
              },
              child: const Text("Cancel")),
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                if (descriptionController.text.isEmpty) {
                  return;
                }
                setState(() {
                  screen = 1;
                  //toDoListV1.add(descriptionController.text);
                  TaskManager().addTask(descriptionController.text);
                  descriptionController.clear();
                });
              },
              child:
                  const Text("Add task", style: TextStyle(color: Colors.white)))
        ],
      )
    ]);
  }

  List<Widget> _drawInfo() {
    List<Widget> info = [];
    info.add(const Text("About the app",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)));
    info.add(const Text(
      "This is a simple To Do App\nYou can add and remove tasks\nby Cesar Inzunsa",
    ));
    info.add(const SizedBox(height: 20));
    info.add(const Text("Developed with ❤ from Nayarit to the world"));
    return info;
  }

  List<Widget> _drawTasks() {
    List<Widget> tasks = [];
    tasks.add(Image.asset('assets/images/img1.jpg'));
    tasks.add(const Text("My Day",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)));
    for (var i = 0; i < toDoListV2.length; i++) {
      tasks.add(Row(
        children: [
          IconButton(
              onPressed: () {
                setState(() {
                  //TaskManager().removeTask(i);
                  //toDoListV1.removeAt(i);
                });
              },
              icon: const Icon(Icons.circle_outlined),
              color: Colors.purpleAccent),
          Text(toDoListV2[i].description,
              style:
                  const TextStyle(fontStyle: FontStyle.italic, fontSize: 15)),
          // Text(toDoListV1[i],
          //     style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 15))
        ],
      ));
    }
    return tasks;
  }
}
