import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:voltify/core/database/cache_helper.dart';
import 'package:voltify/core/fun.dart';
import 'package:voltify/features/Authentication/data/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  TextEditingController name = TextEditingController();
  TextEditingController emailUP = TextEditingController();
  TextEditingController passwordUP = TextEditingController();
  TextEditingController phone = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  signupAccount() async {
    try {
      emit(SignUpLoading());
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailUP.text,
        password: passwordUP.text,
      );
      UserModel userModel = UserModel(
        name: name.text,
        email: emailUP.text,
        phone: phone.text,
        password: passwordUP.text,
      );
      await addUser(userModel);
      emit(SignUpSuccess());
      log("--------------------");
      log("Account Created Successfully");
      log("--------------------");
    } on FirebaseAuthException catch (e) {
      emit(SignUpError(e.code));
      log(e.code);
    }
  }

  TextEditingController emailIn = TextEditingController();
  TextEditingController passwordIn = TextEditingController();
  saveTheDatainSharedPref() async {
    String? docID = await getDocID();
    log(docID.toString());
    await FirebaseFirestore.instance
        .collection("users")
        .doc(docID)
        .get()
        .then((value) {
      log(value.data().toString());
      CacheHelper.saveData(key: "name", value: value.data()!["name"]);
      CacheHelper.saveData(key: "email", value: value.data()!["email"]);
      CacheHelper.saveData(key: "phone", value: value.data()!["phone"]);
      log("-------------------");
      log(CacheHelper.getData(key: "name").toString());
      log("-------------------");
      log(CacheHelper.getData(key: "email").toString());
    });
  }

  signInAccount() async {
    try {
      emit(SignInLoading());

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailIn.text,
        password: passwordIn.text,
      );
      saveTheDatainSharedPref();
      emit(SignInSuccess());
    } on FirebaseAuthException catch (e) {
      emit(SignInError(e.code));
      log(e.code);
    }
  }

  addUser(UserModel userModel) async {
    await users.add(
      userModel.toMap(),
    );
  }
}
