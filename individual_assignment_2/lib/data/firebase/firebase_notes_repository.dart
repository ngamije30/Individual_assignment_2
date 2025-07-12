import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/note.dart';
import '../../domain/repositories/notes_repository.dart';

class FirebaseNotesRepository implements NotesRepository {
  final _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<Note>> notesStream(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('notes')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              return Note(
                id: doc.id,
                text: data['text'] ?? '',
                createdAt: (data['createdAt'] as Timestamp).toDate(),
                updatedAt: (data['updatedAt'] as Timestamp).toDate(),
              );
            }).toList());
  }

  @override
  Future<void> addNote(String userId, String text) async {
    final now = DateTime.now();
    await _firestore.collection('users').doc(userId).collection('notes').add({
      'text': text,
      'createdAt': now,
      'updatedAt': now,
    });
  }

  @override
  Future<void> updateNote(String userId, String noteId, String text) async {
    final now = DateTime.now();
    await _firestore.collection('users').doc(userId).collection('notes').doc(noteId).update({
      'text': text,
      'updatedAt': now,
    });
  }

  @override
  Future<void> deleteNote(String userId, String noteId) async {
    await _firestore.collection('users').doc(userId).collection('notes').doc(noteId).delete();
  }
} 