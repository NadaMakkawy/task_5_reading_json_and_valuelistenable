import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/person.dart';

class PersonList extends StatefulWidget {
  const PersonList({super.key});

  @override
  _PersonListState createState() => _PersonListState();
}

class _PersonListState extends State<PersonList> {
  final ValueNotifier<List<Person>> _persons = ValueNotifier<List<Person>>([]);

  @override
  void initState() {
    super.initState();
    _loadPersons();
  }

  Future<void> _loadPersons() async {
    final String response =
        await rootBundle.loadString('assets/data/persons.json');
    final List<Person> persons = Person.decode(response);
    _persons.value = persons;
  }

  @override
  void dispose() {
    _persons.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadPersons(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading data'));
        } else {
          return ValueListenableBuilder<List<Person>>(
            valueListenable: _persons,
            builder: (context, persons, _) {
              return ListView.builder(
                itemCount: persons.length,
                itemBuilder: (context, index) {
                  final person = persons[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      leading: CircleAvatar(
                        child: Text(person.name[0]),
                      ),
                      title: Text(
                        person.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Age: ${person.age}'),
                          Text('Phone: ${person.phoneNumber}'),
                          Text('Address: ${person.address}'),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        }
      },
    );
  }
}
