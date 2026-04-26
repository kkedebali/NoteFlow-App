import 'package:taskapp/NoteFeatures/domain/entities/noteEntity.dart';

abstract class NoteIRepo{
  Future<List<NoteEntity>> getNotes();
  Future<void> addNote(NoteEntity note);
  Future<void> updateNote(NoteEntity note);
  Future<void> deleteNote(String id);
}