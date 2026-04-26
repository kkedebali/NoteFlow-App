import 'package:hive/hive.dart';
import 'package:taskapp/NoteFeatures/data/noteModel.dart';
import 'package:taskapp/NoteFeatures/domain/entities/noteEntity.dart';
import 'package:taskapp/NoteFeatures/domain/noteIRepo.dart';

class NoteRepoImpl implements NoteIRepo {
  final String _noteBoxName = "note_box";

  @override
  Future<List<NoteEntity>> getNotes() async {
    final box = await Hive.openBox<NoteEntity>(_noteBoxName);
    final notes = box.values.toList();
    return notes;
  }

  @override
  Future<void> deleteNote(String id) async {
    final box = await Hive.openBox<NoteEntity>(_noteBoxName);
    await box.delete(id);
  }

  @override
  Future<void> addNote(NoteEntity note) async {
    final box = await Hive.openBox<NoteEntity>(_noteBoxName);
    final model = NoteModel.fromEntity(note);
    await box.add(model);
  }

  @override
  Future<void> updateNote(NoteEntity note) async {
    final box = await Hive.openBox<NoteEntity>(_noteBoxName);
    final model = NoteModel.fromEntity(note);
    await box.put(model.id, model);
  }
}
