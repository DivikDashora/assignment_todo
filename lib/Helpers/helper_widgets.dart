import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_assignment/Helpers/constants.dart';
import 'package:todo_assignment/Provider/todo_provider.dart';

class HelperWidgets {
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getScreenwidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static addATaskWidget(
      BuildContext context, TodoProvider provider, bool isEdit, int? index) {
    if (isEdit) {
      provider.controller.text = provider.todoList[index!].title;
    }
    return showCupertinoDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
                side: const BorderSide(color: Constants.baseColor, width: 2)),
            child: Container(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: provider.key,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          isEdit ? 'Edit Task' : 'Register Task',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value == '') {
                            return 'Don\'t leave this blank.';
                          }
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r'^\s+'))
                        ],
                        controller: provider.controller,
                        maxLines: 2,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4)),
                            hintText: 'Write Your Task'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                            onPressed: () {
                              if (isEdit) {
                                provider.editTask(context, index! + 1);
                              } else {
                                provider.addTask(context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                backgroundColor: Constants.baseColor),
                            child: Text(
                              isEdit ? "Edit Task" : "Add Task",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ))
                        ],
                      )
                    ],
                  ),
                )),
          );
        });
  }
}
