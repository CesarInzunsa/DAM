import 'package:dam_u4_ejercicio02/controller/auto_controller.dart';
import 'package:flutter/material.dart';

class SelectAll extends StatefulWidget {
  const SelectAll({super.key});

  @override
  State<SelectAll> createState() => _SelectAllState();
}

class _SelectAllState extends State<SelectAll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _drawData(),
    );
  }

  Widget _drawData() {
    return FutureBuilder(
        future: AutoController.mostrarTodos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index){
                return ListTile(
                  leading: Text(snapshot.data![index].marca),
                  title: Text(snapshot.data![index].modelo),
                  subtitle: Text(snapshot.data![index].fechaCompra.toString()),
                );
              }
            );
          }
        });
  }
}
