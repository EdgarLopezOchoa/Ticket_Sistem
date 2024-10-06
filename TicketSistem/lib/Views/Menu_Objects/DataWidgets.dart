import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

//My Functions
import '../CRUD.dart';
import 'Menu_Functions.dart';
import 'Menu_Objects.dart';

class DataWidgets extends StatefulWidget {

  //My functions
  FireStoreServices fireStoreServices = FireStoreServices();
  final Menu_Objets menu_objets = Menu_Objets();



  SharedPreferences? preferences;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

  Widget build(BuildContext context) {
    return MaterialApp();
  }


  void ChagerPreferences() async {
    preferences = await SharedPreferences.getInstance();
  }

  Widget SnapshotData(BuildContext context) {
    final ScreenSize = MediaQuery.of(context);
    Size size = ScreenSize.size;

    ChagerPreferences();

    return Container(
      width: size.width,
      height: size.height - 138,
      child: Center(
          child: StreamBuilder(
            stream: fireStoreServices.ReadRequisition(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List listRequisition = snapshot.data!.docs;


                return menu_objets.ListTickets(listRequisition, preferences!);

              } else {
                return const Text("No Task Yet");
              }
            },
          )),
    );
  }

  Widget SnapshotDataUsers(BuildContext context, SharedPreferences preferences, String DocId) {
    final ScreenSize = MediaQuery.of(context);
    Size size = ScreenSize.size;


    return Container(
      width: size.width,
      height: size.height - 138,
      child: Center(
          child: StreamBuilder(
            stream: fireStoreServices.ReadUsers(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List ListUsers = snapshot.data!.docs;

                return menu_objets.ListUsers(ListUsers, preferences!,DocId);

              } else {
                return const Text("No Task Yet");
              }
            },
          )),
    );
  }
}

