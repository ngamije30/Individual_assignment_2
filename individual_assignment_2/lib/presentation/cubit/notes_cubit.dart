import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/models/note.dart';
import '../../domain/repositories/notes_repository.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  final NotesRepository notesRepository;
  final String userId;
  NotesCubit({required this.notesRepository, required this.userId}) : super(NotesInitial()) {
    fetchNotes();
  }

  void fetchNotes() {
    emit(NotesLoading());
    notesRepository.notesStream(userId).listen((notes) {
      emit(NotesLoaded(notes));
    }, onError: (e) {
      emit(NotesError(e.toString()));
    });
  }

  Future<void> addNote(String text) async {
    try {
      await notesRepository.addNote(userId, text);
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> updateNote(String noteId, String text) async {
    try {
      await notesRepository.updateNote(userId, noteId, text);
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> deleteNote(String noteId) async {
    try {
      await notesRepository.deleteNote(userId, noteId);
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }
} 