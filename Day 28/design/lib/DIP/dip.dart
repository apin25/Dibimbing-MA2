import 'package:flutter/material.dart';

class TaskPageDipAnti extends StatelessWidget {
  final InMemoryTaskRepository repo = InMemoryTaskRepository(); 

  TaskPageDipAnti({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = repo.getAll();

    return Scaffold(
      appBar: AppBar(title: const Text("Tasks")),
      body: ListView(
        children: tasks.map((t) => ListTile(title: Text(t))).toList(),
      ),
    );
  }
}

class InMemoryTaskRepository {
  final List<String> _tasks = ["Belajar Flutter", "Belajar DIP"];

  List<String> getAll() => _tasks;
}
