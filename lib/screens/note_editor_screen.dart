import 'package:flutter/material.dart';
import 'package:note_app/constants/colors.dart';
import 'package:note_app/model/note.dart';
import 'package:note_app/provider/service_provider.dart';
import 'package:note_app/service/note_service.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({super.key, this.note});

  final Note? note;

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  late Color currentColor;
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;
  late DateTime currentDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title);
    _contentController = TextEditingController(text: widget.note?.content);
    currentDate = widget.note != null ? widget.note!.created : DateTime.now();
    currentColor =
        widget.note != null ? Color(widget.note!.color) : colors.first;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final NoteService noteService = ServiceProvider.of(context)!.noteService;
    return Scaffold(
      appBar: AppBar(
        title: Text("editor"),
        actions: [
          if (widget.note != null)
            IconButton(
              onPressed: () async {
                final result = await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Are you sure?"),
                    content: Text("Do you want to delete this note?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Text("OK"),
                      ),
                    ],
                  ),
                );
                if (result == true) {
                  noteService.deleteNote(widget.note!);
                  if(context.mounted){
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  }
                }
              },
              icon: Icon(Icons.delete),
            ),
          IconButton(
            onPressed: () {
              if (_titleController.text.trim().isNotEmpty &&
                  _contentController.text.trim().isNotEmpty) {
                late Note note;
                if (widget.note != null) {
                  //update
                  note = Note(
                    widget.note!.id,
                    _titleController.text.trim(),
                    _contentController.text.trim(),
                    DateTime.now(),
                    currentColor.value,
                    widget.note!.isFavorite,
                  );
                  noteService.updateNote(note);
                } else {
                  //add new
                  note = Note(
                    const Uuid().v4(),
                    _titleController.text.trim(),
                    _contentController.text.trim(),
                    DateTime.now(),
                    currentColor.value,
                    false,
                  );
                  noteService.addNote(note);
                }
                Navigator.of(context).popUntil((route) => route.isFirst);
              }
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _titleController,
                textInputAction: TextInputAction.next,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  border: InputBorder.none,
                  filled: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  DateFormat.yMMMd().format(currentDate),
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              TextField(
                controller: _contentController,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  hintText: "...",
                  filled: false,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: colors.length,
          itemBuilder:
              (context, index) => Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, bottom: 25),
                child: InkWell(
                  splashColor: Colors.black38,
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    setState(() {
                      currentColor = colors[index];
                    });
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: colors[index],
                    ),
                    width: 70,
                    child:
                        currentColor.value == colors[index].value
                            ? Icon(Icons.check)
                            : null,
                  ),
                ),
              ),
        ),
      ),
    );
  }
}