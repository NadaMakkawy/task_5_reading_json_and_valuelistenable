import 'dart:convert';

class Person {
  final int id;
  final String name;
  final int age;
  final String phoneNumber;
  final String address;

  Person({
    required this.id,
    required this.name,
    required this.age,
    required this.phoneNumber,
    required this.address,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      phoneNumber: json['phone_number'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'phone_number': phoneNumber,
      'address': address,
    };
  }

  static String encode(List<Person> persons) => json.encode(
        persons.map<Map<String, dynamic>>((person) => person.toJson()).toList(),
      );

  static List<Person> decode(String persons) =>
      (json.decode(persons) as List<dynamic>)
          .map<Person>((person) => Person.fromJson(person))
          .toList();
}
