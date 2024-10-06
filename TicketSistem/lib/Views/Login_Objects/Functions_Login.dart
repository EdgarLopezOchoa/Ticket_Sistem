import 'package:quickalert/quickalert.dart';
import 'package:ticketsistem/Views/Menu.dart';

import '../CRUD.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Functions_Login extends StatefulWidget {
  SharedPreferences? preferences;
  final firebase_auth.FirebaseAuth aunth = firebase_auth.FirebaseAuth.instance;
  final FireStoreServices fireStoreServices = FireStoreServices();
  QuickAlert Loading_Alert = QuickAlert();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

  Widget build(BuildContext context) {
    ChagerPreferences();
    return MaterialApp();
  }

  void ChagerPreferences() async {
    preferences = await SharedPreferences.getInstance();
  }

  getUser(String id) async {
    DocumentSnapshot snapshot =
    await FirebaseFirestore.instance.collection("users").doc(id).get();

    if (snapshot.exists) {
      preferences?.setInt("Level_User", snapshot.get("Level"));
      preferences?.setInt("Id_User", snapshot.get("Id"));
      preferences?.setString("User_Name", snapshot.get("Name"));
      preferences?.setString("Area", snapshot.get("Area"));
    }
  }

  SignUp(BuildContext context, TextEditingController nameText,
      TextEditingController passwordText) async {
    ChagerPreferences();

    firebase_auth.User? user = await fireStoreServices.SignIn(
        nameText.text, passwordText.text, context);

    if (user != null) {
      preferences?.setString("Email", nameText.text);

      await getUser(user.uid);


      Navigator.of(
          context).push(MaterialPageRoute(builder: (context) => Menu()));

    }
  }
}
