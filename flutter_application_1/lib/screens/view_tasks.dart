import 'package:flutter/material.dart';
import '../model/task.dart';
import 'addtask.dart';

class ViewTasks extends StatefulWidget {
  const ViewTasks({Key? key}) : super(key: key);

  @override
  State<ViewTasks> createState() => _ViewTasksState();
}

class _ViewTasksState extends State<ViewTasks> {
  // we'll reference the shared list directly so it always stays in sync
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() {
    setState(() {
      tasks = taskList; // top‑level shared list from addtask.dart
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Tasks'),
      ),
      body: tasks.isEmpty
          ? const Center(
              child: Text('No tasks yet'),
            )
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                 child: ListTile(
                 contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  title: Text(task.title),
                  tileColor: Colors.blue,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ) ,
                  subtitle: Text('${task.description} \n${task.status} • ${task.priority}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          // navigate to AddTask in edit mode
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddTask(
                                taskToEdit: task,
                                editIndex: index,
                              ),
                            ),
                          );
                          if (result == true) {
                            _loadTasks();
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            // keep global list in sync
                            taskList.removeAt(index);
                          });
                        },
                      ),
                    ],
                  ),
                ),
                );
              },
            ),
    );
  }
}