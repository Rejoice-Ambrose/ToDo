import 'package:flutter/material.dart';
import 'package:todo_app/page/home_page.dart';
import'package:provider/provider.dart';
import 'package:todo_app/provider/todos.dart';
import 'package:todo_app/todo.dart';
import 'package:todo_app/widget/todo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


 Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = "ToDo App";

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodosProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,

        theme: ThemeData(
          primarySwatch: Colors.pink,
          scaffoldBackgroundColor: const Color(0xFFf6f5ee),
        ),
        home: const HomePage(),
      ),
    );
  }
}
