import 'package:hive/hive.dart';
import 'package:taskapp/NoteFeatures/data/noteModel.dart';
import 'package:taskapp/NoteFeatures/domain/entities/noteEntity.dart';
import 'package:taskapp/NoteFeatures/domain/noteIRepo.dart';

class NoteRepoImpl implements NoteIRepo {
  final String _noteBoxName = "note_box";

  Future<Box<NoteEntity>> _getBox() async {
    if (Hive.isBoxOpen(_noteBoxName)) return Hive.box(_noteBoxName);
    return await Hive.openBox(_noteBoxName);
  }

  @override
  Future<List<NoteEntity>> getNotes() async {
    final box = await _getBox();
    final notes = box.values.toList();
    return notes;
  }

  @override
  Future<void> deleteNote(String id) async {
    final box = await _getBox();
    await box.delete(id.toString());
  }

  @override
  Future<void> addNote(NoteEntity note) async {
    final box = await _getBox();
    final model = NoteModel.fromEntity(note);
    await box.put(model.id, model);
  }

  @override
  Future<void> updateNote(NoteEntity note) async {
    final box = await _getBox();
    final model = NoteModel.fromEntity(note);
    await box.put(model.id, model);
  }

  @override
  Future<void> deleteAllNotes() async {
    final box = await _getBox();
    await box.clear(); // Kutunun içindeki her şeyi siler, kutuyu boşaltır.
  }
}
