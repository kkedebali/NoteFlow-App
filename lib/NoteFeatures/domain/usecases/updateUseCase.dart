import 'package:taskapp/NoteFeatures/domain/entities/noteEntity.dart';
import 'package:taskapp/NoteFeatures/domain/noteIRepo.dart';

class UpdateUseCase {
  final NoteIRepo repo;
  UpdateUseCase(this.repo);

  Future<void> call(NoteEntity note) async {
    await repo.updateNote(note);
  }
}
