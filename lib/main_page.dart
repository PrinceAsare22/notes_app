import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_app/change_notifiers/new_note_controller.dart';
import 'package:notes_app/change_notifiers/notes_provider.dart';
import 'package:notes_app/components/buttons/floating_action_button.dart';
import 'package:notes_app/components/buttons/icon_button_outlined.dart';
import 'package:notes_app/components/dialog/dialogs.dart';
import 'package:notes_app/components/my_search_field.dart';
import 'package:notes_app/components/notes/no_notes.dart';
import 'package:notes_app/components/notes/notes_grid.dart';
import 'package:notes_app/components/notes/notes_list.dart';
import 'package:notes_app/components/view_options.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/pages/new_or_edit_note_page.dart';
import 'package:notes_app/services/auth_services.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          IconButtonOutlined(
            onPressed: () async {
              final bool shouldLogout = await showConfirmationDialog(
                      context: context,
                      title: 'Do you want to sign out of the app?') ??
                  false;
              if (shouldLogout) AuthServices.logout();
            },
            icon: FontAwesomeIcons.rightFromBracket,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButtonWidget(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                        create: (context) => NewNoteController(),
                        child: const NewOrEditNotePage(
                          isNewNote: true,
                        ),
                      )));
        },
      ),
      body: Consumer<NotesProvider>(
        builder: (context, notesProvider, child) {
          final List<Note> notes = notesProvider.notes;
          return notes.isEmpty && notesProvider.searchTerm.isEmpty
              ? const NoNote()
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const MySearchField(),
                      if (notes.isNotEmpty) ...[
                        const ViewOptions(),
                        Expanded(
                          child: notesProvider.isGrid
                              ? NotesGrid(notes: notes)
                              : NotesList(notes: notes),
                        ),
                      ] else
                        const Expanded(
                          child: Center(
                            child: Text(
                              'No notes found for your search query!',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                    ],
                  ),
                );
        },
      ),
    );
  }
}
