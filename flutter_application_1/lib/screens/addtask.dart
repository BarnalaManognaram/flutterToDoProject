import 'package:flutter/material.dart';
import '../model/task.dart';
import 'view_tasks.dart';

class AddTask extends StatefulWidget {
  final Task? taskToEdit;
  final int? editIndex;

  AddTask({this.taskToEdit, this.editIndex});

  @override
  State<AddTask> createState() => _AddTaskState();
}
List<Task> taskList = [];

class _AddTaskState extends State<AddTask> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _status = 'Pending';
  String _priority = 'Medium';
  DateTime _createdDate = DateTime.now();
  DateTime? _deadline; // new deadline field

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Task')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) => value?.isEmpty ?? true ? 'Enter title' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
              SizedBox(height: 16),
              DropdownButtonFormField(
                value: _status,
                decoration: InputDecoration(labelText: 'Status'),
                items: ['Pending', 'In Progress', 'Completed']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) => setState(() => _status = value ?? 'Pending'),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField(
                value: _priority,
                decoration: InputDecoration(labelText: 'Priority'),
                items: ['Low', 'Medium', 'High']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) => setState(() => _priority = value ?? 'Medium'),
              ),
              SizedBox(height: 16),
              // Deadline picker
              GestureDetector(
                onTap: () async {
                  DateTime now = DateTime.now();
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _deadline ?? now,
                    firstDate: now,
                    lastDate: DateTime(now.year + 5),
                  );
                  if (picked != null) {
                    setState(() {
                      _deadline = picked;
                    });
                  }
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Deadline',
                      hintText: 'Select deadline',
                    ),
                    validator: (value) {
                      if (_deadline == null) return 'Select a deadline';
                      return null;
                    },
                    controller: TextEditingController(
                        text: _deadline != null
                            ? _deadline!.toLocal().toString().split(' ')[0]
                            : ''),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text('Created Date: ${_createdDate.toLocal().toString().split('.')[0]}'),
              SizedBox(height: 24),
                          ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {

                  Task newTask = Task(
                    title: _titleController.text,
                    description: _descriptionController.text,
                    status: _status,
                    priority: _priority,
                    createdDate: _createdDate,
                    deadline: _deadline!,
                  );

                  taskList.add(newTask);

                  // Navigate to view tasks; the screen reads from the shared list directly
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ViewTasks()),
                  );
                }
              },
              child: Text('Add Task'),
            ),
            ],
          ),
        ),
      ),
    );
  }
}