import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticketsistem/Views/CRUD.dart';
import 'package:ticketsistem/Views/Menu_Objects/Buttons_Menu.dart';

//My Widgets
import 'package:ticketsistem/Views/Menu_Objects/DataWidgets.dart';
import 'package:ticketsistem/Views/Menu_Objects/Menu_Objects.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(Menu());
}

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Mi App',
      home: Inicio(),
    );
  }

  DialogAddUser(
      BuildContext context, SharedPreferences preferences, String DocId) {
    final DataWidgets dataWidgets = DataWidgets();
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Container(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                height: 740,
                child: Column(
                  children: [
                    dataWidgets.SnapshotDataUsers(context, preferences, DocId),
                  ],
                ),
              ),
            ));
  }
}

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Inicio> {
  //DataBase References
  final firebase_auth.FirebaseAuth aunth = FirebaseAuth.instance;

  //Credential storage
  SharedPreferences? preferences;
  String User_Name = "";
  String AreaTask ="";

  //My Widgets
  final Menu_Objets menuObjets = Menu_Objets();
  final DataWidgets dataWidgets = DataWidgets();
  final Buttons_Menu buttons_menu = Buttons_Menu();

  //Objects
  TextEditingController DescriptionText = TextEditingController();
  TextEditingController AreaText = TextEditingController();
  final ListAreas = ["Sistemas", "RH", "Ventas", "Almancen", "Produccion"];

  @override
  void initState() {
    ChagerPreferences();
    super.initState();
  }

  void ChagerPreferences() async {
    preferences = await SharedPreferences.getInstance();
    User_Name = preferences!.getString("User_Name")!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Menu_Body());
  }

  //AlertDialog To Create a New Task

  Widget Menu_Body() {
    return Scaffold(
        appBar: AppBar(
          title: Text("Tickets"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            DialogAddTicket(context, DescriptionText, AreaText, preferences!);
          },
          child: const Icon(Icons.add),
        ),
        body: Tickets());
  }

  //Function to Search Task in Database
  Widget Tickets() {
    return Container(
      child: Center(
        child: Column(
          children: [
            buttons_menu.SignOut(context, User_Name),
            dataWidgets.SnapshotData(context),
          ],
        ),
      ),
    );
  }

  DialogAddTicket(
      BuildContext context,
      TextEditingController Descrition_Controller,
      TextEditingController Area_Controller,
      SharedPreferences preferences) {
    FireStoreServices fireStoreServices = FireStoreServices();
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Container(
                height: 150,
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: TextField(
                        controller: Descrition_Controller,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Decripcion del asunto",
                        ),
                      ),
                    ),
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        margin: EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: DropdownButtonFormField(

                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          icon: const Icon(
                            Icons.arrow_drop_down_circle,
                            color: Colors.blueAccent,
                          ),
                          items: ListAreas.map((e) {
                            return DropdownMenuItem(child: Text(e), value: e);
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              AreaTask = val as String;
                              print( "nooooooooo $AreaTask");
                            });
                          },
                        )),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      fireStoreServices.CreateTicket(Descrition_Controller.text,
                          AreaTask, preferences, context);

                      DescriptionText.clear();
                      AreaText.clear();

                      Navigator.pop(context);
                    },
                    child: Text("REGISTER"))
              ],
            ));
  }
}
