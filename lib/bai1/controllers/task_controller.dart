import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task_model.dart';

class TaskController {
  final CollectionReference _tasksCollection = FirebaseFirestore.instance.collection('tasks');

  // Lấy danh sách task theo thời gian thực
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

  // Thêm task và bắt lỗi đồng bộ
  Future<void> addTask(String title) async {
    try {
      // Thêm vào Firestore
      DocumentReference ref = await _tasksCollection.add({
        'title': title,
        'isDone': false,
        'createdAt': Timestamp.now(),
      });
      print("ĐÃ GỬI LÊN SERVER THÀNH CÔNG! ID: ${ref.id}");
    } on FirebaseException catch (e) {
      print("LỖI FIREBASE (Code: ${e.code}): ${e.message}");
      rethrow;
    } catch (e) {
      print("LỖI KHÔNG XÁC ĐỊNH: $e");
      rethrow;
    }
  }

  Future<void> updateTaskStatus(String id, bool isDone) async {
    try {
      await _tasksCollection.doc(id).update({'isDone': isDone});
      print("Đã cập nhật trạng thái lên server");
    } catch (e) {
      print("Lỗi cập nhật: $e");
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      await _tasksCollection.doc(id).delete();
      print("Đã xóa trên server");
    } catch (e) {
      print("Lỗi xóa: $e");
    }
  }
}
