import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_app/change_notifiers/new_note_controller.dart';
import 'package:notes_app/components/buttons/icon_button_outlined.dart';
import 'package:notes_app/components/buttons/note_back_button.dart';
import 'package:notes_app/components/dialog/dialogs.dart';
import 'package:notes_app/components/note_tool_bar.dart';
import 'package:notes_app/components/notes/note_metadata.dart';
import 'package:notes_app/constants.dart';
import 'package:provider/provider.dart';

class NewOrEditNotePage extends StatefulWidget {
  const NewOrEditNotePage({super.key, required this.isNewNote});

  final bool isNewNote;

  @override
  State<NewOrEditNotePage> createState() => _NewOrEditNotePageState();
}

class _NewOrEditNotePageState extends State<NewOrEditNotePage> {
  late final NewNoteController newNoteController;
  late final TextEditingController titleController;
  late final QuillController quillController;

  late final FocusNode focusNode;

  @override
  void initState() {
    super.initState();

    newNoteController = context.read<NewNoteController>();

    titleController = TextEditingController(text: newNoteController.title);
    quillController = QuillController.basic()
      ..addListener(() {
        newNoteController.content = quillController.document;
      });

    focusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.isNewNote) {
        focusNode.requestFocus();
        newNoteController.isEditorFocused = true;
      } else {
        quillController.document = newNoteController.content;
      }
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    quillController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void _toggleFocus() {
    setState(() {
      if (newNoteController.isEditorFocused) {
        focusNode.unfocus();
      } else {
        focusNode.requestFocus();
      }
      newNoteController.isEditorFocused = !newNoteController.isEditorFocused;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          if (!newNoteController.canSaveNote) {
            Navigator.pop(context);
            return;
          }

          final bool? shouldSave = await showConfirmationDialog(
              context: context, title: 'Do you want to save the note?');
          if (shouldSave == null) return;

          if (!context.mounted) return;

          if (shouldSave) {
            newNoteController.saveNote(context);
          }

          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: const Padding(
            padding: EdgeInsets.all(8.0),
            child: NoteBackButton(),
          ),
          title: Text(widget.isNewNote ? 'New Note' : 'Edit Note'),
          actions: [
            Selector<NewNoteController, bool>(
              selector: (context, newNoteController) =>
                  newNoteController.isEditorFocused,
              builder: (context, isEditorFocused, child) => IconButtonOutlined(
                icon: isEditorFocused
                    ? FontAwesomeIcons.bookOpen
                    : FontAwesomeIcons.pen,
                onPressed: _toggleFocus,
              ),
            ),
            Selector<NewNoteController, bool>(
              selector: (_, newNoteController) => newNoteController.canSaveNote,
              builder: (_, canSaveNote, __) => IconButtonOutlined(
                icon: FontAwesomeIcons.check,
                onPressed: canSaveNote
                    ? () async {
                        newNoteController.saveNote(context);
                        if (context.mounted) Navigator.pop(context);
                      }
                    : null,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                  hintText: 'Title here',
                  hintStyle: TextStyle(color: gray300),
                  border: InputBorder.none,
                ),
                onChanged: (newValue) {
                  newNoteController.title = newValue;
                },
              ),
              NoteMetadata(note: newNoteController.note),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(
                  color: gray500,
                  thickness: 2,
                ),
              ),
              Expanded(
                child: Selector<NewNoteController, bool>(
                  selector: (_, controller) => controller.isEditorFocused,
                  builder: (_, isEditorFocused, __) => Column(
                    children: [
                      Expanded(
                        child: QuillEditor(
                          configurations: const QuillEditorConfigurations(
                            expands: true,
                            placeholder: 'Note here...',
                          ),
                          controller: quillController,
                          focusNode: focusNode,
                          scrollController: ScrollController(),
                        ),
                      ),
                      if (isEditorFocused)
                        NoteToolBar(quillController: quillController),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
