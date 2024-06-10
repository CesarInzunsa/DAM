class Person {
  final String name;
  final String lastName;
  final int age;

  Person({
    required this.name,
    required this.lastName,
    required this.age,
  });

  Map<String, dynamic> toJSON() {
    return {
      'name': name,
      'lastName': lastName,
      'age': age,
    };
  }

  static fromJSON(Map<String, dynamic> data) {
    return Person(
      name: data['name'],
      lastName: data['lastName'],
      age: data['age'],
    );
  }
}
