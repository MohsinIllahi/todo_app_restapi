import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app_restapi/screens/services/todo_service.dart';
import 'package:todo_app_restapi/utils/snackbar_helpers.dart';

class AddTodoPage extends StatefulWidget {
  final Map? todo;
  const AddTodoPage({super.key, this.todo});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isEdit = false;
  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      final title = todo['title'];
      final description = todo['description'];
      titleController.text = title;
      descriptionController.text = description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Todo' : 'Add Todo'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(hintText: 'Title'),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(hintText: 'Description'),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: isEdit ? updateData : submitData,
              child: Text(isEdit ? 'Update' : 'Submit'))
        ],
      ),
    );
  }

//updation of data
  Future<void> updateData() async {
    final todo = widget.todo;
    if (todo == null) {
      print('you can not call update without todo data');
      return;
    }
    final id = todo['_id'];
    final title = titleController.text;
    final description = descriptionController.text;

    final body = {
      "title": title,
      "description": description,
      "is_completed": false
    };
    //Submit update the data to the server
    final isSuccess = await TodoService.updateTodo(id, body);
    if (isSuccess) {
      showSnackBar(context, message: 'Updation successful');
    } else {
      showErrorSnackBar(context, message: 'Updation Failed');
    }
  }

  Future<void> submitData() async {
    //Submit the data to the server
    final isSuccess = await TodoService.addTodo(body);
    //show success or failure according to the status
    // print(response.statusCode);
    if (isSuccess) {
      titleController.text = '';
      descriptionController.text = '';
      showSnackBar(context, message: 'Creation successful');
    } else {
      showErrorSnackBar(context, message: 'Creation Failed');
    }
  }

  Map get body {
    //Get data from the form
    final title = titleController.text;
    final description = descriptionController.text;

    return {"title": title, "description": description, "is_completed": false};
  }
}
