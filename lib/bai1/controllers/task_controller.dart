import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task_model.dart';

class TaskController {
  final CollectionReference _tasksCollection = FirebaseFirestore.instance.collection('tasks');

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

  Future<void> addTask(String title) {
    return _tasksCollection.add({
      'title': title,
      'isDone': false,
      'createdAt': Timestamp.now(),
    });
  }

  Future<void> updateTaskStatus(String id, bool isDone) {
    return _tasksCollection.doc(id).update({'isDone': isDone});
  }

  Future<void> deleteTask(String id) {
    return _tasksCollection.doc(id).delete();
  }
}
