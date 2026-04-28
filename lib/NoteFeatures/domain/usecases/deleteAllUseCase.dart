import 'package:flutter/material.dart';
import 'package:taskapp/NoteFeatures/domain/entities/noteEntity.dart';
import 'package:taskapp/NoteFeatures/domain/noteIRepo.dart';

class DeleteAllUseCase {
  final NoteIRepo repo;

  DeleteAllUseCase(this.repo);

  Future<void> call()async {
    return await repo.deleteAllNotes();
  }
}
