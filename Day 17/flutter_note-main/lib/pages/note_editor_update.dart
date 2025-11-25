import 'package:flutter/material.dart';
import 'package:flutter_note/firestore_helper.dart';
import 'package:flutter_note/models/note_model.dart';

class NoteEditorUpdate extends StatefulWidget {
  final NoteModel note;

  const NoteEditorUpdate({super.key, required this.note});

  @override
  State<NoteEditorUpdate> createState() => _NoteEditorUpdateState();
}

class _NoteEditorUpdateState extends State<NoteEditorUpdate> {
  final FirestoreHelper fsHelper = FirestoreHelper();

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _titleController.text = widget.note.title;
    _contentController.text = widget.note.content;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _saveNote() async {
    if (_formKey.currentState!.validate()) {
      final updatedNote = NoteModel(
        noteId: widget.note.noteId, // tetap pakai id lama
        title: _titleController.text,
        content: _contentController.text,
        createdAt: widget.note.createdAt, // createdAt tidak berubah
        updatedAt: DateTime.now().toIso8601String(),
        pinned: widget.note.pinned,
      );

      final result = await fsHelper.updateNote(updatedNote);

      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Note updated successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      

      Navigator.pop(context, true); // kirim sinyal "berhasil update"
    }
  }

  void _cancelNote() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Note'), elevation: 0),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a title' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _contentController,
                maxLines: 12,
                minLines: 8,
                decoration: const InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter content' : null,
              ),
              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _cancelNote,
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _saveNote,
                      child: const Text('Save'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}