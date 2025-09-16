import 'package:flutter/material.dart';
import 'package:note_app/model/note.dart';
import 'package:note_app/provider/service_provider.dart';
import 'package:note_app/screens/note_editor_screen.dart';
import 'package:note_app/screens/note_search.dart';
import 'package:note_app/service/note_service.dart';
import 'package:note_app/provider/theme_provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({super.key});

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  bool _showFavoritesOnly = false;

  @override
  Widget build(BuildContext context) {
    final NoteService noteService = ServiceProvider.of(context)!.noteService;
    return Scaffold(
      appBar: AppBar(
        title: Text(_showFavoritesOnly ? "Favorites" : "Notes"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _showFavoritesOnly = !_showFavoritesOnly;
              });
            },
            icon: Icon(
              _showFavoritesOnly ? Icons.favorite : Icons.favorite_border,
            ),
          ),
          IconButton(
            onPressed: () {
              ThemeProvider.of(context)!.changeTheme();
            },
            icon: Icon(Icons.light_mode),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => NoteSearch()));
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _showFavoritesOnly
            ? noteService.getAllFavoriteNotes()
            : noteService.getAllNotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final notes = snapshot.data?.results;
          if (notes == null || notes.isEmpty) {
            return const Center(child: Text("No notes found"));
          }

          return GridView.custom(
            padding: EdgeInsets.all(16),
            gridDelegate: SliverQuiltedGridDelegate(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              repeatPattern: QuiltedGridRepeatPattern.same,
              pattern: [
                const QuiltedGridTile(1, 1),
                const QuiltedGridTile(1, 1),
                const QuiltedGridTile(1, 2),
              ],
            ),
            childrenDelegate: SliverChildBuilderDelegate(
              childCount: notes.length,
              (context, index) => NoteCard(
                note: notes[index],
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => NoteEditorScreen(note: notes[index]),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => NoteEditorScreen()));
        },
        shape: OvalBorder(),
        child: Icon(Icons.add),
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  const NoteCard({super.key, required this.note, required this.onTap});

  final Note note;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final NoteService noteService = ServiceProvider.of(context)!.noteService;
    return InkWell(
      splashColor: Colors.black54,
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Ink(
        decoration: BoxDecoration(
          color: Color(note.color),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              note.title,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat.yMMMd().format(note.created),
                  style: TextStyle(color: Colors.black),
                ),
                GestureDetector(
                  onTap: () {
                    noteService.toggleFavoriteStatus(note);
                  },
                  child: Icon(
                    note.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: note.isFavorite ? Colors.yellow.shade800 : Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}