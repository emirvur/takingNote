// To parse this JSON data, do
//
//     final todo = todoFromJson(jsonString);

import 'dart:convert';


List<Todo> todoFromJson(String str) =>
    List<Todo>.from(json.decode(str).map((x) => Todo.fromJson(x)));

String todoToJson(List<Todo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Todo {
  Todo({
    this.todoId,
    this.todoTitle,
    this.todoDescription,
    this.todoDate,
    this.isCompleted,
  });

  int todoId;
  String todoTitle;
  String todoDescription;
  String todoDate;

  int isCompleted;

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        todoId: json["todoId"],
        todoTitle: json["todoTitle"],
        todoDescription:
            json["todoDescription"] == null ? null : json["todoDescription"],
        todoDate: json["todoDate"],
        isCompleted: json["isCompleted"],
      );

  Map<String, dynamic> toJson() => {
        //   "todoId": todoId,
        "todoTitle": todoTitle,
        "todoDescription": todoDescription == null ? null : todoDescription,
        "todoDate": todoDate.toString(),

        "isCompleted": isCompleted,
      };
  Map<String, dynamic> toPutJson() => {
        "todoId": todoId,
        "todoTitle": todoTitle,
        "todoDescription": todoDescription == null ? null : todoDescription,
        "todoDate": todoDate.toString(),
        "isCompleted": isCompleted,
      };
}
