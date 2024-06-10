class TaskModel {
  int idTask;
  String idSubjectTask;
  String dateTask;
  String descriptionTask;

  TaskModel({
    this.idTask = -1,
    required this.idSubjectTask,
    required this.dateTask,
    required this.descriptionTask,
  });

  Map<String, dynamic> toJSON() {
    return {
      'idSubjectTask': idSubjectTask,
      'dateTask': dateTask,
      'descriptionTask': descriptionTask,
    };
  }

  factory TaskModel.toTask(Map<String, dynamic> json) {
    return TaskModel(
      idTask: json['idTask'],
      idSubjectTask: json['idSubjectTask'],
      dateTask: json['dateTask'],
      descriptionTask: json['descriptionTask'],
    );
  }
}
