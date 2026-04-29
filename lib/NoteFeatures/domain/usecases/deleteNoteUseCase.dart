import 'package:taskapp/NoteFeatures/domain/entities/noteEntity.dart';
import 'package:taskapp/NoteFeatures/domain/noteIRepo.dart';

class DeleteNoteUseCase {
  final NoteIRepo noteIRepo;
  DeleteNoteUseCase(this.noteIRepo);

  Future<void> call(String id) async {
    
      await noteIRepo.deleteNote(id);
    
  }
}
