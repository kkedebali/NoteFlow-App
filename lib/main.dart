import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskapp/NoteFeatures/data/noteModel.dart';
import 'package:taskapp/NoteFeatures/presentation/providers.dart';
import 'package:taskapp/NoteFeatures/presentation/screens/home.dart';

void main() {
  Hive.initFlutter();
  Hive.registerAdapter(NoteModelAdapter());

  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeM = ref.watch(themeProvider);
    return MaterialApp(
      themeMode: themeM,
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
        cardColor: Colors.blue,
        hintColor: Colors.black54,

      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        cardColor: const Color(0xFF1665A7),

        
        scaffoldBackgroundColor: const Color(0xFF1F1F1F),

        primaryColor: Colors.blue,
        hintColor: Colors.grey,
        
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),

        ),

        iconTheme: const IconThemeData(color: Colors.blueAccent),
        
      ),
      debugShowCheckedModeBanner: false,
      home: NoteFlowHome(),
    );
  }
}
