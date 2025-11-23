import 'package:flutter/material.dart';
import 'package:flutter_note/db_helper.dart';
import 'package:flutter_note/firestore_helper.dart';
import 'package:flutter_note/models/note_model.dart';
import 'package:flutter_note/pages/note_editor_page.dart';
import 'package:flutter_note/pages/note_editor_update.dart';

class NoteHomePage extends StatefulWidget {
  const NoteHomePage({super.key});

  @override
  State<NoteHomePage> createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteHomePage> {
  // final DbHelper dbHelper = DbHelper.instance;
  final FirestoreHelper fsHelper = FirestoreHelper();

  List<NoteModel> _notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    // TODO: Load notes from database
    // Simulating database with sample data
    final noteList = await fsHelper.getAllNotes();

    setState(() {
      _notes = noteList;
    });
  }

  void _navigateToCreateNote() async {
    // Navigate to create note page
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NoteEditorPage()),
    );

    // Reload notes after returning from create page
    if (result != null) {
    }
  }

  void _navigateToEditNote(NoteModel note) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteEditorUpdate(note: note),
      ),
    );
  }

  void _deleteNote(String noteId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Note'),
        content: const Text('Are you sure you want to delete this note?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Delete from database
              setState(() {
                fsHelper.deleteNote(noteId.toString());
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Note deleted')));
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Notes'), elevation: 0),
      body: StreamBuilder(
      stream: fsHelper.getAllNotesRealTime(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return _buildEmptyState();
        }

        final notes = snapshot.data!.docs
            .map((doc) => doc.data() as NoteModel)
            .toList();

        return _buildStreamNoteList(notes);
      },
    ),

    floatingActionButton: FloatingActionButton(
    onPressed: _navigateToCreateNote,
    tooltip: 'Create new note',
    child: const Icon(Icons.add),
  ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.note_add_outlined, size: 100, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No notes yet',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the + button to create your first note',
            style: TextStyle(fontSize: 16, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
Widget _buildStreamNoteList(List<NoteModel> notes) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            title: Text(
              note.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                _formatDate(DateTime.parse(note.createdAt)),
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            onTap: () => _navigateToEditNote(note),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteNote(note.noteId.toString()),
            ),
          ),
        );
      },
    );
  }
}