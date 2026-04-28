import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task_model.dart';

class FirestoreService {
  final CollectionReference _tasksCollection = FirebaseFirestore.instance.collection('tasks');

  // Stream of tasks
  Stream<List<TaskModel>> get tasks {
    return _tasksCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return TaskModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  // Add task
  Future<void> addTask(String title) {
    return _tasksCollection.add({
      'title': title,
      'isDone': false,
      'createdAt': Timestamp.now(),
    });
  }

  // Update task status
  Future<void> updateTaskStatus(String id, bool isDone) {
    return _tasksCollection.doc(id).update({'isDone': isDone});
  }

  // Delete task
  Future<void> deleteTask(String id) {
    return _tasksCollection.doc(id).delete();
  }
}
