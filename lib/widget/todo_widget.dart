//import 'dart:ui';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/utils.dart';
import 'package:todo_app/widget/todo.dart';
import 'package:todo_app/provider/todos.dart';
import 'package:todo_app/page/edit_todo_page.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;

  const TodoWidget({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Slidable(
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  label: "Edit",
                  backgroundColor: Colors.green,
                  icon: Icons.edit,
                  onPressed: (BuildContext context) => editTodo(context, todo),
                )
              ],
            ),
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  label: "Delete",
                  backgroundColor: Colors.red,
                  icon: Icons.delete,
                  onPressed: (BuildContext context) =>
                      deleteTodo(context, todo),
                )
              ],
            ),
            key: Key(todo.id!),
            child: buildTodo(context)),
      );

  Widget buildTodo(BuildContext context) {
    return GestureDetector(
      onLongPress: ()=>editTodo(context, todo),

      child: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.white,
        child: Row(
          children: [
            Checkbox(
              activeColor: Theme.of(context).primaryColor,
              checkColor: Colors.white,
              value: todo.isDone,
              onChanged: (_) {
                final provider =
                    Provider.of<TodosProvider>(context, listen: false);
                final isDone = provider.toggleTodoStatus(todo);
                Utils.showSnack(context,
                    isDone ? "Task completed" : "Task marked incomplete");
              },
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                        fontSize: 22),
                  ),
                  if (todo.description.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      child: Text(
                        todo.description,
                        style: const TextStyle(fontSize: 20, height: 1.5),
                      ),
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void deleteTodo(BuildContext context, Todo todo) {
    final provider = Provider.of<TodosProvider>(context, listen: false);
    provider.removeTodo(todo);

    Utils.showSnack(context, "Deleted the task");
  }

  void editTodo(BuildContext context, Todo todo) =>
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => EditTodoPage(todo: todo),
      ));
}
