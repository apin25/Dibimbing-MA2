import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_note/models/note_model.dart';

class FirestoreHelper {
  final notesRef = FirebaseFirestore.instance
      .collection('notes')
      .withConverter<NoteModel>(
        fromFirestore: (snapshots, _) =>
            NoteModel.fromJson(snapshots.data()!),
        toFirestore: (note, _) => note.toJson(),
      );

  Future<DocumentReference<NoteModel>> addNote(NoteModel note) async {
    final doc = await notesRef.add(note);

    final noteRefUpdated = notesRef.doc(doc.id);
    //noteRefUpdated.set(note..noteId = doc.id);
    noteRefUpdated.update({'note_id': doc.id});

    // result.update({'note_id': result.id});
    return doc;
  }

  Future removeNote(int noteId) async {
    await notesRef.doc(noteId.toString()).delete();
  }

  Future<bool> isFavourite(int noteId) async {
    final result = await notesRef.doc(noteId.toString()).get();
    return result.exists;
  }

  Future<List<NoteModel>> getAllNotes() async {
    final dataSnapshot = await notesRef.get();
    final debug = dataSnapshot.docs.map((doc) => doc.data()).toList();
    print(debug);
    return dataSnapshot.docs.map((doc) => doc.data()).toList();
  }

  Stream<QuerySnapshot> getAllNotesRealTime() {
    return notesRef.snapshots();
  }

  Future<void> updateNote(NoteModel note) async {
    if (note.noteId == null) {
      throw ArgumentError('Note ID cannot be null for update operation.');
    }
    final docRef = notesRef.doc(note.noteId);
    await docRef.set(note);
  }
  Future<void> deleteNote(String noteId) async {
    final docRef = notesRef.doc(noteId);
    await docRef.delete();
  }
}