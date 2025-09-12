import 'package:flutter/material.dart';
import 'package:note_app/screens/note_list_screen.dart';

class NoteSplashScreen extends StatefulWidget {
  const NoteSplashScreen({super.key});

  @override
  State<NoteSplashScreen> createState() => _NoteSplashScreenState();
}

class _NoteSplashScreenState extends State<NoteSplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(
          context,
        ).pushReplacement(MaterialPageRoute(builder: (_) => NoteListScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("images/note.png", width: 100),
                SizedBox(height: 10),
                Text("  Notes", style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "Developed by Htet Ko Oo",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
