import 'package:flutter/material.dart';
import '../model/note.dart'; // sesuaikan path

class ListNote extends StatelessWidget {
  const ListNote({super.key});

  @override
  Widget build(BuildContext context) {
    // sementara dummy list
    List<Note> notes = [
      Note(
        title: "Contoh Note",
        content: "Ini catatan awal",
        createdAt: DateTime.now(),
      )
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Notes"),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];

          return Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(
                note.title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                note.content,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Icon(
                note.pinned == 1 ? Icons.push_pin : Icons.push_pin_outlined,
              ),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
