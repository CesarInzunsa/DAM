import 'package:flutter/material.dart';

class App04 extends StatefulWidget {
  const App04({super.key});

  @override
  State<App04> createState() => _App04State();
}

enum EstadoCivil { soltero, casado }

List Colores = ["Azul", "Verde", "Café", "Amarillo", "Naranja", "Rojo"];

class _App04State extends State<App04> {
  EstadoCivil radioButtonRes = EstadoCivil.soltero;
  bool checkBoxRes = false;
  String itemSeleccionado = Colores.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hola"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: EdgeInsets.all(50),
        children: [
          RadioListTile(
              title: Text("SOLTERO"),
              value: EstadoCivil.soltero,
              groupValue: radioButtonRes,
              onChanged: (data) {
                setState(() {
                  radioButtonRes = data!;
                });
              }),
          SizedBox(height: 10),
          RadioListTile(
              title: Text("CASADO"),
              value: EstadoCivil.casado,
              groupValue: radioButtonRes,
              onChanged: (data) {
                setState(() {
                  radioButtonRes = data!;
                });
              }),
          SizedBox(
            height: 10,
          ),
          CheckboxListTile(
              title: Text("INSCRITO EN INGLÉS"),
              value: checkBoxRes,
              onChanged: (data) {
                setState(() {
                  checkBoxRes = data!;
                });
              }),
          DropdownButtonFormField(
              items: Colores.map((e) {
                return DropdownMenuItem(
                  child: Text(e),
                  value: e,
                );
              }).toList(),
              onChanged: (item) {
                setState(() {
                  itemSeleccionado = item.toString();
                });
              })
        ],
      ),
    );
  }
}
