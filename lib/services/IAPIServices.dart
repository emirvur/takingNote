import 'package:tea/models/note.dart';
import 'package:tea/models/todo.dart';

abstract class IAPIService {
  Future<Todo> postTodo(Todo todo);
  Future<bool> putTodo(Todo todo);
  Future<bool> deleteTodo(int todoId);
  Future<List<Todo>> getListTodobyDay(int day, int month, int year);
  Future<Note> postNote(Note todo);
  Future<bool> putNote(Note todo);
  Future<bool> deleteNote(int todoId);
  Future<List<Note>> getListNote();
}
