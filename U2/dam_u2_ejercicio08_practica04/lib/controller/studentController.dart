import 'package:dam_u2_ejercicio08_practica04/model/student.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentController {
  List<Student> data = [];

  /// Fetch data from SharedPreferences
  Future<void> getStudents() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    var students = sp.getStringList('students') ?? [];

    data.clear();

    for (String student in students) {
      data.add(Student.toStudent(student));
    }
    print(students);
    print(data[0].toString());
  }

  /// Add a new student to the list and save it to SharedPreferences
  Future<void> addStudent(Student student) async {
    data.add(student);
    await saveFile();
  }

  /// Clear the data from SharedPreferences
  Future<void> clearInventory() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.remove('students');
  }

  /// Update a student in the list and save it to SharedPreferences
  Future<void> updateStudent(int index, Student student) async {
    data[index] = student;
    await saveFile();
  }

  /// Save the data to SharedPreferences
  Future<void> saveFile() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    List<String> students = [];

    for (var element in data) {
      students.add(element.toString());
    }

    await sp.setStringList('students', students);
  }

/////////////////////////////////////////////////////////////////////////////

// Future<void> loadData() async {
//   SharedPreferences sp = await SharedPreferences.getInstance();
//   List<String> students = sp.getStringList('students') ?? [];
//
//   data.clear();
//
//   for (var student in students) {
//     data.add(Student.toStudent(student));
//   }
// }
//
// // Future<bool> clearInventory() async {
// //   SharedPreferences sp = await SharedPreferences.getInstance();
// //
// //   return sp.remove('students');
// // }
//
// void newStudent(Student student) {
//   data.add(student);
// }
//
// void updateStudent(int index, Student student) {
//   data[index] = student;
// }
//
// void deleteStudent(int index) {
//   data.removeAt(index);
// }
}
