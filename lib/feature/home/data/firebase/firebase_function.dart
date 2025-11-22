import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasky_app/feature/home/data/model/add_user_model.dart';
import 'package:tasky_app/feature/home/data/model/task_model.dart';

class FireBaseFunction {
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

  static Future<void> addTask(TaskModel task) {
    var collection = getTaskCollection();
    var docRef = collection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static addUser(AddUserModel userModel) {
    var collection = getUserCollection();
    var docRef = collection.doc(userModel.id);
    docRef.set(userModel);
  }

  static Stream<QuerySnapshot<TaskModel>> getTasks(DateTime date) {
    var collection = getTaskCollection();
    return collection
        .where(
          "date",
          isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch,
        )
        .snapshots();
  }

  static Future<AddUserModel?> readUser() async {
    var collection = getUserCollection();
    DocumentSnapshot<AddUserModel> docUser =
        await collection.doc(FirebaseAuth.instance.currentUser!.uid).get();
    return docUser.data();
  }

  static Future<void> deletTask(String id) {
    return getTaskCollection().doc(id).delete();
  }

  static ubdateTask(TaskModel taskModel) {
    return getTaskCollection().doc(taskModel.id).update(taskModel.toJson());
  }

  static createAccount(
    String emailAddress,
    String password, {
    required Function onSuccess,
    required Function onError,
    required String name,
    required int age,
    required int phone,
  }) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      AddUserModel userModel = AddUserModel(
        id: credential.user!.uid,
        name: name,
        email: emailAddress,
        password: password,
      );
      addUser(userModel);
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onError(e.message);
    } catch (e) {
      onError(e.toString());
    }
  }

  static signInAccount(String emailAddress, String password,
      {required Function onSuccess, required Function onError}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onError(e.message);
    }
  }

  static CollectionReference<AddUserModel> getUserCollection() {
    return FirebaseFirestore.instance
        .collection("Users")
        .withConverter<AddUserModel>(
      fromFirestore: (snapshot, _) {
        return AddUserModel.fromJson(snapshot.data()!);
      },
      toFirestore: (user, _) {
        return user.toJson();
      },
    );
  }
}
