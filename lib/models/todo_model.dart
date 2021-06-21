import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  final String title;
  final bool isDone;
  final String id;
  final DateTime date;
  TodoModel({
    this.title,
    this.isDone,
    this.id,
    this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isDone': isDone,
      "date": DateTime.now(),
    };
  }

  factory TodoModel.fromMap(DocumentSnapshot map) {
    return TodoModel(
      title: map['title'] ?? '',
      isDone: map['isDone'] ?? false,
      id: map.id ?? '',
    );
  }
}
