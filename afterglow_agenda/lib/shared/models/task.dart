import 'package:cloud_firestore/cloud_firestore.dart';

enum Recurrence {
  none,
  daily,
  weekly,
  monthly,
  yearly,
}

class Task {
  final String id;

  final String title;

  final bool completed;

  final int color;

  final DateTime dateTime;

  final Recurrence recurrence;

  final int? durationMinutes;

  final DateTime createdAt;

  final DateTime? updatedAt;

  final String? description;

  const Task({
    required this.id,
    required this.title,
    required this.completed,
    required this.color,
    required this.dateTime,
    required this.recurrence,
    this.durationMinutes,
    required this.createdAt,
    this.updatedAt,
  });
}