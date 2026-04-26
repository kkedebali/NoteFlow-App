import 'package:taskapp/NoteFeatures/domain/entities/noteEntity.dart';
import 'package:taskapp/NoteFeatures/domain/noteIRepo.dart';

class GetNoteUseCase{
  final NoteIRepo noteIRepo;
  GetNoteUseCase(this.noteIRepo);

  Future<List<NoteEntity>> call() async{
    return await noteIRepo.getNotes();
  }
}