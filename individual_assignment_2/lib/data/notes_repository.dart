import 'package:cloud_firestore/cloud_firestore.dart';

class NotesRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> fetchNotes(String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('notes')
        .snapshots();
  }

  Future<void> addNote(String uid, String text) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('notes')
        .add({'text': text});
  }

  Future<void> updateNote(String uid, String noteId, String text) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('notes')
        .doc(noteId)
        .update({'text': text});
  }

  Future<void> deleteNote(String uid, String noteId) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('notes')
        .doc(noteId)
        .delete();
  }
} 