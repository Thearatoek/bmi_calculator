// ignore: depend_on_referenced_packages
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:online/feature/auth_provider/authetication.dart';
import 'package:online/model/auth_model.dart';
import 'package:online/model/user_model.dart';

part 'bloc_event.dart';
part 'bloc_state.dart';

class BlocBloc extends Bloc<BlocEvent, BlocState> {
  BlocBloc() : super(BlocInitial()) {
    on<BlocEvent>((event, emit) {});
    on<BMICalculatorEvent>(_onCalculateBMI);
    on<BMIthearaEvent>(_onthearaEvent);
    on<RegisterUserEvent>(_onRegisterUser);
    on<RecordedEvent>(_onLoadingDataFirebase);
    on<SignOutEvent>(_onSignOut);
    on<DeleteEvent>(_onDeleteData);
    on<LoginEvent>(_onLoginUser);
    on<UpdateUserProfileEvent>(_onUpdateUserProfile);
    on<InitialEvent>((event, emit) async {
      emit(LoadingState());
      await Future.delayed(const Duration(seconds: 3), () {
        if (_auth.currentUser == null) {
          emit(RegisterUserState());
        } else {
          emit(BMIthearaState());
        }
      });
    });

    on<BMIStoreEvent>(_onStoreData);
  }

//Declaration
  User? user;
  var auth = UserAuth();
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('client');
  CollectionReference userimage = FirebaseFirestore.instance.collection('user_image');
  final _auth = FirebaseAuth.instance;
  List<UserModel> data = [];

//Login
  Future<User?> _onLoginUser(LoginEvent event, emit) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: '${event.authUser.email}',
        password: '${event.authUser.password}',
      );
      // Signed in
      User? user = userCredential.user;
      if (user != null) {
        emit(LoginState());
      }
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        print('Error: ${e.message}');
      }
    }
    return null;
  }

//Loading data from firebase
  Future<void> _onLoadingDataFirebase(RecordedEvent event, emit) async {
    try {
      final response = FirebaseFirestore.instance.collection('client').where('uid', isEqualTo: _auth.currentUser?.uid).get();
      await response.then((snapshot) {
        for (var document in snapshot.docs) {
          data.add(UserModel.fromJson(document.data()));
          debugPrint(document.data().toString());
        }
        emit(RecordedState(data));
      });
    } catch (e) {
      print(e);
    }
  }

// Register user in firebase
  Future<void> _onRegisterUser(RegisterUserEvent event, emit) async {
    try {
      await auth.registerAccount('${event.authUser.email}', '${event.authUser.password}');
      print('user has success register');
      emit(RegisterUserState());
    } catch (e) {
      print('Could not register this user because of $e');
    }
  }

// post data to store in cloud firebase
  void _onStoreData(BMIStoreEvent event, emit) {
    var usermodel = UserModel(
        result: event.userModel.result,
        weight: event.userModel.weight,
        height: event.userModel.height,
        gender: event.userModel.gender,
        age: event.userModel.age);
    postToFirestore(usermodel);

    emit(BMIStoreDataState(usermodel));
  }

// Function post data to cloud
  Future<void> postToFirestore(UserModel userModel) async {
    User? user = _auth.currentUser;
    try {
      if (user != null) {
        String uid = user.uid;

        await collectionReference.add({
          'uid': uid,
          'age': userModel.age,
          'weight': userModel.weight,
          'height': userModel.height,
          'result': userModel.result,
          'gender': userModel.gender
        });
      } else {}
    } catch (e) {
      print(e);
    }
  }

  Future _onUpdateUserProfile(UpdateUserProfileEvent event, emit) async {
    await updateUserImage(event.userProfile);
    print('User already update his profile');
  }

  //update image user

  Future<void> updateUserImage(String image) async {
    User? user = _auth.currentUser;
    try {
      if (user != null) {
        String uid = user.uid;
        await userimage.add({'uid': uid, 'image': image});
      }
    } catch (e) {
      print('e');
    }
  }

// Function calculate BMI value
  void _onCalculateBMI(BMICalculatorEvent event, emit) {
    double result = 0;
    double a = double.parse(event.usermodel!.height.toString()) / 100;
    result = (double.parse(event.usermodel!.weight.toString()) / pow(a, 2));
    var usermodel = UserModel(
        result: result, age: event.usermodel?.age, height: event.usermodel?.height, weight: event.usermodel?.weight, gender: event.usermodel?.gender);
    emit(BMICalculateState(userModel: usermodel));
  }

  _onthearaEvent(BMIthearaEvent event, emit) {
    emit(BMIthearaState());
  }

  //Sign out user

  Future<void> _onSignOut(SignOutEvent event, emit) async {
    try {
      await _auth.signOut();
      emit(RegisterUserState());
      print('User signed out');
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  Future<void> _onDeleteData(DeleteEvent event, emit) async {
    try {
      await collectionReference.doc('uid').delete();
      print('Document deleted successfully');
    } catch (e) {
      print('Error deleting document: $e');
    }
  }
}
