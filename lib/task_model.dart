// CORRECT lib/task_model.dart

enum TaskStatus {
  notStarted,
  started,
  completed,
}

class Task {
  final String id;
  final String title;
  final String assignee;
  final bool isHighPriority;
  TaskStatus status;
  DateTime startDate;
  DateTime? completedDate;

  Task({
    required this.id,
    required this.title,
    required this.assignee,
    this.isHighPriority = false,
    this.status = TaskStatus.notStarted,
    required this.startDate,
    this.completedDate,
  });
}