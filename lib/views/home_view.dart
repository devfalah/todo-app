import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/controllers/auth_controller.dart';
import 'package:todo/controllers/todo_controller.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/views/profile_view.dart';
import 'package:todo/views/widgets/text_form_field.dart';

class HomeView extends GetView<TodoController> {
  final AuthController auth = Get.find();
  final TodoController todoController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                  Text(
                    "Todo",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  ),
                  GestureDetector(
                    child: Obx(
                      () => CircleAvatar(
                        backgroundImage: NetworkImage(auth.user.photoURL),
                        radius: 20.0,
                      ),
                    ),
                    onTap: () {
                      Get.to(ProfileScreen());
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: controller.obx(
                (state) => buildListView(),
                onLoading: Center(child: CircularProgressIndicator()),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (_) => Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: todoController.controller,
                      labeText: "New task",
                    ),
                    SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () {
                        todoController.createTodo();
                      },
                      child: Container(
                        width: 200,
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.green, Colors.greenAccent],
                              begin: Alignment(0.0, -1.0),
                              end: Alignment(0.0, 1.0)),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Center(
                            child: Text(
                          "ADD",
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        child: Container(
          width: 60.0,
          height: 60.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.green, Colors.greenAccent],
                begin: Alignment(0.0, -1.0),
                end: Alignment(0.0, 1.0)),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  ListView buildListView() {
    return ListView.builder(
      itemCount: todoController.todos.length,
      itemBuilder: (BuildContext context, int index) => Obx(
        () => TodoWidget(
          todo: todoController.todos[index],
          onChanged: (bool value) {
            todoController.todo.value = TodoModel(
              title: todoController.todos[index].title,
              isDone: value,
              id: todoController.todos[index].id,
            );

            todoController.updateTodo();
          },
          onDelete: () {
            todoController.removeTodo(todoController.todos[index].id);
          },
        ),
      ),
    );
  }
}

class TodoWidget extends StatelessWidget {
  final TodoModel todo;
  final Function onChanged;
  final Function onEdit;
  final Function onDelete;

  TodoWidget({this.todo, this.onChanged, this.onDelete, this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              activeColor: Colors.green,
              value: todo.isDone ?? false,
              onChanged: onChanged,
            ),
            Text(
              todo.title ?? "(Unnamed Todo)",
              style: TextStyle(
                color: todo.isDone ? Color(0xFF211551) : Color(0xFF86829D),
                fontSize: 16.0,
                fontWeight: todo.isDone ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(icon: Icon(Icons.delete), onPressed: onDelete),
            IconButton(icon: Icon(Icons.edit), onPressed: onEdit),
          ],
        )
      ],
    );
  }
}

class NoGlowBehaviour extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
