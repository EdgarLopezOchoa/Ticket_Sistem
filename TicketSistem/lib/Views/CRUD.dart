import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FireStoreServices {
  CollectionReference UserCreate =
      FirebaseFirestore.instance.collection("users");
  CollectionReference TicketsCreate =
      FirebaseFirestore.instance.collection("tickets");
  SharedPreferences? preferences;

  //Create user
  Future<void> CreateTicket(String Description, String Area,
      SharedPreferences preferences, BuildContext context) {
    QuickAlert.show(
      autoCloseDuration: Duration(seconds: 3),
      context: context,
      type: QuickAlertType.success,
    );
    return TicketsCreate.add({
      "Description": Description,
      "Area": Area,
      "Id_User_Assign": 0,
      "Name_User_Assign": "",
      "Id_User": preferences?.getInt("Id_User"),
      "Name_User": preferences?.getString("User_Name").toString(),
      "Urgencia": "Low",
      "status": "activo",
      "Scale": "",
    });
  }

  void ChagerPreferences() async {
    preferences = await SharedPreferences.getInstance();
  }

  Future<User?> SignIn(
      String email, String password, BuildContext context) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential userCredential;
      userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      return userCredential.user;
    } catch (e) {
      print("nooooooooooooooooooo $e");
      QuickAlert.show(
          autoCloseDuration: Duration(seconds: 5),
          context: context,
          type: QuickAlertType.error,
          text: "Wrong Password or E-mail");
    }
  }

  Future<User?> SignUp(String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return userCredential.user;
  }

  Stream<QuerySnapshot> ReadRequisition() {
    final Requisition =
        TicketsCreate.orderBy("Urgencia", descending: false).snapshots();
    return Requisition;
  }

  Stream<QuerySnapshot> ReadUsers() {
    final Users = UserCreate.snapshots();
    return Users;
  }

  Future<void> UpdateUserAssign(
      String DocId, String Name, int Id, int scale, String Status) {
    String Scale = "";
    if (scale == 1) {
      Scale = "Ha Sido reescalado por dificultades";
    }

    if (Status == "Resuelto") {
      Scale = "Resuelto";
    }

    return TicketsCreate.doc(DocId).update({
      "Name_User_Assign": Name,
      "Id_User_Assign": Id,
      "Scale": Scale,
      "status": Status,
    });
  }

  Future<void> DeleteTask(String DocId) {
    return TicketsCreate.doc(DocId).delete();
  }

  Future<void> UpdateTicketUrgency(String Urgency, String DocId) {

    return TicketsCreate.doc(DocId).update({
      "Urgencia": Urgency,
    });
  }
}
