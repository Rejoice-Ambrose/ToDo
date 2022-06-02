import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/api/firebase_api.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/widget/completed_list_widget.dart';
import 'package:todo_app/widget/todo.dart';
import 'package:todo_app/widget/todo_list_widget.dart';
import 'package:provider/provider.dart';

import '../provider/todos.dart';
import '../widget/dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      TodoListWidget(),
      CompletedListWidget(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text(MyApp.title),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.fact_check_outlined), label: "ToDos"),
          BottomNavigationBarItem(
              icon: Icon(Icons.done, size: 28), label: "Completed")
        ],
      ),
      body: StreamBuilder<List<Todo>>(
        stream: FirebaseApi.readTodos(),
        builder: (context, snapshot) {
          final todos = snapshot.data;
          final provider = Provider.of<TodosProvider>(context);



          return tabs[selectedIndex];
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.black,
        onPressed: () =>
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return const AddTodoDialogWidget();
              },
            ),
      ),
    );
  }
}
