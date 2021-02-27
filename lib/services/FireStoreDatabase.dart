import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FireStoreDatabase {

   static FirebaseFirestore firestore  = FirebaseFirestore.instance;

  static Future<void> addTask(Map<String,dynamic> tasks) async {

    try {
     return await firestore.collection('tasks').add(tasks);
    } catch (e) {
      print("er : "+e);
    }
  }


   static Future<void> updateTask(String id, Map<String, dynamic> task) async {
     await firestore.collection('tasks').doc(id).update(task).catchError((e) {
       print(e);
     });
     return true;
   }

   static Future<void> deleteTask(String id) async {
     await firestore.collection('tasks').doc(id).delete().catchError((e) {
       print(e);
     });
     return true;
   }


}