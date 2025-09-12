import 'package:flutter/material.dart';
import 'package:note_app/model/note.dart';
import 'package:note_app/provider/service_provider.dart';
import 'package:note_app/provider/theme_provider.dart';
import 'package:note_app/screens/splash_screen.dart';
import 'package:note_app/service/theme_service.dart';
import 'package:note_app/service/note_service.dart';
import 'package:note_app/theme/note_theme.dart';
import 'package:realm/realm.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeMode = await ThemeService.getThemeMode();
  runApp(NoteApp(themeMode: themeMode));
}

class NoteApp extends StatefulWidget {
  const NoteApp({super.key, required this.themeMode});

  final ThemeMode themeMode;

  @override
  State<NoteApp> createState() => _NoteAppState();
}

class _NoteAppState extends State<NoteApp> {
  late final Realm _realm;
  late final NoteService noteService;

  late ThemeMode _themeMode = widget.themeMode;

  @override
  void initState() {
    super.initState();
    var config = Configuration.local([Note.schema]);
    _realm = Realm(config);
    noteService = NoteService(_realm);
  }

  @override
  void dispose() {
    _realm.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ServiceProvider(
      noteService: noteService,
      child: ThemeProvider(
        themeMode: _themeMode,
        changeTheme: () async {
          setState(() {
            if (_themeMode == ThemeMode.light) {
              _themeMode = ThemeMode.dark;
            } else {
              _themeMode = ThemeMode.light;
            }
          });
          await ThemeService.setThemeMode(_themeMode);
        },
        child: MaterialApp(
          title: "MyNote",
          debugShowCheckedModeBanner: false,
          home: NoteSplashScreen(),
          theme: NoteTheme.lightTheme(),
          darkTheme: NoteTheme.darkTheme(),
          themeMode: _themeMode,
        ),
      ),
    );
  }
}
