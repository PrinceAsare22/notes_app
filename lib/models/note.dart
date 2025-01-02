class Note {
  Note({
    required this.content,
    required this.title,
    required this.contentJson,
    required this.dateCreated,
    required this.dateModified,
    required this.tags,
    required this.id,
    required this.userId,
  });

  String id;
  String userId;
  final String? title;
  final String? content;
  final String? contentJson;
  final int dateCreated;
  final int dateModified;
  final List<String>? tags;

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'content': content,
      'contentJson': contentJson,
      'dateCreated': dateCreated,
      'dateModified': dateModified,
      'tags': tags,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map, String id) {
    return Note(
      id: id,
      userId: map['userId'] ?? '',
      title: map['title'],
      content: map['content'],
      contentJson: map['contentJson'],
      dateCreated: map['dateCreated'],
      dateModified: map['dateModified'],
      tags: List<String>.from(map['tags']),
    );
  }
}
