import 'package:flutter/material.dart';
import '../model/note.dart';

class AddNNote extends StatefulWidget {
  const AddNNote({super.key});

  @override
  State<AddNNote> createState() => _AddNNoteState();
}

class _AddNNoteState extends State<AddNNote> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  void _saveNote() {
    if (_titleController.text.isEmpty || _contentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Title dan content tidak boleh kosong")),
      );
      return;
    }

    Note newNote = Note(
      title: _titleController.text,
      content: _contentController.text,
      createdAt: DateTime.now(),
      pinned: 0,
    );

    Navigator.pop(context, newNote); // kirim balik note ke halaman sebelumnya
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Note"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: "Title",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                TextField(
                  controller: _contentController,
                  maxLines: 6,
                  decoration: const InputDecoration(
                    labelText: "Content",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveNote,
                    child: const Text("Save Note"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
