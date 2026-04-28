import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskapp/NoteFeatures/domain/entities/noteEntity.dart';
import 'package:taskapp/NoteFeatures/presentation/providers.dart';

class NoteDetailScreen extends ConsumerStatefulWidget {
  final NoteEntity note;
  const NoteDetailScreen({super.key, required this.note});

  @override
  ConsumerState<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends ConsumerState<NoteDetailScreen> {
  late TextEditingController contentController;
  late TextEditingController titleController;
  bool _isDeleted = false;

  @override
  void initState() {
    super.initState();
    // Controller'ları burada başlatıyoruz ki build oldukça sıfırlanmasınlar
    contentController = TextEditingController(text: widget.note.content);
    titleController = TextEditingController(text: widget.note.title);
  }

  @override
  void dispose() {
    contentController.dispose();
    titleController.dispose();
    super.dispose();
  }

  Future<void> _saveNote() async {
    final updatedNote = NoteEntity(
      id: widget.note.id,
      title: titleController.text,
      content: contentController.text,
      createdAt: widget.note.createdAt,
      updatedAt: DateTime.now(),
    );

    await ref.read(updateNoteUseCaseProvider).call(updatedNote);
    ref.invalidate(notesFutureProvider);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true, // Sistem geri tuşuna izin ver
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          // Sayfa kapanırken sessizce kaydet
          if (!_isDeleted) {
            await _saveNote();
          }
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(
          context,
        ).cardColor, // Apple tarzı beyaz arka plan
        appBar: AppBar(
          backgroundColor: Theme.of(context).cardColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.maybePop(context), // Güvenli çıkış
          ),
          actions: [
            IconButton(
              onPressed: () => _showModalSettings(),
              icon: const Icon(Icons.more_horiz, color: Colors.white),
            ),
          ],
        ),
        body: Column(
          children: [
            // Başlık TextField (Görünmez)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: titleController,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Başlık',
                ),
              ),
            ),

            // İçerik TextField (Görünmez ve Tam Ekran)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Hero(
                  tag: 'note_${widget.note.id}',
                  child: Material(
                    color: Colors.transparent,
                    child: TextField(
                      controller: contentController,
                      maxLines: null,
                      expands: true,
                      textAlignVertical: TextAlignVertical.top,
                      style: const TextStyle(fontSize: 18),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Not yazmaya başlayın...',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showModalSettings() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text(
                'Notu Sil',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () async {
                _isDeleted = true;
                await ref.read(deleteNoteUseCaseProvider).call(widget.note.id);

                ref.invalidate(notesFutureProvider);
                Navigator.pop(context); // Modal kapat
                Navigator.pop(context); // Sayfa kapat
              },
            ),
          ],
        ),
      ),
    );
  }
}
