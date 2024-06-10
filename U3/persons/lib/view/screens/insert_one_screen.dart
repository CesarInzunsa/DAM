import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../controller/person_controller.dart';
import '../../model/person_model.dart';

class InsertOneScreen extends StatefulWidget {
  const InsertOneScreen({super.key});

  @override
  State<InsertOneScreen> createState() => _InsertOneScreenState();
}

class _InsertOneScreenState extends State<InsertOneScreen> {
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return _displayInsertOneScreen();
  }

  Widget _displayInsertOneScreen() {
    return SingleChildScrollView(
      padding: _dynamicPadding(),
      child: Column(
        children: [
          _getTextFormField('Name', nameController),
          _getTextFormField('Last name', lastNameController),
          _getNumberFormField('Age', ageController),
          _getInsertButton(),
        ],
      ),
    );
  }

  Widget _getTextFormField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }

  Widget _getNumberFormField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }

  Widget _getInsertButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 22),
      child: ElevatedButton(
        onPressed: _insertPerson,
        child: const Text('Insert person'),
      ),
    );
  }

  void _insertPerson() {
    final person = Person(
      name: nameController.text,
      lastName: lastNameController.text,
      age: int.parse(ageController.text),
    );

    PersonController.insertOne(person).then((value) => clearFields());
  }

  EdgeInsets _dynamicPadding() {
    final screenSize = MediaQuery.of(context).size;

    return EdgeInsets.only(
      left: screenSize.width * 0.1,
      right: screenSize.height * 0.1,
    );
  }

  void clearFields(){
    nameController.clear();
    lastNameController.clear();
    ageController.clear();
  }
}
