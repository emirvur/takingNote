import 'package:flutter/material.dart';
import 'package:tea/models/note.dart';
import 'package:tea/view/MainScreen.dart';
import 'package:tea/view/addNote.dart';
import 'package:tea/view/noteDetail.dart';

class AppRoute {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        {
          return MaterialPageRoute(builder: (_) => const MainScreen());
        }
      case addnote:
        {
          return MaterialPageRoute(builder: (_) => AddNote());
        }
      case notedetail:
        {
          final note = settings.arguments as Note;
          print("note case" + note.noteTitle);
          return MaterialPageRoute(builder: (_) => NoteDetail(note));
        }
      default:
        throw 'No Page Found!!';
    }
  }
}

const String homeRoute = '/';
const String addnote = '/addnote';
const String notedetail = '/notedetail';
