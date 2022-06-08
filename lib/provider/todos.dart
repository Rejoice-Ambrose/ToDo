//import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/utils.dart';
import 'package:todo_app/widget/todo_list_widget.dart';


class TodoField {
  static const createdTime = "createdTime";
}


class Todo {
  DateTime createdTime;
  String title;
  String? id;
  String description;
  bool isDone;

  Todo({
    required this.createdTime,
    required this.title,
    this.description = "",
    this.id,
    this.isDone = false,
  });
  static Todo fromJson(Map<String, dynamic>json)=>Todo(
    createdTime: Utils.toDateTime(json["createdTime"]),
    title: json["title"],
    description: json["description"],
    id:json["id"],
    isDone: json["isDone"],
  );


  Map<String, dynamic>toJson()=> {
    "createdTime": Utils.fromDateTimeToJson(createdTime),
    "title" : title,
    "description" : description,
    "id" : id,
    "isDone" : isDone,
  };
}