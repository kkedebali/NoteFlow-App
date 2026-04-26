import 'package:taskapp/NoteFeatures/domain/entities/noteEntity.dart';
import 'package:hive/hive.dart';

part 'noteModel.g.dart';

@HiveType(typeId: 0)
class NoteModel extends NoteEntity {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String content;
  @HiveField(3)
  final DateTime createdAt;
  @HiveField(4)
  final DateTime updatedAt;
  
  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  }) : super(
         id: id,
         title: title,
         content: content,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  factory NoteModel.fromEntity(NoteEntity note) {
    return NoteModel(
      id: note.id,
      title: note.title,
      content: note.content,
      createdAt: note.createdAt,
      updatedAt: note.updatedAt,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
