import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/notes_repository.dart';

class NotesProvider extends ChangeNotifier {
  final NotesRepository _repo = NotesRepository();

  final String uid;
  bool isLoading = true;
  List<DocumentSnapshot> notes = [];

  NotesProvider(this.uid) {
    fetchNotes();
  }

  void fetchNotes() {
    _repo.fetchNotes(uid).listen((snapshot) {
      notes = snapshot.docs;
      isLoading = false;
      notifyListeners();
    });
  }

  Future<void> addNote(String text) async {
    await _repo.addNote(uid, text);
  }

  Future<void> updateNote(String id, String text) async {
    await _repo.updateNote(uid, id, text);
  }

  Future<void> deleteNote(String id) async {
    await _repo.deleteNote(uid, id);
  }
} 