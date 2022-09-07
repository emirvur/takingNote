import 'package:flutter/material.dart';
import 'package:tea/models/todo.dart';
import 'package:tea/services/APIServices.dart';
import 'package:tea/services/IAPIServices.dart';
import 'package:tea/utils/enums/todoEnum.dart';
import 'package:tea/utils/locator.dart';

class TodoProvider with ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  TodoViewState _state = TodoViewState.Idle;

  TodoViewState get state => _state;

  IAPIService apiservice = locator<APIServices>();

  DateTime date = DateTime.now();
  DateTime showndate =
      DateTime(DateTime.now().month, DateTime.now().day, DateTime.now().year);

  set state(TodoViewState value) {
    _state = value;
    notifyListeners();
  }

  void clearpost() {
    try {
      state = TodoViewState.Busy;
      _todos.clear();
      state = TodoViewState.Loaded;
    } catch (e) {
      state = TodoViewState.Idle;
    }
  }

  Future<void> addtodo(Todo todo) async {
    try {
      state = TodoViewState.Busy;
      await apiservice.postTodo(todo);
      _todos.add(todo);
      state = TodoViewState.Loaded;
    } catch (e) {
      state = TodoViewState.Idle;
    }
  }

  Future<void> deleteTodo(Todo todo) async {
    try {
      state = TodoViewState.Busy;
      await apiservice.deleteTodo(todo.todoId);
      _todos.remove(todo);
      DateTime parsedDate = DateTime.parse(todo.todoDate.substring(0, 10));
      print(parsedDate.day.toString() + " ff " + showndate.day.toString());
      if (showndate.year == parsedDate.year &&
          showndate.month == parsedDate.month &&
          showndate.day == parsedDate.day) {}
      state = TodoViewState.Loaded;
    } catch (e) {
      state = TodoViewState.Idle;
    }
  }

  Future<void> updateTodo(Todo todo) async {
    try {
      state = TodoViewState.Busy;
      await apiservice.putTodo(todo);
      _todos[_todos.indexWhere((element) => element.todoId == todo.todoId)] =
          todo;
      state = TodoViewState.Loaded;
    } catch (e) {
      state = TodoViewState.Idle;
    }
  }

  Future<void> updatecompleteTodo(Todo todo) async {
    try {
      state = TodoViewState.Busy;
      todo.isCompleted = 1;
      await apiservice.putTodo(todo);
      _todos[_todos.indexWhere((element) => element.todoId == todo.todoId)] =
          todo;
      state = TodoViewState.Loaded;
    } catch (e) {
      state = TodoViewState.Idle;
    }
  }

  Future<void> updateuncompleteTodo(Todo todo) async {
    try {
      state = TodoViewState.Busy;
      todo.isCompleted = 0;
      await apiservice.putTodo(todo);
      _todos[_todos.indexWhere((element) => element.todoId == todo.todoId)] =
          todo;
      state = TodoViewState.Loaded;
    } catch (e) {
      state = TodoViewState.Idle;
    }
  }

  Future<void> initTodo(int day, int month, int year) async {
    try {
      state = TodoViewState.Busy;
      List<Todo> todos = await apiservice.getListTodobyDay(day, month, year);
      _todos.clear();
      _todos.addAll(todos);

      state = TodoViewState.Loaded;
    } catch (e) {
      state = TodoViewState.Idle;
    }
  }
}
