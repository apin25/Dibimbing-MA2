import 'package:flutter/material.dart';

abstract class TaskStatus {
  Widget getIcon();
  String get title;
}

class DoneStatus extends TaskStatus {
  
  @override
  final String title;
  DoneStatus(this.title);

  @override
  Widget getIcon() => const Icon(Icons.check, color: Colors.green);
}

class PendingStatus extends TaskStatus {

  @override
  final String title;
  PendingStatus(this.title);

  @override
  Widget getIcon() => const Icon(Icons.hourglass_empty, color: Colors.orange);
}

class TaskItemOCP extends StatelessWidget {
  final TaskStatus status;

  const TaskItemOCP({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: status.getIcon(),
      title: Text(status.title),
    );
  }
}

