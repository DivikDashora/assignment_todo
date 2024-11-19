import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_assignment/Helpers/constants.dart';
import 'package:todo_assignment/Helpers/helper_widgets.dart';
import 'package:todo_assignment/Provider/todo_provider.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(builder: (context, val, child) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Constants.baseColor,
            leading: const Center(
              child: CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/download.jpeg'),
              ),
            ),
            actions: [
              TextButton.icon(
                  onPressed: () {
                    val.controller.clear();
                    HelperWidgets.addATaskWidget(context, val, false, null);
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Add Task',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ))
            ],
            elevation: 2,
            scrolledUnderElevation: 0,
            centerTitle: false,
            title: const Text(
              "TO DO",
              style:
                  TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
            ),
          ),
          body: Visibility(
            visible: val.todoList.isNotEmpty,
            replacement: const Center(
                child: Text(
              "No Tasks Right Now !!",
              textAlign: TextAlign.center,
            )),
            child: ListView.separated(
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: val.todoList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      HelperWidgets.addATaskWidget(context, val, true, index);
                    },
                    selected: false,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    title: Text(
                      val.todoList[index].title,
                      maxLines: 2,
                    ),
                    subtitle: Text(
                        "Assigned on: ${DateTime.fromMillisecondsSinceEpoch(int.parse(val.todoList[index].date)).toString().split(' ').first}"),
                    trailing: Checkbox.adaptive(
                        value:
                            val.todoList[index].isComplete == 0 ? false : true,
                        onChanged: (v) {
                          val.markAsDone(val.todoList[index].id);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Task Completed !!!")));
                        }),
                  );
                }),
          ));
    });
  }
}
