import 'package:flutter/material.dart';
import 'package:tea/models/todo.dart';
import 'package:tea/utils/constants/size.dart';
import 'package:tea/widgets/chip.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;
  const TodoCard(this.todo);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(CentralSize.generalPadding),
      child: Container(
        height: CentralSize.containerHeight,
        width: MediaQuery.of(context).size.width,
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(CentralSize.cardradius),
            ),
            color: Colors.white,
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(CentralSize.generalPadding),
              child: Column(
                children: [
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          todo.todoTitle,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ChipWidget(
                        todo.isCompleted == 1 ? "Completed" : "UnCompleted",
                        color:
                            todo.isCompleted == 1 ? Colors.blue : Colors.orange,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(todo.todoDescription ?? ""))
                ],
              ),
            )),
      ),
    );
  }
}
