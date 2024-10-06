import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticketsistem/Views/CRUD.dart';
import 'package:ticketsistem/Views/Menu.dart';
import 'package:ticketsistem/Views/Menu_Objects/Menu_Functions.dart';

class Buttons_Menu extends StatefulWidget {
  final Menu menu = Menu();
  Menu_Functions menu_functions = Menu_Functions();
  final FireStoreServices fireStoreServices = FireStoreServices();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

  Widget build(BuildContext context) {
    return MaterialApp();
  }

  Widget Button_assign(
      BuildContext context, SharedPreferences preferences, String DocId) {
    return Container(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 20, bottom: 10),
      child: ElevatedButton.icon(
        onPressed: () {
          menu.DialogAddUser(context, preferences, DocId);
        },
        icon: const Icon(Icons.check),
        label: const Text("assign",
            style: TextStyle(
                fontSize: 18, fontFamily: "Times ", color: Colors.black)),
      ),
    );
  }

  Widget Button_assigntome(
      BuildContext context, SharedPreferences preferences, String DocId) {
    String? name = "";
    int? id = 0;
    name = preferences.getString("User_Name");
    id = preferences.getInt("Id_User");
    return Container(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 20, bottom: 10),
      child: ElevatedButton.icon(
        onPressed: () {
          fireStoreServices.UpdateUserAssign(DocId, name!, id!, 0,"");
        },
        icon: const Icon(Icons.check),
        label: const Text("assign me",
            style: TextStyle(
                fontSize: 18, fontFamily: "Times ", color: Colors.black)),
      ),
    );
  }

  Widget Button_assignUser(BuildContext context, SharedPreferences preferences,
      String DocId, String Name, int Id) {
    print("$DocId $Name $Id");
    return Container(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 20, bottom: 10),
      child: ElevatedButton.icon(
        onPressed: () {
          fireStoreServices.UpdateUserAssign(DocId, Name, Id, 0,"");
          Navigator.pop(context);
        },
        icon: const Icon(Icons.check),
        label: const Text("assign",
            style: TextStyle(
                fontSize: 18, fontFamily: "Times ", color: Colors.black)),
      ),
    );
  }

  Widget Button_Scale(
      BuildContext context, SharedPreferences preferences, String DocId) {
    return Container(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 20, bottom: 10),
      child: ElevatedButton.icon(
        onPressed: () {
          fireStoreServices.UpdateUserAssign(DocId, "", 0, 1,"");
        },
        icon: const Icon(Icons.check),
        label: const Text("Scale",
            style: TextStyle(
                fontSize: 18, fontFamily: "Times ", color: Colors.black)),
      ),
    );
  }

  Widget Button_resolved(BuildContext context, SharedPreferences preferences,
      String DocId, int Id, String Name) {
    return Container(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 20, bottom: 10),
      child: ElevatedButton.icon(
        onPressed: () {
          fireStoreServices.UpdateUserAssign(DocId, Name, Id, 0,"Resuelto");
        },
        icon: const Icon(Icons.check),
        label: const Text("Resolved",
            style: TextStyle(
                fontSize: 18, fontFamily: "Times ", color: Colors.black)),
      ),
    );
  }

  Widget SignOut(BuildContext context, String userName) {
    return Container(
        padding: const EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 5),
        margin: EdgeInsets.only(left: 20),
        child: Center(
          child: Row(
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  menu_functions.SignOutLog(context);
                },
                icon: const Icon(Icons.login_rounded),
                label: const Text("Sign Out",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Times ",
                        color: Colors.black87)),
              ),
              Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Text(
                    "Usuario:",
                    style: TextStyle(
                        fontFamily: "Times", fontWeight: FontWeight.bold),
                  )),
              Container(
                  child: Text(
                    " $userName",
                    style: TextStyle(fontFamily: "Times"),
                  )),
            ],
          ),
        ));
  }
}
