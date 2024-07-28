import 'package:flutter/material.dart';

import '../widgets/persons_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Flutter JSON Example'),
      ),
      body: const PersonList(),
    );
  }
}
