import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasky_app/feature/home/data/model/add_user_model.dart';
import 'package:tasky_app/feature/home/data/model/task_model.dart';

class FireBaseFunction {
  /// ------------------ Task Collection ------------------
  static CollectionReference<TaskModel> getTaskCollection() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .collection("Tasks")
        .withConverter<TaskModel>(
          fromFirestore: (snapshot, _) => TaskModel.fromJson(snapshot.data()!),
          toFirestore: (task, _) => task.toJson(),
        );
  }

  /// إضافة مهمة جديدة
  static Future<void> addTask(TaskModel task) async {
    var collection = getTaskCollection();
    var docRef = collection.doc();
    task.id = docRef.id;
    await docRef.set(task);
  }

  /// تحديث حالة المهمة فقط (isDone)
  static Future<void> updateTaskDoneStatus(String taskId, bool isDone) async {
    await getTaskCollection().doc(taskId).update({
      'isDone': isDone,
    });
  }

  /// تحديث كامل بيانات المهمة
  static Future<void> updateTask(TaskModel taskModel) async {
    if (taskModel.id == null) return;
    await getTaskCollection().doc(taskModel.id).update(taskModel.toJson());
  }

  /// حذف مهمة
  static Future<void> deleteTask(String taskId) async {
    await getTaskCollection().doc(taskId).delete();
  }

  /// جلب المهام بتاريخ محدد
  static Stream<QuerySnapshot<TaskModel>> getTasks(DateTime date) {
    var collection = getTaskCollection();
    return collection
        .where(
          "date",
          isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch,
        )
        .snapshots();
  }

  /// ------------------ User Collection ------------------
  static CollectionReference<AddUserModel> getUserCollection() {
    return FirebaseFirestore.instance
        .collection("Users")
        .withConverter<AddUserModel>(
          fromFirestore: (snapshot, _) => AddUserModel.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson(),
        );
  }

  /// إضافة مستخدم جديد
  static Future<void> addUser(AddUserModel userModel) async {
    var collection = getUserCollection();
    var docRef = collection.doc(userModel.id);
    await docRef.set(userModel);
  }

  /// قراءة بيانات المستخدم الحالي
  static Future<AddUserModel?> readUser() async {
    var collection = getUserCollection();
    DocumentSnapshot<AddUserModel> docUser =
        await collection.doc(FirebaseAuth.instance.currentUser!.uid).get();
    return docUser.data();
  }

  /// ------------------ Authentication ------------------
  static Future<void> createAccount({
    required String email,
    required String password,
    required String name,
    required int age,
    required int phone,
    required Function onSuccess,
    required Function(String? error) onError,
  }) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      AddUserModel userModel = AddUserModel(
        id: credential.user!.uid,
        name: name,
        email: email,
        password: password,
      );
      await addUser(userModel);
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onError(e.message);
    } catch (e) {
      onError(e.toString());
    }
  }

  static Future<void> signInAccount({
    required String email,
    required String password,
    required Function onSuccess,
    required Function(String? error) onError,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onError(e.message);
    }
  }
}
