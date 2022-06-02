import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/widget/todo.dart';
import 'package:todo_app/widget/todo_widget.dart';

class  CompletedListWidget extends StatelessWidget {
  const CompletedListWidget({Key? key}) : super(key: key);

  //const ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    final todos = provider.todosCompleted;

    return todos.isEmpty
        ? const Center(
      child: Text(
        "No completed todos.",
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

