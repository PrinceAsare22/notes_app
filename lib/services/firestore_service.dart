import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app/models/note.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveNote(Note note) async {
    try {
      await _firestore.collection('notes').doc().set(note.toMap());
    } catch (e) {
      print('Error saving note: $e');
    }
  }

  Stream<List<Note>> fetchNotes(String userId) {
    return FirebaseFirestore.instance
        .collection('notes')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              return Note.fromMap(doc.data(), doc.id);
            }).toList());
  }
}
