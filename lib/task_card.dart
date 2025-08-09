import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_ui/task_model.dart';

// CORRECT CODE - Fields are now declared

class TaskCard extends StatelessWidget {

  final Task task;
  final VoidCallback onStartTask;
  final VoidCallback onCompleteTask;
  final VoidCallback onEditDate;

  const TaskCard({
    super.key,
    required this.task,
    required this.onStartTask,
    required this.onCompleteTask,
    required this.onEditDate,
  });

  Widget _buildNotStartedSection() {
  // An edit icon must be displayed next to the start date [cite: 11]
  // A "Not Started" task needs a "Start Task" button [cite: 5]
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      GestureDetector(
        onTap: onEditDate, // Connect the wire to the onEditDate function!
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Due in 2 days', style: TextStyle(color: Colors.orange.shade700, fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text('Start: ${DateFormat('MMM dd').format(task.startDate)}'),
              ],
            ),
            const SizedBox(width: 8),
            const Icon(Icons.edit, size: 18, color: Colors.grey),
          ],
        ),
      ),
      
      ElevatedButton(
        onPressed: onStartTask ,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text('Start Task'),
      ),
    ],
  );
}

// UI for 'Started' tasks
  Widget _buildStartedSection() {
  // A "Started" task needs a "Mark as Complete" button [cite: 7]
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      GestureDetector(
        onTap: onEditDate, // Connect the wire to the onEditDate function!
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Overdue-16h 4m', style: TextStyle(color: Colors.red.shade700, fontWeight: FontWeight.bold)),
            const SizedBox(height: 2),
            Text('Started: ${DateFormat('MMM dd').format(task.startDate)}'),
          ],
        ),
      ),
      
      OutlinedButton.icon(
        onPressed: onCompleteTask,
        icon: const Icon(Icons.check, size: 18),
        label: const Text('Mark as complete'),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.green.shade700,
          side: BorderSide(color: Colors.green.shade700),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    ],
  );
}

// UI for 'Completed' tasks
  Widget _buildCompletedSection() {
  return Row(
    children: [
      const Icon(Icons.check_circle, color: Colors.green),
      const SizedBox(width: 8),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Completed: ${DateFormat('MMM dd, yyyy').format(task.completedDate!)}'),
          const SizedBox(height: 2),
          Text(
            'Started: ${DateFormat('MMM dd, yyyy').format(task.startDate)}',
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    ],
  );
}

  Widget _buildBottomSection() {
  switch (task.status) {
    case TaskStatus.notStarted:
      return _buildNotStartedSection();
    case TaskStatus.started:
      return _buildStartedSection();
    case TaskStatus.completed:
      return _buildCompletedSection();
  }
}


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: ID and Title
            Text(
              '${task.id} : ${task.title}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),

            // Middle Row: Assignee and Priority
            Row(
              children: [
                Text(task.assignee),
                const SizedBox(width: 8),
                if (task.isHighPriority)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'High Priority',
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            ),
            const Divider(height: 24),


            // Bottom Section: This will be dynamic!
            // For now, it's a placeholder.
            _buildBottomSection(),
          ],
        ),
      ),
    );
  }
}
