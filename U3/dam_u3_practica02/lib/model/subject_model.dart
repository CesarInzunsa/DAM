import 'dart:math';

class SubjectModel {
  String idSubject;
  String nameSubject;
  String semesterSubject;
  String teacherSubject;

  SubjectModel({
    String? idSubject,
    required this.nameSubject,
    required this.semesterSubject,
    required this.teacherSubject,
  }) : idSubject = idSubject ?? _createUniqueId();

  static String _createUniqueId() {
    var random = Random();
    var time = DateTime.now().millisecondsSinceEpoch;
    var uniqueId = '$time${random.nextInt(10000)}';
    return uniqueId;
  }

  Map<String, dynamic> toJSON() {
    return {
      'idSubject': idSubject,
      'nameSubject': nameSubject,
      'semesterSubject': semesterSubject,
      'teacherSubject': teacherSubject,
    };
  }

  factory SubjectModel.toSubject(Map<String, dynamic> json) {
    return SubjectModel(
      idSubject: json['idSubject'],
      nameSubject: json['nameSubject'],
      semesterSubject: json['semesterSubject'],
      teacherSubject: json['teacherSubject'],
    );
  }
}
