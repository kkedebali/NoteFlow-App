import 'package:flutter/material.dart';

class NoteFlowHome extends StatefulWidget {
  const NoteFlowHome({super.key});

  @override
  State<NoteFlowHome> createState() => _NoteFlowHomeState();
}

class _NoteFlowHomeState extends State<NoteFlowHome> {
  //
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
                decoration: InputDecoration(
                  hintText: 'Başlık',
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                ),
              ),
              TextField(
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
                  onPressed: () async {},
                  child: Text('Kaydet'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                    const Text(
                      'NoteFlow',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
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
              Expanded(child: Center(child: Text("NoteFlow Gelecek Riverpod"))),
            ],
          ),
        ),
      ),
    );
  }
}
