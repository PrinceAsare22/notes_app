import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:notes_app/services/note_service.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final NotesService notesService = NotesService();

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      return const Scaffold(
        body: Center(child: Text('Please log in to view your notes')),
      );
    }

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
              ),
            ),
          );
        },
      ),
      body: Column(
        children: [
          const MySearchField(), // Search field at the top
          Expanded(
            child: StreamBuilder<List<Note>>(
              stream: notesService.getUserNotes(userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.amber),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'An error occurred: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                final notes = snapshot.data ?? [];

                if (notes.isEmpty) {
                  return const NoNote();
                }

                final isGrid = context.watch<NotesProvider>().isGrid;

                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const ViewOptions(), // View options (Grid/List toggle)
                      Expanded(
                        child: isGrid
                            ? NotesGrid(notes: notes)
                            : NotesList(notes: notes),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
