import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskapp/NoteFeatures/domain/entities/noteEntity.dart';
import 'package:taskapp/NoteFeatures/presentation/providers.dart';
import 'package:taskapp/NoteFeatures/presentation/screens/noteDetailsScreen.dart';
import 'package:uuid/uuid.dart';

class NoteFlowHome extends ConsumerStatefulWidget {
  const NoteFlowHome({super.key});

  @override
  ConsumerState<NoteFlowHome> createState() => _NoteFlowHomeState();
}

class _NoteFlowHomeState extends ConsumerState<NoteFlowHome> {
  late final TextEditingController contentController;
  late final TextEditingController headController;

  @override
  void initState() {
    super.initState();

    contentController = TextEditingController();
    headController = TextEditingController();
  }

  @override
  void dispose() {
    contentController.dispose();
    headController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final noteAsync = ref.watch(notesFutureProvider);

    void showSettModal() {
      showModalBottomSheet(
        context: context,

        builder: (context) {
          return Container(
            padding: EdgeInsets.all(20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Modalın tepesindeki o küçük çizgi (UX dokunuşu)
                Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () async {
                    await ref.read(deleteAllUseCaseProvider).call();

                    ref.invalidate(notesFutureProvider);

                    Navigator.pop(context);
                  },
                  child: Text(
                    'Tüm notları sil',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    void showAddNoteModal() {
      showModalBottomSheet(
        context: context,

        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: headController,

                  decoration: InputDecoration(
                    hintText: 'Başlık',
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
                ),
                TextField(
                  controller: contentController,
                  decoration: InputDecoration(
                    hintText: 'Notum',
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
                  maxLines: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        final newNote = NoteEntity(
                          id: Uuid().v4(),
                          title: headController.text.toString(),
                          content: contentController.text.toString(),
                          createdAt: DateTime.now(),
                          updatedAt: DateTime.now(),
                        );
                        await ref.read(addNoteUseCaseProvider).call(newNote);

                        ref.invalidate(notesFutureProvider);
                      } catch (e) {
                        print('Hata: $e');
                      } finally {
                        headController.text = "";
                        contentController.text = "";
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Kaydet'),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    void _goToDetails(NoteEntity note) {
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              NoteDetailScreen(note: note),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Sağa doğru genişleme ve kayma efekti için Slide ve Fade kombinasyonu
            return SlideTransition(
              position:
                  Tween<Offset>(
                    begin: const Offset(1.0, 0.0), // Sağdan başla
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves
                          .fastOutSlowIn, // Senin istediğin "hızlı uzama" hissi
                    ),
                  ),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 400), // Hız ayarı
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    GestureDetector(
                      onTap: () => showSettModal(),
                      child: const Text(
                        'NoteFlow',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showAddNoteModal();
                      },
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  child: noteAsync.when(
                    data: (notes) {
                      if (notes.isEmpty) {
                        return SizedBox(
                          child: Center(child: Text('Notlarınız boş')),
                        );
                      }
                      return ListView.builder(
                        // Listenin tamamını sol tarafa yaslamak için hizalama
                        padding: const EdgeInsets.only(right: 16.0),
                        itemCount: notes.length,
                        itemBuilder: (context, index) {
                          final note = notes[index];

                          return NoteCard(
                            note: note,
                            onTap: (note) {
                              _goToDetails(note);
                            },
                          );
                        },
                      );
                    },
                    error: (error, stackTrace) => Text('Hata: $error'),

                    loading: () => CircularProgressIndicator(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NoteCard extends StatefulWidget {
  final NoteEntity note;
  final Function(NoteEntity) onTap;

  // 'const' ve 'NoteCard' arasında boşluk olduğundan emin ol
  const NoteCard({super.key, required this.note, required this.onTap});

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  // Animasyon değişkenlerini buraya alıyoruz
  double _width = 100.0;
  bool _isExpanding = false;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () async {
          setState(() {
            _isExpanding = true;
            _width = MediaQuery.of(context).size.width;
          });

          await Future.delayed(const Duration(milliseconds: 300));

          // Ana sayfadaki navigasyon fonksiyonunu tetikler
          widget.onTap(widget.note);

          // Sayfadan geri dönüldüğünde kartı eski haline getirir
          if (mounted) {
            setState(() {
              _isExpanding = false;
              _width = 100.0;
            });
          }
        },
        child: Hero(
          tag: 'note_${widget.note.id}', // ID bazlı benzersiz tag
          child: Material(
            color: Colors.transparent,
            child: AnimatedContainer(
              margin: EdgeInsets.only(bottom: 10),
              duration: const Duration(milliseconds: 350),
              curve: Curves.fastOutSlowIn,
              constraints: BoxConstraints(
                maxWidth: _isExpanding
                    ? MediaQuery.of(context).size.width
                    : MediaQuery.of(context).size.width * 0.8,
                minWidth: _width,
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(10),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.note.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
