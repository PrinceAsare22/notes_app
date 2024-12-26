import 'package:flutter/material.dart';
import 'package:notes_app/components/notes/notes_card.dart';
import 'package:notes_app/models/note.dart';

class NotesGrid extends StatelessWidget {
  const NotesGrid({
    required this.notes,
    super.key,
  });

  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: notes.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
        ),
        clipBehavior: Clip.hardEdge,
        itemBuilder: (context, int index) {
          return NotesCard(
            note: notes[index],
            isInGrid: true,
          );
        });
  }
}
