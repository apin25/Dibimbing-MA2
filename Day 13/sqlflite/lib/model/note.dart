class Note {
  int? noteId; 
  String title;
  String content;
  DateTime createdAt;
  DateTime? updatedAt; 
  
  int pinned;

  Note({
    this.noteId, 
    required this.title,
    required this.content,
    required this.createdAt,
    this.updatedAt, 
    this.pinned = 0, 
  });

  Map<String, dynamic> toJson() {
    return {
      'note_id': noteId, 
      'title': title,
      'content': content,
      'created_at': createdAt.toIso8601String(), 
      'updated_at': updatedAt?.toIso8601String(), 
      'pinned': pinned,
    };
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      noteId: json['note_id'] as int?, 
      title: json['title'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['created_at'] as String), 
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at'] as String) 
          : null, 
      pinned: json['pinned'] as int? ?? 0,
    );
  }
}