import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Utils {
  static void showSnack(BuildContext context, String text) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(text),

      ));

  static dynamic toDateTime(Timestamp value){
    if(value == null) return null ;

    return value.toDate();
  }
  static dynamic fromDateTimeToJson(DateTime date){
    if(date == null)return null;

    return date.toUtc();


  }
  static StreamTransformer transformer<T>(T Function( Map<String, dynamic> json)fromJson)=>
      StreamTransformer<QuerySnapshot, List<T>>.fromHandlers(
        handleData: (QuerySnapshot data, EventSink <List<T>>sink){
          final snaps = data.docs.map((doc) => doc.data()).toList();
          final objects = snaps.map((json) => fromJson(json as Map<String, dynamic>)).toList();

          sink.add(objects);
        }
      );
// Scaffold.of(context)
//..removeCurrentSnackBar()
// ..showSnackBar(
//   SnackBar(content: String Text(text))
//   );

}