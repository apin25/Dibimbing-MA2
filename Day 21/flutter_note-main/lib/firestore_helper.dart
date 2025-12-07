import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_note/data/models/note_model.dart';

class FirestoreHelper {
  // Helper: reference ke notes milik user saat ini
  CollectionReference<NoteModel> _userNoteRef() {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    return FirebaseFirestore.instance
        .collection('users_notes')
        .doc(uid)
        .collection('notes')
        .withConverter<NoteModel>(
          fromFirestore: (snapshot, _) =>
              NoteModel.fromJson(snapshot.data()!),
          toFirestore: (note, _) => note.toJson(),
        );
  }

  // CREATE
  Future<DocumentReference<NoteModel>> addNote(NoteModel note) async {
    final ref = _userNoteRef();
    final doc = await ref.add(note);

    // Update note_id field
    await ref.doc(doc.id).update({'note_id': doc.id});

    return doc;
  }

  // READ ALL
  Future<List<NoteModel>> fetchNotes() async {
    final ref = _userNoteRef();

    final querySnapshot = await ref
        .orderBy('created_at', descending: true)
        .get();

    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  // UPDATE
  Future<void> updateNote(NoteModel note) async {
    if (note.noteId == null) {
      throw ArgumentError('Note ID cannot be null for update operation.');
    }

    final ref = _userNoteRef();
    await ref.doc(note.noteId).set(note);
  }

  // DELETE
  Future<void> deleteNote(String noteId) async {
    final ref = _userNoteRef();
    await ref.doc(noteId).delete();
  }

  // STREAM
  Stream<QuerySnapshot<NoteModel>> getNoteStream() {
    final ref = _userNoteRef();
    return ref.orderBy('created_at', descending: true).snapshots();
  }
}
