import 'package:task_manager_ui/task_card.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_ui/task_model.dart'; // Import our new model

void main() {
  runApp(const TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const TaskListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  // Here is our list of mock tasks.
  final List<Task> _tasks = [
    Task(id: 'Order-1043', title: 'Arrange Pickup', assignee: 'Sandhya', isHighPriority: true, startDate: DateTime.now().subtract(const Duration(hours: 16))),
    Task(id: 'Entity-2559', title: 'Adhoc Task', assignee: 'Arman', status: TaskStatus.completed, startDate: DateTime.now().subtract(const Duration(days: 1)), completedDate: DateTime.now()),
    Task(id: 'Order-1020', title: 'Collect Payment', assignee: 'Sandhya', isHighPriority: true, status: TaskStatus.notStarted, startDate: DateTime.now().add(const Duration(days: 2))),
    Task(id: 'Enquiry-3563', title: 'Convert Enquiry', assignee: 'Prashant', status: TaskStatus.notStarted, startDate: DateTime.now().add(const Duration(days: 1))),
  ];

  void _startTask(Task task) {
    setState(() {
      task.status = TaskStatus.started;
    });
  }

  void _completeTask(Task task) {
    setState(() {
      task.status = TaskStatus.completed;
      task.completedDate = DateTime.now();
    });
  }

  Future<void> _editTaskDate(Task task) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: task.startDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != task.startDate) {
      setState(() {
        task.startDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 2,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks[index];
          // We will build the TaskCard widget next!
          return TaskCard(
            task: task,
            onStartTask: () => _startTask(task),
            onCompleteTask: () => _completeTask(task),
            onEditDate: () => _editTaskDate(task),
        );
        },
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}
