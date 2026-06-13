import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../shared/models/task.dart';

class TaskService {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    final FirebaseAuth _auth = FirebaseAuth.instance;

    CollectionReference<Map<String, dynamic>> get _taskCollection {

        final uid = _auth.currentUser!.uid;

        return _firestore
            .collection('users')
            .doc(uid)
            .collection('tasks');
    }

    Future<void> createTask(Task task) async {
        await _taskCollection.add(
            task.toFirestore(),
        );
    }

    Future<void> updateTask(Task task) async {
        await _taskCollection
            .doc(task.id)
            .update(
                task.toFirestore(),
            );
    }

    Future<void> toggleCompleted(String taskId, bool completed) async {
        await _taskCollection
            .doc(taskId)
            .update({
                'completed': completed,
                'updatedAt':
                    FieldValue.serverTimestamp(),
        });
    }

    Future<void> deleteTask(String taskId) async {
        await _taskCollection
            .doc(taskId)
            .delete();
    }

    Stream<List<Task>> getTasks() {
        return _taskCollection
            .orderBy('dateTime')
            .snapshots()
            .map((snapshot) {

            return snapshot.docs
                .map(
                (doc) =>
                    Task.fromFirestore(doc),
                )
                .toList();
            }
        );
    }
}

