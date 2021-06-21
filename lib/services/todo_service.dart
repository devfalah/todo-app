import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/models/todo_model.dart';

class TodoService {
  CollectionReference todos = FirebaseFirestore.instance.collection('todos');
  Future<void> addTodoToFirestor({TodoModel todoModel, String id}) {
    return todos
        .doc(id)
        .collection('mytodos')
        .add(todoModel.toMap())
        .then((value) => print("Todo Added"))
        .catchError((error) => print("Failed to add Todo: $error"));
  }

  Future<void> updateTodoNameToFirestor({TodoModel todoModel, String uId}) {
    return todos
        .doc(uId)
        .collection('mytodos')
        .doc(todoModel.id)
        .update(todoModel.toMap())
        .then((value) => print("Todo Added"))
        .catchError((error) => print("Failed to add Todo: $error"));
  }

  Future<void> removeTodoNameToFirestor({String uId, String id}) {
    return todos
        .doc(uId)
        .collection('mytodos')
        .doc(id)
        .delete()
        .then((value) => print("Todo Added"))
        .catchError((error) => print("Failed to add Todo: $error"));
  }

  Stream<List<TodoModel>> getTodosFromFirestor(String uId) {
    return todos
        .doc(uId)
        .collection('mytodos')
        .orderBy('date', descending: true)
        .snapshots()
        .map((event) {
      return event.docs.map((e) => TodoModel.fromMap(e)).toList();
    });
  }

  Future<List<QueryDocumentSnapshot>> get(uId) async {
    final value = await todos.doc(uId).collection('mytodos').get();
    return value.docs;
  }
}
