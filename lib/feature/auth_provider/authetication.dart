import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online/model/user_model.dart';

class UserAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> registerAccount(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print('Failed to create user: $e');
    }
  }

  final _auth = FirebaseAuth.instance;
  final List<UserModel> data = [];
  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('client');

  Future<void> saveUidToFirestore() async {
    try {
      // Get the currently signed-in user
      User? user = _auth.currentUser;

      if (user != null) {
        // Save the UID to Firestore with the UID as the document ID
        await _usersCollection.doc(user.uid).set({
          'uid': user.uid,
          // Add other user-related information as needed
        });

        print('UID saved to Firestore successfully!');
      } else {
        print('No user is currently signed in.');
      }
    } catch (e) {
      print('Error saving UID to Firestore: $e');
    }
  }

  Future<void> onLoadingDataFirebase() async {
    try {
      final response = FirebaseFirestore.instance.collection('client').where('uid', isEqualTo: _auth.currentUser?.uid).get();
      await response.then((snapshot) {
        for (var document in snapshot.docs) {
          debugPrint(document.data().toString());

          data.add(UserModel.fromJson(document.data()));
          debugPrint(data.toString());
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return null;
  }

  Future<void> _deleteData(String id) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Reference to the document you want to delete
      DocumentReference documentReference = firestore.collection('client').doc(id);

      // Delete the document
      await documentReference.delete();
    } catch (e) {
      print('Error deleting document: $e');
    }
  }
}
