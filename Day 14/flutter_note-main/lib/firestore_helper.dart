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

  Future addNote(NoteModel note) async {
    final docRef = notesRef.doc(); 
    note.noteId = docRef.id;
    await docRef.set(note);
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

  //For real-time favourite note list
  Stream<QuerySnapshot> getAllNotesRealTime() {
    return notesRef.snapshots();
  }
}