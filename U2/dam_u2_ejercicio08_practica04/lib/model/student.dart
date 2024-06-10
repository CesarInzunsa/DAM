class Student {
  String nc;
  String name;
  String address;
  String degree;

  Student({
    required this.nc,
    required this.name,
    required this.address,
    required this.degree,
  });

  /// Returns a string representation of the object.
  @override
  String toString() {
    return "$nc&&$name&&$address&&$degree";
  }

  static Student toStudent(String student) {
    List<String> data = student.split('&&');
    return Student(
      nc: data[0],
      name: data[1],
      address: data[2],
      degree: data[3],
    );
  }
}
