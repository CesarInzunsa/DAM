import 'package:flutter/material.dart';

import '../../controller/horarioController.dart';
import '../../controller/materiaController.dart';
import '../../controller/profesorController.dart';
import '../../model/horarioModel.dart';
import '../../model/materiaModel.dart';
import '../../model/profesorModel.dart';

class FormInsertScreen extends StatefulWidget {
  const FormInsertScreen({super.key});

  @override
  State<FormInsertScreen> createState() => _FormInsertScreenState();
}

TextEditingController horaController = TextEditingController();
TextEditingController edificioController = TextEditingController();
TextEditingController salonController = TextEditingController();
int idProfesorController = 0;
int idMateriaController = 0;
final _formKey = GlobalKey<FormState>();
List<HorarioModel> horarios = [];
List<ProfesorModel> profesores = [];
List<MateriaModel> materias = [];

TextEditingController horaInicioController = TextEditingController();
TextEditingController horaFinController = TextEditingController();

// Lista de edificios
List<String> edificios = ['UD', 'UVP', 'LC', 'G', 'X', 'J'];

// Lista de aulas por edificio
Map<String, List<String>> aulas = {
  'UD': ['UD1', 'UD2', 'UD3', 'UD4'],
  'UVP': ['UVP1', 'UVP2', 'UVP3', 'UVP4'],
  'LC': [
    'Cisco 1',
    'Cisco 2',
    'Sala A',
    'Sala B',
    'Sala general',
    'Sala operativos',
  ],
  'G': ['G1', 'G2', 'G3', 'G4'],
  'X': ['X1', 'X2', 'X3', 'X4'],
  'J': ['J1', 'J2', 'J3', 'J4'],
};

class _FormInsertScreenState extends State<FormInsertScreen> {

  void _loadData() async {
    List<ProfesorModel> profesores2 = await ProfesorController.getAll();
    profesores = profesores2;

    List<MateriaModel> materias2 = await MateriaController.getAll();

    materias = materias2;

    idProfesorController = profesores[0].idProfesor;
    idMateriaController = materias[0].idMateria;

    setState(() {
      idProfesorController;
      idMateriaController;
      profesores;
      materias;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
    horaInicioController.text = '';
    horaFinController.text = '';
    edificioController.text = edificios[0];
    salonController.text = aulas[edificios[0]]![0];

    setState(() {
      idProfesorController;
      idMateriaController;
      profesores;
      materias;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insertar nuevo horario'),
      ),
      body: _displayBody(),
    );
  }

  _displayBody() {
    return Column(
      children: [
        _getHorarioForm(),
        _getInsertButton(),
      ],
    );
  }

  /// This function gets the form for creating or updating a Horario.
  Widget _getHorarioForm() {
    return Padding(
      padding: const EdgeInsets.all(22),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: horaInicioController,
              readOnly: true,
              decoration: const InputDecoration(
                hintText: 'Hora de inicio',
                filled: true,
                prefixIcon: Icon(Icons.access_time_outlined),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese un horario';
                }

                return null;
              },
              onTap: () {
                showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                ).then((value) {
                  if (value != null) {
                    horaInicioController.text = value.format(context);
                  }
                });
              },
            ),
            const SizedBox(height: 11),
            TextFormField(
              controller: horaFinController,
              readOnly: true,
              decoration: const InputDecoration(
                hintText: 'Hora de fin',
                filled: true,
                prefixIcon: Icon(Icons.access_time_outlined),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese un horario';
                }
                return null;
              },
              onTap: () {
                showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                ).then((value) {
                  if (value != null) {
                    horaFinController.text = value.format(context);
                  }
                });
              },
            ),
            const SizedBox(height: 11),
            // DropdownFormField para seleccionar edificios
            DropdownButtonFormField(
              value: edificioController.text,
              items: edificios.map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  edificioController.text = value!;
                  salonController.text = aulas[value]![0];
                });
              },
            ),
            const SizedBox(height: 11),
            DropdownButtonFormField(
              value: salonController.text,
              items: aulas[edificioController.text]!.map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  salonController.text = value.toString();
                });
              },
            ),
            const SizedBox(height: 11),
            DropdownButtonFormField(
              value: idProfesorController,
              items: profesores.map((e) {
                return DropdownMenuItem(
                  value: e.idProfesor,
                  child: Text(e.nombreProfesor),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  idProfesorController = value!;
                });
              },
            ),
            const SizedBox(height: 11),
            DropdownButtonFormField(
              value: idMateriaController,
              items: materias.map((e) {
                return DropdownMenuItem(
                  value: e.idMateria,
                  child: Text(e.nombreMateria),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  idMateriaController = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  /// This function gets the action button for creating or updating a Horario.
  Widget _getInsertButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          // Comprobar si la hora de inicio y fin son iguales
          if (horaInicioController.text == horaFinController.text) {
            _showMessage(
                'La hora de inicio y la hora de fin no pueden ser iguales');
            return;
          }

          _insertOneHorario();
        }
      },
      child: const Text('Insertar'),
    );
  }

  /// This function creates a new Horario
  void _insertOneHorario() {
    horaController.text =
        '${horaInicioController.text}-${horaFinController.text}';
    HorarioModel horario = HorarioModel(
      idHorario: -1,
      profesorHorario: ProfesorModel(
        idProfesor: idProfesorController,
        nombreProfesor: '',
        carreraProfesor: '',
      ),
      materiaHorario: MateriaModel(
        idMateria: idMateriaController,
        nombreMateria: '',
      ),
      horaHorario: horaController.text,
      edificioHorario: edificioController.text,
      salonHorario: salonController.text,
    );

    HorarioController.insertOne(horario).then((value) {
      _showMessage('Horario creado correctamente');
      Navigator.pop(context);
      //_loadData();
    });
  }

  /// This function shows a message in a SnackBar
  void _showMessage(String msj) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msj)),
    );
  }
}
