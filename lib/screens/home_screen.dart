import 'package:flutter/material.dart';
import '../models/task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    _loadSampleTasks();
  }

  void _loadSampleTasks() {
    tasks = [
      Task(
        id: '1',
        title: 'Complete Flutter Interview',
        description: 'Finish the technical interview questions',
        createdAt: DateTime.now(),
        priority: 'high',
      ),
      Task(
        id: '2',
        title: 'Review Code',
        description: 'Review the submitted code for bugs',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        priority: 'medium',
      ),
      Task(
        id: '3',
        title: 'Update Documentation',
        description: 'Update the project documentation with new features',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        priority: 'low',
        isCompleted: true,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Task Manager'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                task.title,
                style: TextStyle(
                  decoration: task.isCompleted 
                      ? TextDecoration.lineThrough 
                      : TextDecoration.none,
                ),
              ),
              subtitle: Text(task.description),
              leading: Checkbox(
                value: task.isCompleted,
                onChanged: (value) {
                  setState(() {
                    tasks[index] = task.copyWith(isCompleted: value ?? false);
                  });
                },
              ),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getPriorityColor(task.priority).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _getPriorityColor(task.priority)),
                ),
                child: Text(
                  task.priority.toUpperCase(),
                  style: TextStyle(
                    color: _getPriorityColor(task.priority),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  void _showAddTaskDialog() {
    // TODO: Implement add task dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Add task dialog not implemented yet')),
    );
  }
}
