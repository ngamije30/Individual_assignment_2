import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/models/note.dart';
import '../cubit/notes_cubit.dart';

class NotesScreen extends StatelessWidget {
  final VoidCallback onLogout;
  const NotesScreen({super.key, required this.onLogout});

  void _showNoteDialog(BuildContext context, {Note? note}) {
    final controller = TextEditingController(text: note?.text ?? '');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(note == null ? 'Add Note' : 'Edit Note'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Enter note'),
          minLines: 1,
          maxLines: 5,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final text = controller.text.trim();
              if (text.isNotEmpty) {
                if (note == null) {
                  context.read<NotesCubit>().addNote(text);
                } else {
                  context.read<NotesCubit>().updateNote(note.id, text);
                }
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, Note note) {
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
          ElevatedButton(
            onPressed: () {
              context.read<NotesCubit>().deleteNote(note.id);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: onLogout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: BlocConsumer<NotesCubit, NotesState>(
        listener: (context, state) {
          if (state is NotesError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          if (state is NotesLoading || state is NotesInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NotesLoaded) {
            final notes = state.notes;
            if (notes.isEmpty) {
              return const Center(
                child: Text(
                  'Nothing here yet—tap ➕ to add a note.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notes.length,
              itemBuilder: (context, i) {
                final note = notes[i];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(note.text),
                    subtitle: Text('Last edited: ${note.updatedAt}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _showNoteDialog(context, note: note),
                          tooltip: 'Edit',
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _confirmDelete(context, note),
                          tooltip: 'Delete',
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('Something went wrong.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showNoteDialog(context),
        tooltip: 'Add Note',
        child: const Icon(Icons.add),
      ),
    );
  }
} 