import 'package:flutter/material.dart';

class ViewTasks extends StatefulWidget {
  const ViewTasks({Key? key}) : super(key: key);

  @override
  State<ViewTasks> createState() => _ViewTasksState();
}

class _ViewTasksState extends State<ViewTasks> {
  List<String> tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() {
    // Replace with your actual task loading logic
    setState(() {
      tasks = [
        'Task 1',
        'Task 2',
        'Task 3',
      ];
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
                return ListTile(
                  title: Text(tasks[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        tasks.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
    );
  }
}