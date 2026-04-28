import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskapp/NoteFeatures/data/noteRepoImpl.dart';
import 'package:taskapp/NoteFeatures/domain/entities/noteEntity.dart';
import 'package:taskapp/NoteFeatures/domain/noteIRepo.dart';
import 'package:taskapp/NoteFeatures/domain/usecases/addNoteUseCase.dart';
import 'package:taskapp/NoteFeatures/domain/usecases/deleteAllUseCase.dart';
import 'package:taskapp/NoteFeatures/domain/usecases/deleteNoteUseCase.dart';
import 'package:taskapp/NoteFeatures/domain/usecases/getNotesUseCase.dart';
import 'package:taskapp/NoteFeatures/domain/usecases/updateUseCase.dart';

final noteProvider = Provider<NoteIRepo>((ref)=> NoteRepoImpl());

final notesFutureProvider = FutureProvider<List<NoteEntity>>((ref) async {
  final repo = ref.watch(noteProvider);
  return await repo.getNotes();
});

final getNotesUseCaseProvider = Provider((ref) => GetNoteUseCase(ref.watch(noteProvider)));
final addNoteUseCaseProvider = Provider((ref) => AddNoteUseCase(ref.watch(noteProvider)));
final updateNoteUseCaseProvider = Provider((ref) => UpdateUseCase(ref.watch(noteProvider)));
final deleteNoteUseCaseProvider = Provider((ref) => DeleteNoteUseCase(ref.watch(noteProvider)));
final deleteAllUseCaseProvider = Provider((ref) => DeleteAllUseCase(ref.watch(noteProvider)));