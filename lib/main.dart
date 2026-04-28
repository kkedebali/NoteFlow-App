import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskapp/NoteFeatures/data/noteModel.dart';
import 'package:taskapp/NoteFeatures/presentation/screens/home.dart';

void main() {
  Hive.initFlutter();
  Hive.registerAdapter(NoteModelAdapter());

  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NoteFlowHome(),
    );
  }
}
