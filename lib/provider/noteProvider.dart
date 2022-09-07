import 'package:flutter/material.dart';
import 'package:tea/models/note.dart';
import 'package:tea/models/note.dart';
import 'package:tea/services/APIServices.dart';
import 'package:tea/services/IAPIServices.dart';
import 'package:tea/utils/enums/noteEnum.dart';
import 'package:tea/utils/locator.dart';

class NoteProvider with ChangeNotifier {
  List<Note> _notes = [];
  List<Note> get notes => _notes;

  NoteViewState _state = NoteViewState.Idle;

  NoteViewState get state => _state;

  IAPIService apiservice = locator<APIServices>();

  DateTime date = DateTime.now();
  DateTime showndate =
      DateTime(DateTime.now().month, DateTime.now().day, DateTime.now().year);

  set state(NoteViewState value) {
    _state = value;
    notifyListeners();
  }

  void clearpost() {
    try {
      state = NoteViewState.Busy;
      _notes.clear();
      state = NoteViewState.Loaded;
    } catch (e) {
      state = NoteViewState.Idle;
    }
  }

  Future<void> addnote(Note note) async {
    try {
      state = NoteViewState.Busy;
      await apiservice.postNote(note);
      _notes.add(note);
      state = NoteViewState.Loaded;
    } catch (e) {
      state = NoteViewState.Idle;
    }
  }

  Future<void> deletenote(Note note) async {
    try {
      state = NoteViewState.Busy;
      await apiservice.deleteNote(note.noteId);
      _notes.remove(note);
      DateTime parsedDate = DateTime.parse(note.noteDate.substring(0, 10));
      state = NoteViewState.Loaded;
    } catch (e) {
      state = NoteViewState.Idle;
    }
  }

  Future<void> updatenote(Note note) async {
    try {
      state = NoteViewState.Busy;
      await apiservice.putNote(note);
      _notes[_notes.indexWhere((element) => element.noteId == note.noteId)] =
          note;

      state = NoteViewState.Loaded;
    } catch (e) {
      state = NoteViewState.Idle;
    }
  }

  Future<void> updatecompletenote(Note note) async {
    try {
      state = NoteViewState.Busy;
      note.isCompleted = 1;
      await apiservice.putNote(note);
      _notes[_notes.indexWhere((element) => element.noteId == note.noteId)] =
          note;
      DateTime parsedDate = DateTime.parse(note.noteDate.substring(0, 10));
      print(parsedDate.day.toString() + " ff " + showndate.day.toString());

      state = NoteViewState.Loaded;
    } catch (e) {
      state = NoteViewState.Idle;
    }
  }

  Future<void> initnote() async {
    try {
      List<Note> notes = await apiservice.getListNote();
      state = NoteViewState.Busy;
      print("add tum post busyde");
      _notes.clear();
      _notes.addAll(notes);

      state = NoteViewState.Loaded;
    } catch (e) {
      state = NoteViewState.Idle;
    }
  }
}
