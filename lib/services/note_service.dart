import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app/models/note.dart';

class NotesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create a new note
  Future<String> firebasecreateNote({
    required String userId,
    required String title,
    required String content,
    required List<String> tags,
  }) async {
    final now = DateTime.now();
    final noteData = Note(
      id: '', // Will be set after creation
      userId: userId,
      title: title,
      content: content,
      contentJson: content, // Assuming content is already in JSON format
      tags: tags,
      dateCreated: now.millisecondsSinceEpoch,
      dateModified: now.millisecondsSinceEpoch,
    ).toMap();

    final docRef = await _firestore.collection('notes').add(noteData);
    return docRef.id;
  }

  // Get all notes for a user
  Stream<List<Note>> getUserNotes(String userId) {
    return _firestore
        .collection('notes')
        .where('userId', isEqualTo: userId)
        .orderBy('dateModified', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Note.fromMap(doc.data(), doc.id))
            .toList());
  }

  // Update an existing note
  Future<void> firebaseupdateNote({
    required String noteId,
    required String title,
    required String content,
    required List<String> tags,
  }) async {
    await _firestore.collection('notes').doc(noteId).update({
      'title': title,
      'content': content,
      'tags': tags,
      'dateModified': DateTime.now().toIso8601String(),
      'dateCreated': DateTime.now().toIso8601String(),
    });
  }

  // Delete a note
  Future<void> firebasedeleteNote(String noteId) async {
    await _firestore.collection('notes').doc(noteId).delete();
  }
}
