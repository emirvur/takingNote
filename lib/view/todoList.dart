import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:tea/utils/constants/size.dart';
import 'package:tea/utils/enums/todoEnum.dart';
import 'package:tea/models/todo.dart';
import 'package:tea/provider/todoProvider.dart';
import 'package:tea/services/APIServices.dart';
import 'package:tea/services/IAPIServices.dart';
import 'package:tea/view/MainScreen.dart';
import 'package:tea/utils/locator.dart';

import 'package:tea/widgets/todoCard.dart';
import 'package:provider/provider.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key key}) : super(key: key);

  @override
  State<TodoList> createState() => TodoListState();
}

class TodoListState extends State<TodoList> with AutomaticKeepAliveClientMixin {
  static DatePickerController controller;

  DateTime _selectedValue = DateTime.now();
  TextEditingController _titleController;
  TextEditingController _descriptionController;
  String _updatedDate;
  IAPIService _apiservice = locator<APIServices>();
  DateTime _date = DateTime.now();
  String _yourperformance = "Your Performance ";
  String _updatetodo = "Update Todo";
  String _updated = "Updated";
  String _added = "Added";
  String _addtodo = "Add a Todo";
  String _delete = "Delete";
  String _cancel = "Cancel";
  String _uncompleteTodo = "UnComplete Todo";
  String _completeTodo = "Complete Todo";
  String _deleteTodo = "Delete Todo";
  String _deleteConfirmation = "Delete Confirmation";
  String _sureDelete = "Are you sure you want to delete this item?";
  String _complete = "Complete";
  String _uncomplete = "Uncomplete";
  String _uncompleteConfirmation = "UnComplete Confirmation";
  String _completeConfirmation = "Complete Confirmation";
  String _sureUncomplete = "Are you sure you want to uncomplete this item?";
  String _sureComplete = "Are you sure you want to complete this item?";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<TodoProvider>().initTodo(_date.day, _date.month, _date.year);
    controller = DatePickerController();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.animateToDate(_date);
    });
  }

  @override
  bool get wantKeepAlive => true;
  String numberofuncompletedTodos() {
    int uncompleted = 0;
    int completed = 0;
    for (Todo i in context.read<TodoProvider>().todos) {
      if (i.isCompleted == 0) {
        uncompleted = uncompleted + 1;
      } else {
        completed = completed + 1;
      }
    }
    return completed.toString() +
        "/" +
        context.read<TodoProvider>().todos.length.toString();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
              padding: EdgeInsets.all(CentralSize.generalPadding * 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: DatePicker(
                      DateTime.now().subtract(Duration(days: 30)),
                      width: 60,
                      height: 80,
                      controller: controller,
                      initialSelectedDate: DateTime.now(),
                      selectionColor: Colors.black,
                      selectedTextColor: Colors.white,
                      onDateChange: (date) async {
                        await context
                            .read<TodoProvider>()
                            .initTodo(date.day, date.month, date.year);
                        _updatedDate = date.toString();
                      },
                    ),
                  ),
                  Expanded(
                    child: Consumer<TodoProvider>(builder: (_, prov, child) {
                      return prov.state == TodoViewState.Busy
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(
                                      CentralSize.generalPadding),
                                  child: Text(
                                    _yourperformance +
                                        numberofuncompletedTodos(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .fontSize,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                      itemCount: prov.todos.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        Todo to = prov.todos[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(
                                              CentralSize.generalPadding),
                                          child: InkWell(
                                            onTap: () {
                                              _titleController.text =
                                                  to.todoTitle;
                                              _descriptionController.text =
                                                  to.todoDescription;
                                              updateshowModalBottom(
                                                  context,
                                                  _titleController,
                                                  _descriptionController,
                                                  to.todoId,
                                                  to.todoTitle,
                                                  to.todoDescription ?? "",
                                                  to.todoDate);
                                            },
                                            child: Dismissible(
                                              key: Key(
                                                  'item ${prov.todos[index]}'),
                                              background: Padding(
                                                padding: const EdgeInsets.all(
                                                    CentralSize.generalPadding *
                                                        1.5),
                                                child: Container(
                                                  color: Colors.blue,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .all(CentralSize
                                                            .generalPadding *
                                                        1.5),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(
                                                            Icons
                                                                .update_outlined,
                                                            color:
                                                                Colors.white),
                                                        Text(
                                                            to.isCompleted == 1
                                                                ? _uncompleteTodo
                                                                : _completeTodo,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              secondaryBackground: Padding(
                                                padding: const EdgeInsets.all(
                                                    CentralSize.generalPadding *
                                                        1.5),
                                                child: Container(
                                                  color: Colors.red,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .all(CentralSize
                                                            .generalPadding *
                                                        1.5),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: <Widget>[
                                                        Icon(Icons.delete,
                                                            color:
                                                                Colors.white),
                                                        Text(_deleteTodo,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              confirmDismiss: (DismissDirection
                                                  direction) async {
                                                if (direction ==
                                                    DismissDirection
                                                        .startToEnd) {
                                                  print(_completeTodo);
                                                  return await showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text(to
                                                                    .isCompleted ==
                                                                1
                                                            ? _uncompleteConfirmation
                                                            : _completeConfirmation),
                                                        content: Text(
                                                            to.isCompleted == 1
                                                                ? _sureUncomplete
                                                                : _sureComplete),
                                                        actions: <Widget>[
                                                          FlatButton(
                                                              onPressed:
                                                                  () async {
                                                                to.isCompleted ==
                                                                        1
                                                                    ? await context
                                                                        .read<
                                                                            TodoProvider>()
                                                                        .updateuncompleteTodo(
                                                                            to)
                                                                    : await context
                                                                        .read<
                                                                            TodoProvider>()
                                                                        .updatecompleteTodo(
                                                                            to);
                                                                controller.animateToDate(
                                                                    DateTime.parse(
                                                                        _updatedDate
                                                                            .toString()));
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(true);
                                                              },
                                                              child: Text(to
                                                                          .isCompleted ==
                                                                      1
                                                                  ? _uncomplete
                                                                  : _complete)),
                                                          FlatButton(
                                                            onPressed: () =>
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(false),
                                                            child:
                                                                Text(_cancel),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                } else {
                                                  return await showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                            _deleteConfirmation),
                                                        content:
                                                            Text(_sureDelete),
                                                        actions: <Widget>[
                                                          FlatButton(
                                                              onPressed:
                                                                  () async {
                                                                await context
                                                                    .read<
                                                                        TodoProvider>()
                                                                    .deleteTodo(
                                                                        to);

                                                                Navigator.of(
                                                                        context)
                                                                    .pop(true);
                                                              },
                                                              child: Text(
                                                                  _delete)),
                                                          FlatButton(
                                                            onPressed: () =>
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(false),
                                                            child:
                                                                Text(_cancel),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                }
                                              },
                                              onDismissed:
                                                  (DismissDirection direction) {
                                                if (direction ==
                                                    DismissDirection
                                                        .startToEnd) {
                                                } else {}
                                              },
                                              child: TodoCard(to),
                                            ),
                                          ),
                                        );
                                      }),
                                )
                              ],
                            );
                    }),
                  )
                ],
              ))),
    );
  }

  Future<void> updateshowModalBottom(
      BuildContext context,
      TextEditingController titleController,
      TextEditingController descriptionController,
      int todoId,
      String title,
      String description,
      String date) {
    return showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CentralSize.borderradius),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
            height: MediaQuery.of(context).size.height * 2 / 3,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 2 / 3,
                    child: CustomTextFormField(
                      controller: titleController,
                      //    hintText: "Title",
                      defaultText: title,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 2 / 3,
                    child: CustomTextFormField(
                      controller: descriptionController,
                      defaultText: description,
                    ),
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 2 / 3,
                      child: TextButton.icon(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        CentralSize.borderradius * 2))),
                          ),
                          onPressed: () async {
                            await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2022),
                              lastDate: DateTime(2030),
                            ).then((selectedDate1) {
                              print(selectedDate1.toString());
                              if (selectedDate1 != null) {
                                setState(() {
                                  _updatedDate =
                                      selectedDate1.toString().substring(0, 10);
                                });
                              }
                            });
                          },
                          icon: Icon(
                            Icons.calendar_today,
                            color: Colors.white,
                          ),
                          label: Text(
                            date.substring(0, 10),
                            style: TextStyle(color: Colors.white),
                          ))),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 2 / 3,
                    child: ElevatedButton(
                        onPressed: () async {
                          try {
                            Todo todo = Todo(
                              todoId: todoId,
                              todoTitle: titleController.text,
                              todoDate: date ?? _updatedDate,
                              todoDescription: descriptionController.text,
                              isCompleted: 0,
                            );
                            context.read<TodoProvider>().updateTodo(todo);

                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(_updated)),
                            );
                          } catch (e) {
                            print("catchrr" + e.toString());
                          }
                        },
                        child: Text(_updatetodo)),
                  )
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
