import 'package:flutter/material.dart';

import '../../controller/person_controller.dart';
import '../../model/person_model.dart';

class ViewAllScreen extends StatefulWidget {
  const ViewAllScreen({super.key});

  @override
  State<ViewAllScreen> createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<ViewAllScreen> {
  @override
  Widget build(BuildContext context) {
    return _displayViewAllScreen();
  }

  Widget _displayViewAllScreen() {
    return FutureBuilder(
      future: PersonController.getAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error'),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              padding: _dynamicPadding(),
              itemCount: snapshot.data!.length + 1,
              itemBuilder: (context, index) {
                if (index == snapshot.data!.length) {
                  return _displayMessage();
                } else {
                  return _displayListTile(snapshot.data![index]);
                }
              },
            );
          } else {
            return const Center(
              child: Text('No hay datos, inserta algunos primero.'),
            );
          }
        }
      },
    );
  }

  Widget _displayListTile(Person person) {
    return ListTile(
      leading: const CircleAvatar(child: Icon(Icons.person)),
      title: Text('${person.name} ${person.lastName}'),
      subtitle: Text('Age: ${person.age}'),
    );
  }

  Widget _displayMessage() {
    return Padding(
      padding: const EdgeInsets.only(top: 33, bottom: 33),
      child: RichText(
        textAlign: TextAlign.center,
        text: const TextSpan(
          style: TextStyle(fontSize: 14, color: Colors.black),
          children: [
            TextSpan(
              text: 'Developed with ',
            ),
            WidgetSpan(
              child: Icon(
                Icons.favorite,
                color: Colors.red,
                size: 14,
              ),
            ),
            TextSpan(
              text: ' from México to the world!',
            ),
          ],
        ),
      ),
    );
  }

  EdgeInsets _dynamicPadding() {
    final screenSize = MediaQuery.of(context).size;

    return EdgeInsets.only(
      left: screenSize.width * 0.1,
      right: screenSize.height * 0.1,
    );
  }
}
