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

    factory Task.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc,) {
        final data = doc.data()!;

        return Task(
        id: doc.id,
        title: data['title'] ?? '',
        completed: data['completed'] ?? false,
        color: data['color'] ?? 0xFF2196F3,
        dateTime:
            (data['dateTime'] as Timestamp)
                .toDate(),
        recurrence: Recurrence.values.firstWhere(
            (value) =>
                value.name ==
                data['recurrence'],
            orElse: () => Recurrence.none,
        ),
        durationMinutes:
            data['durationMinutes'],
        createdAt:
            (data['createdAt'] as Timestamp)
                .toDate(),
        updatedAt:
            data['updatedAt'] != null
                ? (data['updatedAt']
                        as Timestamp)
                    .toDate()
                : null,
        );
    }

    Map<String, dynamic> toFirestore() {
        return {
        'title': title,
        'completed': completed,
        'color': color,
        'dateTime': Timestamp.fromDate(
            dateTime,
        ),
        'recurrence': recurrence.name,
        'durationMinutes':
            durationMinutes,
        'createdAt': Timestamp.fromDate(
            createdAt,
        ),
        'updatedAt': updatedAt != null
            ? Timestamp.fromDate(
                updatedAt!,
                )
            : null,
        };
    }
}