import 'package:flutter/material.dart';
import 'package:note_app/service/note_service.dart';
class ServiceProvider extends InheritedWidget {
  const ServiceProvider({
    super.key,
    required this.child,
    required this.noteService,
  }) : super(child: child);

  @override
  // ignore: overridden_fields
  final Widget child;
  final NoteService noteService;

  static ServiceProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ServiceProvider>();
  }

  @override
  bool updateShouldNotify(ServiceProvider oldWidget) {
    return false;
  }
}
