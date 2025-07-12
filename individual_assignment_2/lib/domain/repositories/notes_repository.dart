import '../models/note.dart';

abstract class NotesRepository {
  Stream<List<Note>> notesStream(String userId);
  Future<void> addNote(String userId, String text);
  Future<void> updateNote(String userId, String noteId, String text);
  Future<void> deleteNote(String userId, String noteId);
} 