import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';

enum OrderOption { dateCreated, dateModified, title }

class NotesProvider with ChangeNotifier {
  List<Note> _notes = [];
  String _searchTerm = '';
  bool _isGrid = true;
  OrderOption _orderBy = OrderOption.dateCreated;
  bool _isDescending = true;

  List<Note> get notes {
    List<Note> filteredNotes = _notes;
    if (_searchTerm.isNotEmpty) {
      final lowerCaseSearchTerm = _searchTerm.toLowerCase();
      filteredNotes = filteredNotes
          .where((note) =>
              (note.title?.toLowerCase().contains(lowerCaseSearchTerm) ??
                  false) ||
              (note.content?.toLowerCase().contains(lowerCaseSearchTerm) ??
                  false))
          .toList();
    }

    switch (_orderBy) {
      case OrderOption.dateCreated:
        filteredNotes.sort((a, b) => _isDescending
            ? b.dateCreated.compareTo(a.dateCreated)
            : a.dateCreated.compareTo(b.dateCreated));
        break;
      case OrderOption.dateModified:
        filteredNotes.sort((a, b) => _isDescending
            ? b.dateModified.compareTo(a.dateModified)
            : a.dateModified.compareTo(b.dateModified));
        break;
      case OrderOption.title:
        filteredNotes.sort((a, b) => _isDescending
            ? (b.title ?? '').compareTo(a.title ?? '')
            : (a.title ?? '').compareTo(b.title ?? ''));
        break;
    }

    return filteredNotes;
  }

  String get searchTerm => _searchTerm;
  bool get isGrid => _isGrid;
  OrderOption get orderBy => _orderBy;
  bool get isDescending => _isDescending;

  void setNotes(List<Note> notes) {
    _notes = notes;
    notifyListeners();
  }

  void setSearchTerm(String searchTerm) {
    _searchTerm = searchTerm;
    notifyListeners();
  }

  void toggleView() {
    _isGrid = !_isGrid;
    notifyListeners();
  }

  void setOrderBy(OrderOption orderBy) {
    _orderBy = orderBy;
    _saveOrderSettings();
    notifyListeners();
  }

  void toggleDescending() {
    _isDescending = !_isDescending;
    _saveOrderSettings();
    notifyListeners();
  }

  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void updateNote(Note updatedNote) {
    final index = _notes.indexWhere((note) => note.id == updatedNote.id);
    if (index != -1) {
      _notes[index] = updatedNote;
      notifyListeners();
    }
  }

  void deleteNote(String noteId) {
    _notes.removeWhere((note) => note.id == noteId);
    notifyListeners();
  }

  Future<void> _saveOrderSettings() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'orderBy': _orderBy.toString(),
        'isDescending': _isDescending,
      }, SetOptions(merge: true));
    }
  }

  Future<void> loadOrderSettings() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (doc.exists) {
        final data = doc.data();
        if (data != null) {
          _orderBy = OrderOption.values.firstWhere(
              (e) => e.toString() == data['orderBy'],
              orElse: () => OrderOption.dateCreated);
          _isDescending = data['isDescending'] ?? true;
          // Delay the notification to avoid calling during build
          WidgetsBinding.instance.addPostFrameCallback((_) {
            notifyListeners();
          });
        }
      }
    }
  }
}
