import 'package:flutter/material.dart';
import 'package:notes_app/change_notifiers/notes_provider.dart';
import 'package:provider/provider.dart';

class NoNote extends StatelessWidget {
  const NoNote({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final filteredNotes = context.watch<NotesProvider>().notes;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (filteredNotes.isEmpty) ...{
            Image.asset(
              'assets/images/freepik__background__60557.png',
              width: MediaQuery.sizeOf(context).width * 0.95,
            )
          } else ...{
            Image.asset(
              'assets/images/freepik__background__60557.png',
              width: MediaQuery.sizeOf(context).width * 0.95,
            ),
            const Text(
              'You have no notes yet!\nCreate one by pressing the + button',
              style: TextStyle(
                fontFamily: 'Fredoka',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          }
        ],
      ),
    );
  }
}
