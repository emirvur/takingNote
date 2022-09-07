import 'package:flutter/material.dart';
import 'package:tea/models/todo.dart';
import 'package:tea/provider/todoProvider.dart';
import 'package:tea/services/APIServices.dart';
import 'package:tea/services/IAPIServices.dart';
import 'package:tea/utils/constants/size.dart';
import 'package:tea/utils/routes.dart';
import 'package:tea/view/todoList.dart';
import 'package:tea/view/noteList.dart';
import 'package:tea/utils/locator.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  List<Widget> _widgets = <Widget>[
    NoteList(),
    TodoList(),
  ];

  PageController _pageController = PageController();
  TextEditingController _titleController;
  TextEditingController _descriptionController;
  String _selectedDate;
  IAPIService _apiservice = locator<APIServices>();
  String _notelist = "Note List";
  String _todolist = "Todo List";
  String _selectdate = "Select a Date";
  String _added = 'Added';
  String _addtodo = "Add a Todo";

  void _onItemTapped(int index) {
    _pageController.jumpToPage(index);
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            _selectedIndex == 0
                ? Navigator.pushNamed(context, addnote)
                : addshowModalBottom(
                    context, _titleController, _descriptionController);
          },
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _widgets,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey.shade300,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text(_notelist)),
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), title: Text(_todolist)),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Future<void> addshowModalBottom(
    BuildContext context,
    TextEditingController titleController,
    TextEditingController descriptionController,
  ) {
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CentralSize.borderradius),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * 4 / 5,
              //  color: Colors.amber,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 2 / 3,
                      child: CustomTextFormField(
                        controller: titleController,
                        hintText: "Title",
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 2 / 3,
                      child: CustomTextFormField(
                        controller: descriptionController,
                        hintText: "Description",
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
                                      borderRadius:
                                          BorderRadius.circular(20.0))),
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
                                    _selectedDate = selectedDate1
                                        .toString()
                                        .substring(0, 10);
                                  });
                                }
                              });
                            },
                            icon: Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                            ),
                            label: Text(
                              _selectedDate ?? _selectdate,
                              style: TextStyle(color: Colors.white),
                            ))),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 2 / 3,
                      child: ElevatedButton(
                          onPressed: () async {
                            try {
                              Todo todo = Todo(
                                todoTitle: titleController.text,
                                todoDate: _selectedDate,
                                todoDescription: descriptionController.text,
                                isCompleted: 0,
                              );
                              context.read<TodoProvider>().addtodo(todo);
                              titleController.clear();
                              descriptionController.clear();
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(_added)),
                              );
                              TodoListState.controller.animateToDate(
                                  DateTime.parse(_selectdate.substring(0, 10)));
                            } catch (e) {}
                          },
                          child: Text(_addtodo)),
                    )
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key key,
    @required this.controller,
    @required this.hintText,
    this.defaultText,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final String defaultText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10.0),
            ),
            fillColor: Colors.blueGrey[100],
            filled: true,
            suffixIcon: IconButton(
              icon: const Icon(
                Icons.clear_outlined,
                size: 20,
                color: Colors.red,
              ),
              onPressed: () {
                controller.text = '';
              },
            ),
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.black)),
        onSaved: (String value) {},
        maxLength: hintText == "Description" ? 100 : 20,
        minLines: hintText == "Description" ? 3 : 1,
        maxLines: hintText == "Description" ? 3 : 1,
      ),
    );
  }
}
