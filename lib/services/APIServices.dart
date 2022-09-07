import 'dart:convert';

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tea/models/note.dart';
import 'package:tea/models/todo.dart';
import 'package:tea/services/IAPIServices.dart';

class APIServices extends IAPIService {
  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    "apiKey": "yoursecretkey", // apikey can be stored in dotenv file
  };

  static String site = "https://192.168.1.105:45455";

  Future<Todo> postTodo(Todo todo) async {
    var maps = json.encode(todo.toJson());
    http.Response res = await http.post(Uri.parse("$site/api/todos"),
        headers: header, body: maps);
    if (res.statusCode != 201) {
      throw Exception;
    }
    var re = json.decode(res.body);

    Todo comingtodo = Todo.fromJson(re);
    return comingtodo;
  }

  Future<bool> putTodo(Todo todo) async {
    var maps = json.encode(todo.toPutJson());

    http.Response res = await http.put(
        Uri.parse("$site/api/todos/${todo.todoId}"),
        headers: header,
        body: maps);

    if (res.statusCode != 204) {
      throw Exception;
    }
    return true;
  }

  Future<bool> deleteTodo(int todoId) async {
    var maps = json.encode({
      "todoId": todoId,
    });

    http.Response res = await http.delete(Uri.parse("$site/api/todos/$todoId"),
        headers: header, body: maps);

    print(res.statusCode.toString());
    if (res.statusCode != 200) {
      throw Exception;
    }
    return true;
  }

  Future<List<Todo>> getListTodobyDay(int day, int month, int year) async {
    http.Response res = await http
        .get(Uri.parse("$site/api/todos/$day/$month/$year"), headers: header);

    if (res.statusCode != 200) {
      print("2qewe");
      throw Exception;
    }

    List re = json.decode(res.body);

    List<Todo> list = [];
    for (var l in re) {
      list.add(Todo.fromJson(l));
    }
    print(list.length.toString());
    return list;
  }

  Future<List<Note>> getListNote() async {
    http.Response res =
        await http.get(Uri.parse("$site/api/notes"), headers: header);

    if (res.statusCode != 200) {
      throw Exception;
    }

    List re = json.decode(res.body);

    List<Note> list = [];
    for (var l in re) {
      list.add(Note.fromJson(l));
    }
    print(list.length.toString());
    return list;
  }

  @override
  Future<bool> deleteNote(int noteId) async {
    var maps = json.encode({
      "noteId": noteId,
    });

    http.Response res = await http.delete(Uri.parse("$site/api/notes/$noteId"),
        headers: header, body: maps);

    print(res.statusCode.toString());
    if (res.statusCode != 200) {
      throw Exception;
    }
    return true;
  }

  @override
  Future<Note> postNote(Note note) async {
    var maps = json.encode(note.toJson());

    http.Response res = await http.post(Uri.parse("$site/api/notes"),
        headers: header, body: maps);

    if (res.statusCode != 201) {
      throw Exception;
    }
    var re = json.decode(res.body);

    Note comingtodo = Note.fromJson(re);
    return comingtodo;
  }

  @override
  Future<bool> putNote(Note note) async {
    var maps = json.encode(note.toPutJson());

    http.Response res = await http.put(
        Uri.parse("$site/api/notes/${note.noteId}"),
        headers: header,
        body: maps);
    print(res.statusCode.toString());
    if (res.statusCode != 204) {
      throw Exception;
    }
    return true;
  }
}
