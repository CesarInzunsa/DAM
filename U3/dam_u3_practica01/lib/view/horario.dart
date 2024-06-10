import 'package:dam_u3_practica01/view/horarioScreens/formUpdateScreen.dart';
import 'package:flutter/material.dart';

import '../controller/horarioController.dart';
import '../controller/materiaController.dart';
import '../controller/profesorController.dart';
import '../model/horarioModel.dart';
import '../model/materiaModel.dart';
import '../model/profesorModel.dart';
import './widgets/navTabDestination.dart';
import 'horarioScreens/formInsertScreen.dart';

class Horario extends StatefulWidget {
  const Horario({super.key});

  @override
  State<Horario> createState() => _HorarioState();
}

class _HorarioState extends State<Horario> {
  TextEditingController horaController = TextEditingController();
  TextEditingController edificioController = TextEditingController();
  TextEditingController salonController = TextEditingController();
  int idProfesorController = 0;
  int idMateriaController = 0;
  List<HorarioModel> horarios = [];
  List<ProfesorModel> profesores = [];
  List<MateriaModel> materias = [];

  TextEditingController horaInicioController = TextEditingController();
  TextEditingController horaFinController = TextEditingController();
  List<HorarioModel> horariosByHoraEdificio = [];

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

  @override
  void initState() {
    super.initState();
    _loadData();
    setState(() {
      edificioController.text = edificios[0];
    });
  }

  void _loadData() async {
    List<HorarioModel> horarios = await HorarioController.getAll();
    setState(() {
      this.horarios = horarios;
    });
    List<ProfesorModel> profesores = await ProfesorController.getAll();
    setState(() {
      this.profesores = profesores;
    });

    List<MateriaModel> materias = await MateriaController.getAll();
    setState(() {
      this.materias = materias;
    });

    edificioController.text = edificios[0];
    salonController.text = aulas[edificioController.text]![0];

    if (profesores.isEmpty || materias.isEmpty) {
      return;
    }

    idProfesorController = profesores[0].idProfesor;
    idMateriaController = materias[0].idMateria;

    setState(() {
      horariosByHoraEdificio = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: NavTabDestination.getNavTabDestination(),
        body: TabBarView(
          children: [
            _displayAllHorarios(),
            _drawQuery(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => _displayHorarioModal(),
        ),
      ),
    );
  }

  /// Function to display all horarios with a ListTile
  Widget _displayAllHorarios() {
    if (horarios.isEmpty) {
      return const Center(child: Text('No hay horarios registrados'));
    }

    return ListView.builder(
      itemCount: horarios.length,
      itemBuilder: (builder, index) {
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Text(horarios[index].idHorario.toString()),
            ),
            title: Text(horarios[index].materiaHorario.nombreMateria),
            subtitle: Text(horarios[index].profesorHorario.nombreProfesor),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(horarios[index].horaHorario),
                Text(
                    '${horarios[index].edificioHorario} - ${horarios[index].salonHorario}'),
              ],
            ),
            onTap: () => _showHorarioAlertDialog(horarios[index]),
          ),
        );
      },
    );
  }

  /// Function to display a query
  Widget _drawQuery() {
    return Column(
      children: [
        const SizedBox(height: 11),
        const Text('Buscar por hora y edificio:',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: TextFormField(
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
              ),
            ),
            Expanded(
              child: TextFormField(
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
            ),
            const SizedBox(width: 5),
          ],
        ),
        const SizedBox(height: 11),
        // DropdownFormField para seleccionar edificios
        Row(
          children: [
            const SizedBox(width: 11),
            Expanded(
              child: DropdownButtonFormField(
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
                  });
                },
              ),
            ),
            const SizedBox(width: 11),
            FilledButton(
                onPressed: () async {
                  List<HorarioModel> horariosByHoraEdificio =
                      await HorarioController.getHorariosByHoraEdificio(
                          '${horaInicioController.text}-${horaFinController.text}',
                          edificioController.text);
                  this.horariosByHoraEdificio = horariosByHoraEdificio;
                  setState(() {
                    this.horariosByHoraEdificio;
                  });
                },
                child: const Text('Buscar')),
          ],
        ),
        const SizedBox(height: 11),
        horariosByHoraEdificio.isEmpty ||
                horaInicioController.text.isEmpty ||
                horaFinController.text.isEmpty
            ? Center(
                child: Container(
                padding: const EdgeInsets.all(20),
                child: const Text('No se encontraron materias registradas'),
              ))
            : Expanded(
                child: ListView.builder(
                  itemCount: horariosByHoraEdificio.length,
                  itemBuilder: (builder, index) {
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(horariosByHoraEdificio[index]
                              .idHorario
                              .toString()),
                        ),
                        title: Text(horariosByHoraEdificio[index]
                            .materiaHorario
                            .nombreMateria),
                        subtitle: Text(horariosByHoraEdificio[index]
                            .profesorHorario
                            .nombreProfesor),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(horariosByHoraEdificio[index].horaHorario),
                            Text(
                                '${horariosByHoraEdificio[index].edificioHorario} - ${horariosByHoraEdificio[index].salonHorario}'),
                          ],
                        ),
                        onTap: () => _showHorarioAlertDialog(
                            horariosByHoraEdificio[index]),
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }

  /// This function displays a modal for creating or updating a Horario.
  void _displayHorarioModal([HorarioModel? horario]) {
    if (profesores.isEmpty || materias.isEmpty) {
      _showMessage(
          'Antes de crear un horario, debe registrar profesores y materias.');
      return;
    }

    _clearFields();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FormInsertScreen(),
      ),
    ).then((value) => _loadData());
  }

  /// This function shows an alert dialog for a Horario.
  void _showHorarioAlertDialog(HorarioModel horario) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Horario'),
        content: const Text('¿Qué desea hacer con el horario?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FormUpdateScreen(horario: horario),
                ),
              ).then((value) => _loadData());
            },
            child: const Text('Editar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _showConfirmDeleteHorario(horario);
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  /// This function shows a confirm dialog for deleting a Horario.
  void _showConfirmDeleteHorario(HorarioModel horario) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar horario'),
        content: const Text('¿Está seguro de eliminar el horario?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _deleteOneHorario(horario);
            },
            child: const Text('Sí'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('No'),
          ),
        ],
      ),
    );
  }

  /// This function deletes a Horario
  void _deleteOneHorario(HorarioModel horario) {
    HorarioController.deleteOne(horario.idHorario).then((value) {
      _showMessage('Horario eliminado correctamente');
      _loadData();
    });
  }

  /// This function clears the fields
  void _clearFields() {
    horaController.clear();
    edificioController.text = edificios[0];
    salonController.text = aulas[edificioController.text]![0];
    idProfesorController = profesores[0].idProfesor;
    idMateriaController = materias[0].idMateria;
    horaInicioController.clear();
    horaFinController.clear();
  }

  /// This function shows a message in a SnackBar
  void _showMessage(String msj) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msj)),
    );
  }
}
