import 'dart:convert';

import 'category.dart';

List<Note> noteFromJson(String str) =>
    List<Note>.from(json.decode(str).map((x) => Note.fromJson(x)));

String noteToJson(List<Note> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Note {
  Note({
    this.noteId,
    this.noteTitle,
    this.noteDescription,
    this.noteDate,
  });

  int noteId;
  String noteTitle;
  String noteDescription;
  String noteDate;

  int isCompleted;

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        noteId: json["noteId"],
        noteTitle: json["noteTitle"],
        noteDescription:
            json["noteDescription"] == null ? null : json["noteDescription"],
        noteDate: json["noteDate"],
      );

  Map<String, dynamic> toJson() => {
        //  "noteId": noteId,
        "noteTitle": noteTitle,
        "noteDescription": noteDescription == null ? null : noteDescription,
        "noteDate": noteDate.toString(),
      };
  Map<String, dynamic> toPutJson() => {
        "noteId": noteId,
        "noteTitle": noteTitle,
        "noteDescription": noteDescription == null ? null : noteDescription,
        "noteDate": noteDate.toString(),
      };
}
