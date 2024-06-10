class Task {
  int id;
  String description;

  Task({required this.id, required this.description});

  /// Convert a Map<String, dynamic> into a Task
  static Task toTask(Map<String, dynamic> map) {
    return Task(
        id: map['id']?.toInt() ?? 0,
        description: map['description'] ?? ''
    );
  }
}
