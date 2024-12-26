import 'package:flutter/material.dart';
import 'package:notes_app/components/notes/notes_card.dart';
import 'package:notes_app/models/note.dart';

class NotesList extends StatelessWidget {
  const NotesList({
    super.key,
    required this.notes,
  });

  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: notes.length,
      clipBehavior: Clip.hardEdge,
      itemBuilder: (context, index) {
        return NotesCard(
          note: notes[index],
          isInGrid: false,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 8),
    );
  }
}
