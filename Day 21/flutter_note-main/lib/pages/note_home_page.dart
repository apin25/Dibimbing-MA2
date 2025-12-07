import 'package:flutter/material.dart';
import 'package:flutter_note/firestore_helper.dart';
import 'package:flutter_note/data/models/note_model.dart';
import 'package:flutter_note/pages/note_editor_page.dart';
import 'package:flutter_note/pages/note_editor_update.dart';
import 'package:flutter_note/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NoteHomePage extends ConsumerStatefulWidget {
  const NoteHomePage({super.key});

  @override
  ConsumerState<NoteHomePage> createState() => _NoteListPageState();
}

class _NoteListPageState extends ConsumerState<NoteHomePage> {
  // final DbHelper dbHelper = DbHelper.instance;
  final FirestoreHelper fsHelper = FirestoreHelper();

  List<NoteModel> _notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final noteList = await fsHelper.fetchNotes();

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
      appBar: AppBar(
        title: const Text('My Notes'),
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          Consumer(
            builder: (context, ref, _) {
              final authState = ref.watch(authStateChangesProvider);

              return authState.when(
                data: (user) {
                  if (user == null) return const SizedBox();
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Center(
                      child: Text(
                        user.email ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
                loading: () => const SizedBox(),
                error: (_, __) => const SizedBox(),
              );
            },
          ),

          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              await ref.read(authNotifierProvider.notifier).logout();
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/signin',
                (route) => false,
              );
            },
          ),
        ],
      ),

      body: StreamBuilder(
      stream: fsHelper.getNoteStream(),
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