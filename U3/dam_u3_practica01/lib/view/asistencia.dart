import 'package:flutter/material.dart';

import '../controller/asistenciaController.dart';
import '../controller/horarioController.dart';
import '../model/asistenciaModel.dart';
import './widgets/navTabDestination.dart';
import '../model/horarioModel.dart';
import '../model/materiaModel.dart';
import '../model/profesorModel.dart';

class Asistencia extends StatefulWidget {
  const Asistencia({super.key});

  @override
  State<Asistencia> createState() => _AsistenciaState();
}

class _AsistenciaState extends State<Asistencia> {
  int idHorarioController = 0;
  TextEditingController fechaController = TextEditingController();
  bool asistenciaController = false;
  final _formKey = GlobalKey<FormState>();
  List<AsistenciaModel> asistencias = [];
  List<HorarioModel> horarios = [];

  List<AsistenciaModel> asistenciasByDate = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    List<AsistenciaModel> asistencias = await AsistenciaController.getAll();
    setState(() {
      this.asistencias = asistencias;
    });

    List<HorarioModel> horarios = await HorarioController.getAll();
    setState(() {
      this.horarios = horarios;
    });

    if (horarios.isEmpty) return;

    idHorarioController = horarios[0].idHorario;

    setState(() {
      asistenciasByDate = [];
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
            _displayAllAsistencias(),
            _drawQuery(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => _displayAsistenciaModal(),
        ),
      ),
    );
  }

  /// Function to display all Asistencias with a ListTile
  Widget _displayAllAsistencias() {
    if (asistencias.isEmpty) {
      return const Center(child: Text('No hay asistencias registradas'));
    }

    return ListView.builder(
      itemCount: asistencias.length,
      itemBuilder: (builder, index) {
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              child: asistencias[index].asistencia == 1
                  ? const Icon(
                      Icons.check,
                    )
                  : const Icon(
                      Icons.do_not_disturb_on_outlined,
                    ),
            ),
            title: Text(asistencias[index]
                .horarioAsistencia
                .materiaHorario
                .nombreMateria),
            subtitle: Text(asistencias[index]
                .horarioAsistencia
                .profesorHorario
                .nombreProfesor),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(asistencias[index].fechaAsistencia),
                Text(
                    '${asistencias[index].horarioAsistencia.edificioHorario} - ${asistencias[index].horarioAsistencia.salonHorario}')
              ],
            ),
            onTap: () => _showHorarioAlertDialog(asistencias[index]),
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
        const Text('Buscar por fecha y asistencia:',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 11),
        Row(
          children: [
            // datePicker de la asistencia
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: TextFormField(
                  controller: fechaController,
                  decoration: const InputDecoration(
                    hintText: 'Fecha asistencia',
                    filled: true,
                    prefixIcon: Icon(Icons.calendar_today),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(),
                  ),
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese una fecha de asistencia';
                    }
                    return null;
                  },
                  onTap: () {
                    _selectDate();
                  },
                ),
              ),
            ),
            // DropdownButtonFormField para buscar si asistio o no
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(),
                  ),
                  value: asistenciaController,
                  items: const [
                    DropdownMenuItem(value: true, child: Text("Si asistio")),
                    DropdownMenuItem(value: false, child: Text("No asistio")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      asistenciaController = value!;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        FilledButton(
            onPressed: () async {
              asistenciasByDate =
                  await AsistenciaController.getAsistenciasByDate(
                      fechaController.text, asistenciaController ? 1 : 0);

              setState(() {
                asistenciasByDate;
              });
            },
            child: const Text('Buscar')),
        asistenciasByDate.isEmpty || fechaController.text.isEmpty
            ? Center(
                child: Container(
                padding: const EdgeInsets.all(20),
                child: const Text('No se encontraron materias registradas'),
              ))
            : Expanded(
                child: ListView.builder(
                  itemCount: asistenciasByDate.length,
                  itemBuilder: (builder, index) {
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: asistenciasByDate[index].asistencia == 1
                              ? const Icon(
                                  Icons.check,
                                )
                              : const Icon(
                                  Icons.do_not_disturb_on_outlined,
                                ),
                        ),
                        title: Text(asistenciasByDate[index]
                            .horarioAsistencia
                            .materiaHorario
                            .nombreMateria),
                        subtitle: Text(asistenciasByDate[index]
                            .horarioAsistencia
                            .profesorHorario
                            .nombreProfesor),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(asistenciasByDate[index].fechaAsistencia),
                            Text(
                                '${asistenciasByDate[index].horarioAsistencia.edificioHorario} - ${asistencias[index].horarioAsistencia.salonHorario}')
                          ],
                        ),
                        onTap: () =>
                            _showHorarioAlertDialog(asistenciasByDate[index]),
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }

  /// This function displays a modal for creating or updating a Asistencia.
  void _displayAsistenciaModal([AsistenciaModel? asistencia]) {
    if (horarios.isEmpty) {
      _showMessage('Antes de crear asistencias, debe crear horarios');
      return;
    }

    _clearFields();
    showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: true,
      context: context,
      builder: (context) => _drawAsistenciaModal(asistencia),
    );
  }

  /// This function draws the modal for creating or updating a Asistencia.
  Widget _drawAsistenciaModal(AsistenciaModel? asistencia) {
    bool isUpdating = asistencia != null;
    return Column(
      children: [
        _getAsistenciaForm(asistencia),
        _getActionButton(
          isUpdating
              ? () => _updateOneAsistencia(asistencia)
              : _insertOneAsistencia,
          isUpdating ? 'Actualizar asistencia' : 'Crear asistencia',
        ),
      ],
    );
  }

  /// This function gets the form for creating or updating a Asistencia.
  Widget _getAsistenciaForm(AsistenciaModel? asistencia) {
    if (asistencia != null) {
      idHorarioController = asistencia.horarioAsistencia.idHorario;
      fechaController.text = asistencia.fechaAsistencia;
      asistenciaController = asistencia.asistencia == 1 ? true : false;
    }
    return Padding(
      padding: const EdgeInsets.all(22),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            DropdownButtonFormField(
              isExpanded: true,
              value: idHorarioController,
              items: horarios.map((e) {
                return DropdownMenuItem(
                  value: e.idHorario,
                  child: Text(
                      'Materia: ${e.materiaHorario.nombreMateria}\nHorario: ${e.horaHorario}\nProfesor: ${e.profesorHorario.nombreProfesor}'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  idHorarioController = value!;
                });
              },
            ),
            const SizedBox(height: 11),
            TextFormField(
              controller: fechaController,
              decoration: const InputDecoration(
                hintText: 'Fecha asistencia',
                filled: true,
                prefixIcon: Icon(Icons.calendar_today),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(),
              ),
              readOnly: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese una fecha de asistencia';
                }
                return null;
              },
              onTap: () {
                _selectDate();
              },
            ),
            const SizedBox(height: 11),
            DropdownButtonFormField(
              value: asistenciaController,
              items: const [
                DropdownMenuItem(value: true, child: Text("Si asistio")),
                DropdownMenuItem(value: false, child: Text("No asistio")),
              ],
              onChanged: (value) {
                setState(() {
                  asistenciaController = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    ).then((value) {
      if (value != null) {
        setState(() {
          fechaController.text = value.toString().split(" ")[0];
        });
      }
    });
  }

  /// This function gets the action button for creating or updating a Asistencia.
  Widget _getActionButton(myFuction, String text) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          Navigator.of(context).pop();
          myFuction();
        }
      },
      child: Text(text),
    );
  }

  /// This function shows an alert dialog for a Asistencia.
  void _showHorarioAlertDialog(AsistenciaModel asistencia) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Asistencia'),
        content: const Text('¿Qué desea hacer con la asistencia?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _displayAsistenciaModal(asistencia);
            },
            child: const Text('Editar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _showConfirmDeleteAsistencia(asistencia);
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  /// This function shows a confirm dialog for deleting a Asistencia.
  void _showConfirmDeleteAsistencia(AsistenciaModel asistencia) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar asistencia'),
        content: const Text('¿Está seguro de eliminar la asistencia?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _deleteOneAsistencia(asistencia);
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

  /// This function creates a new Asistencia
  void _insertOneAsistencia() {
    AsistenciaModel asistencia = AsistenciaModel(
      idAsistencia: -1,
      horarioAsistencia: HorarioModel(
        idHorario: idHorarioController,
        profesorHorario: ProfesorModel(
          idProfesor: -1,
          nombreProfesor: '',
          carreraProfesor: '',
        ),
        materiaHorario: MateriaModel(
          idMateria: -1,
          nombreMateria: '',
        ),
        horaHorario: '',
        edificioHorario: '',
        salonHorario: '',
      ),
      fechaAsistencia: fechaController.text,
      asistencia: asistenciaController ? 1 : 0,
    );

    AsistenciaController.insertOne(asistencia).then((value) {
      _showMessage('Asistencia creada correctamente');
      _loadData();
    });
  }

  /// This function updates a Asistencia
  void _updateOneAsistencia(AsistenciaModel oldAsistencia) {
    AsistenciaModel asistencia = AsistenciaModel(
      idAsistencia: oldAsistencia.idAsistencia,
      horarioAsistencia: HorarioModel(
        idHorario: idHorarioController,
        profesorHorario: ProfesorModel(
          idProfesor: -1,
          nombreProfesor: '',
          carreraProfesor: '',
        ),
        materiaHorario: MateriaModel(
          idMateria: -1,
          nombreMateria: '',
        ),
        horaHorario: '',
        edificioHorario: '',
        salonHorario: '',
      ),
      fechaAsistencia: fechaController.text,
      asistencia: asistenciaController ? 1 : 0,
    );

    AsistenciaController.updateOne(asistencia).then((value) {
      _showMessage('Asistencia actualizada correctamente');
      _loadData();
    });
  }

  /// This function deletes a Asistencia
  void _deleteOneAsistencia(AsistenciaModel asistencia) {
    AsistenciaController.deleteOne(asistencia.idAsistencia).then((value) {
      _showMessage('Asistencia eliminada correctamente');
      _loadData();
    });
  }

  /// This function clears the fields
  void _clearFields() {
    idHorarioController = horarios[0].idHorario;
    asistenciaController = false;
    fechaController.clear();
  }

  /// This function shows a message in a SnackBar
  void _showMessage(String msj) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msj)),
    );
  }
}
