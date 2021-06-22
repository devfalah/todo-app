import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todo/controllers/auth_controller.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/services/todo_service.dart';

class TodoController extends GetxController {
  TodoService todoService = TodoService();

  TextEditingController textController = TextEditingController();
  RxString uId = ''.obs;
  RxBool isLoading = false.obs;

  final _todos = <TodoModel>[].obs;
  List<TodoModel> get todos => _todos.toList();

  @override
  onInit() {
    isLoading.value = true;
    uId.value = Get.find<AuthController>().user.uid;

    _todos.bindStream(todoService.getTodosFromFirestor(uId.value));

    super.onInit();
  }

  @override
  onReady() {
    isLoading.value = false;
    super.onReady();
  }

  createTodo() {
    todoService.addTodoToFirestor(
      id: uId.value,
      todoModel: TodoModel(
        title: textController.text,
        isDone: false,
      ),
    );
    textController.text = "";
    Get.back();
  }

  removeTodo(String id) {
    todoService.removeTodoNameToFirestor(
      uId: uId.value,
      id: id,
    );
  }

  updateTodo(String id, String title, bool isDone) {
    todoService.updateTodoNameToFirestor(
      uId: uId.value,
      todoModel: TodoModel(
        title: title,
        id: id,
        isDone: isDone,
      ),
    );
    textController.text = "";
    Get.back();
  }
}
