import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todo/controllers/auth_controller.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/services/todo_service.dart';

class TodoController extends GetxController with StateMixin {
  TodoService todoService = TodoService();

  Rxn<TodoModel> todo = Rxn<TodoModel>();
  TextEditingController controller = TextEditingController();
  RxString uId = ''.obs;

  final _todos = <TodoModel>[].obs;
  List<TodoModel> get todos => _todos.toList();

  @override
  onInit() {
    uId.value = Get.find<AuthController>().user.uid;

    _todos.bindStream(todoService.getTodosFromFirestor(uId.value));
    change(todos, status: RxStatus.success());
    super.onInit();
  }

  createTodo() {
    todoService.addTodoToFirestor(
      id: uId.value,
      todoModel: TodoModel(
        title: controller.text,
        isDone: false,
      ),
    );
    controller.text = "";
    Get.back();
  }

  removeTodo(String id) {
    todoService.removeTodoNameToFirestor(
      uId: uId.value,
      id: id,
    );
  }

  updateTodo() {
    todoService.updateTodoNameToFirestor(
      uId: uId.value,
      todoModel: todo.value,
    );
  }
}
