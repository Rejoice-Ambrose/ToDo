import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/provider/todos.dart';
import 'package:todo_app/widget/todo.dart';
import 'package:todo_app/widget/todo_widget.dart';

class TodoListWidget extends StatelessWidget {
  //const TodoListWidget({Key? key, @required todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    final todos = provider.todos;
    return todos.isEmpty
        ? const Center(
      child: Text(
        "No Todos.",
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    )
        : ListView.separated(
        separatorBuilder: (context, index) =>
            Container(
              height: 12,
            ),
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final todo = todos.toList()[index];
          return TodoWidget(todo: todo);
        },
        itemCount: todos.length);
  }
}
