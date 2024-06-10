import 'subject_model.dart';
import 'task_model.dart';

class TaskSubjectModel {
  TaskModel task;
  SubjectModel subject;

  TaskSubjectModel({
    required this.task,
    required this.subject,
  });

  factory TaskSubjectModel.toTaskSubject(Map<String, dynamic> json) {
    TaskModel task = TaskModel(
      idTask: json['idTask'],
      idSubjectTask: json['idSubjectTask'],
      dateTask: json['dateTask'],
      descriptionTask: json['descriptionTask'],
    );

    SubjectModel subject = SubjectModel(
      idSubject: json['idSubjectTask'],
      nameSubject: json['nameSubject'],
      semesterSubject: json['semesterSubject'],
      teacherSubject: json['teacherSubject'],
    );

    return TaskSubjectModel(
      task: task,
      subject: subject,
    );
  }
}
