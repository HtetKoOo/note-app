import 'package:flutter/material.dart';
import 'package:note_app/model/note.dart';
import 'package:note_app/provider/service_provider.dart';
import 'package:note_app/screens/note_editor_screen.dart';
import 'package:note_app/screens/note_list_screen.dart';
import 'package:note_app/service/note_service.dart';

class NoteSearch extends StatefulWidget {
  const NoteSearch({super.key});

  @override
  State<NoteSearch> createState() => _NoteSearchState();
}

class _NoteSearchState extends State<NoteSearch> {
  List<Note> _noteList = [];

  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final NoteService noteService = ServiceProvider.of(context)!.noteService;
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          focusNode: _focusNode,
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Search",
            prefixIcon: Icon(Icons.search),
            suffixIcon: IconButton(
              onPressed: () {
                _controller.clear();
                _focusNode.unfocus();              },
              icon: Icon(Icons.close, color: Colors.grey.shade500),
            ),
          ),
          onEditingComplete: () {
            setState(() {
              _noteList.clear();
              _noteList.addAll(noteService.searchNote(_controller.text.trim()));
            });
          },
        ),
      ),
      body:
          _noteList.isEmpty
              ? Center(child: Text("no result found"))
              : ListView.separated(
                padding: EdgeInsets.all(16),
                itemCount: _noteList.length,
                separatorBuilder:
                    (context, index) => const SizedBox(height: 16),
                itemBuilder:
                    (context, index) => NoteCard(
                      note: _noteList[index],
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder:
                                (_) => NoteEditorScreen(note: _noteList[index]),
                          ),
                        );
                      },
                    ),
              ),
    );
  }
}
