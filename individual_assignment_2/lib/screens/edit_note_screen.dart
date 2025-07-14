import 'package:flutter/material.dart';

class EditNoteScreen extends StatelessWidget {
  final String noteId;
  final String initialText;

  const EditNoteScreen({super.key, required this.noteId, required this.initialText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Note')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: TextEditingController(text: initialText),
              decoration: InputDecoration(
                labelText: 'Note Text',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Note: This screen is a placeholder
                // Editing is handled in dialogs in NotesListScreen
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
} 