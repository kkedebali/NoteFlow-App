import 'package:taskapp/NoteFeatures/domain/entities/noteEntity.dart';
import 'package:taskapp/NoteFeatures/domain/noteIRepo.dart';

class AddNoteUseCase {
  final NoteIRepo noteRepo;
  AddNoteUseCase(this.noteRepo);

  Future<NoteEntity> call(NoteEntity note) async {
    await noteRepo.addNote(note);
    return note;
  }
}
