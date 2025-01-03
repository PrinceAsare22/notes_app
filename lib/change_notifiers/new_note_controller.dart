import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:notes_app/change_notifiers/notes_provider.dart';
import 'package:notes_app/models/note.dart';
import 'package:provider/provider.dart';

class NewNoteController extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Note? _note;
  set note(Note? value) {
    _note = value;
    _title = _note!.title ?? '';
    _content = Document.fromJson(jsonDecode(_note!.contentJson ?? '{}'));
    _tags.addAll(_note!.tags ?? []);
    notifyListeners();
  }

  Note? get note => _note;

  bool _isEditorFocused = false;
  set isEditorFocused(bool value) {
    _isEditorFocused = value;
    notifyListeners();
  }

  bool get isEditorFocused => _isEditorFocused;

  String _title = '';
  set title(String value) {
    _title = value;
    notifyListeners();
  }

  String get title => _title.trim();

  Document _content = Document();
  set content(Document value) {
    _content = value;
    notifyListeners();
  }

  Document get content => _content;

  final List<String> _tags = [];
  void addTag(String tag) {
    _tags.add(tag);
    notifyListeners();
  }

  List<String> get tags => [..._tags];

  void removeTag(int index) {
    _tags.removeAt(index);
    notifyListeners();
  }

  void updateTag(String tag, int index) {
    _tags[index] = tag;
    notifyListeners();
  }

  bool get isNewNote => _note == null;

  bool get canSaveNote {
    final String? newTitle = title.isNotEmpty ? title : null;
    final String? newContent = content.toPlainText().trim().isNotEmpty
        ? content.toPlainText().trim()
        : null;

    bool canSave = newTitle != null || newContent != null;

    if (!isNewNote) {
      final newContentJson = jsonEncode(content.toDelta().toJson());
      canSave = canSave &&
          (newTitle != note!.title ||
              newContentJson != note!.contentJson ||
              !listEquals(tags, note!.tags));
    }

    return canSave;
  }

  Future<void> saveNote(BuildContext context) async {
    try {
      final String userId = FirebaseAuth.instance.currentUser!.uid;
      final String contentJson = jsonEncode(content.toDelta().toJson());
      final int now = DateTime.now().microsecondsSinceEpoch;

      final Note note = Note(
        id: isNewNote ? '' : _note!.id,
        userId: userId,
        title: title.isNotEmpty ? title : null,
        content: content.toPlainText().trim().isNotEmpty
            ? content.toPlainText().trim()
            : null,
        contentJson: contentJson,
        dateCreated: isNewNote ? now : _note!.dateCreated,
        dateModified: now,
        tags: tags,
      );

      final notesProvider = context.read<NotesProvider>();

      final docRef = _firestore.collection('notes');

      if (isNewNote) {
        // Add new note
        final newDoc = await docRef.add({
          'userId': userId,
          'title': note.title,
          'content': note.content,
          'contentJson': note.contentJson,
          'dateCreated': note.dateCreated,
          'dateModified': note.dateModified,
          'tags': note.tags,
        });

        note.id = newDoc.id; // Assign generated ID
        notesProvider.addNote(note);
      } else {
        // Update existing note
        await docRef.doc(note.id).update({
          'title': note.title,
          'content': note.content,
          'contentJson': note.contentJson,
          'dateModified': note.dateModified,
          'tags': note.tags,
        });

        notesProvider.updateNote(note);
      }

      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save note: $e')),
      );
    }
  }

  Future<void> deleteNoteFromFirestore(BuildContext context) async {
    if (_note == null) return;

    try {
      final docRef = _firestore.collection('notes');
      final noteDoc = await docRef
          .where('dateCreated', isEqualTo: _note!.dateCreated)
          .get();

      if (noteDoc.docs.isNotEmpty) {
        await noteDoc.docs.first.reference.delete();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete note: $e')),
      );
    }
  }
}
