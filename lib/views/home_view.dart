import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/controllers/auth_controller.dart';
import 'package:todo/controllers/todo_controller.dart';
import 'package:todo/helper/constant.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/views/profile_view.dart';
import 'package:todo/views/widgets/text_form_field.dart';

class HomeView extends StatelessWidget {
  final AuthController auth = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetX<TodoController>(
      init: TodoController(),
      builder: (controller) => Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
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
                          backgroundImage: NetworkImage(
                              auth.user.photoURL ?? placeholderImage),
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
                child: buildListView(controller),
              ),
            ],
          ),
        ),
        floatingActionButton: GestureDetector(
          onTap: () {
            buildShowModalBottomSheet(
                context, "ADD TODO", "ADD", controller.textController, () {
              controller.createTodo();
              Focus.of(context).unfocus();
            });
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
      ),
    );
  }

  Future buildShowModalBottomSheet(BuildContext context, String text,
      String textButton, textController, Function onTap) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        height: 500,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextFormField(
                  controller: textController,
                  labeText: "$text",
                ),
                SizedBox(height: 20.0),
                GestureDetector(
                  onTap: onTap,
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
                      "$textButton",
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ListView buildListView(controller) {
    return ListView.builder(
      itemCount: controller.todos.length,
      itemBuilder: (BuildContext context, int index) => Obx(
        () => TodoWidget(
          todo: controller.todos[index],
          onChanged: (bool value) {
            controller.updateTodo(
              controller.todos[index].id,
              controller.todos[index].title,
              value,
            );
          },
          onDelete: () {
            controller.removeTodo(controller.todos[index].id);
          },
          onEdit: () {
            buildShowModalBottomSheet(
                context, "EDIT TODO", "EDIT", controller.textController, () {
              controller.updateTodo(
                controller.todos[index].id,
                controller.textController.text,
                controller.todos[index].isDone,
              );
            });
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
