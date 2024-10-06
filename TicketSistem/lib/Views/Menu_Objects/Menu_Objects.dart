import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticketsistem/Views/CRUD.dart';
import 'package:ticketsistem/Views/Menu_Objects/Buttons_Menu.dart';
import 'package:ticketsistem/Views/Menu_Objects/DataWidgets.dart';
import '../../Themes/AppThemes.dart';

class Menu_Objets extends StatefulWidget {
  final Buttons_Menu buttons_menu = Buttons_Menu();
  final EmergencyList = ["Low", "Normal", "High", "Critic"];
  String UrgencyTicket = "";
  final FireStoreServices fireStoreServices = FireStoreServices();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

  Widget build(BuildContext context) {
    return MaterialApp();
  }

  Widget ListTickets(List listRequisition, SharedPreferences preferences) {
    return ListView.builder(
        itemCount: listRequisition.length,
        itemBuilder: (context, index) {
          DocumentSnapshot document = listRequisition[index];
          String DocId = document.id;

          Map<String, dynamic> data = document.data() as Map<String, dynamic>;

          String Name_User = data["Name_User"];
          String Description = data["Description"];
          String Urgencia = data["Urgencia"];
          String Area = data["Area"];
          String User_Assign_Name = data["Name_User_Assign"];
          int User_Assign_Id = data["Id_User_Assign"];
          String Scale_Ticket = data["Scale"];
          String Status = data["status"];

          Container DescriptionTicket;
          Container UserName;
          Container Urgency_Level;
          Container User_Assign;
          Container Scale;

          Color colors = AppThemes.colors.white;
          DescriptionTicket =
              TextCards("", "times", FontWeight.bold, 14, Colors.orange);
          UserName = TextCards("", "times", FontWeight.bold, 14, Colors.orange);
          Urgency_Level =
              TextCards("", "times", FontWeight.bold, 14, Colors.orange);
          User_Assign = TextCards(
              "No User Assigned", "times", FontWeight.bold, 14, Colors.orange);
          Scale =
              TextCards(Scale_Ticket, "times", FontWeight.bold, 14, Colors.red);

          if (Scale_Ticket == "Resuelto") {
            Scale = TextCards(
                Scale_Ticket, "times", FontWeight.bold, 20, Colors.amber);
          }

          //Validation Area
          if (Urgencia == "Low") {
            colors = AppThemes.colors.GreenCardAccent;

            DescriptionTicket = TextCards(
                Description, "times", FontWeight.bold, 20, Colors.green);
            UserName = TextCards(
                "User: $Name_User", "times", FontWeight.bold, 14, Colors.green);
            Urgency_Level = TextCards("Urgency: $Urgencia", "times",
                FontWeight.bold, 14, Colors.green);
            if (User_Assign_Name != "") {
              User_Assign = TextCards("User Assign: $User_Assign_Name", "times",
                  FontWeight.bold, 14, Colors.green);
            }
          } else if (Urgencia == "Normal") {
            colors = AppThemes.colors.BlueCard;

            DescriptionTicket = TextCards(
                Description, "times", FontWeight.bold, 20, Colors.blueAccent);
            UserName = TextCards("User: $Name_User", "times", FontWeight.bold,
                14, Colors.blueAccent);
            Urgency_Level = TextCards("Urgency: $Urgencia", "times",
                FontWeight.bold, 14, Colors.blueAccent);
            if (User_Assign_Name != "") {
              User_Assign = TextCards("User Assign: $User_Assign_Name", "times",
                  FontWeight.bold, 14, Colors.blueAccent);
            }
          } else if (Urgencia == "High") {
            colors = AppThemes.colors.YellowCard;

            DescriptionTicket = TextCards(
                Description, "times", FontWeight.bold, 20, Colors.orange);
            UserName = TextCards("User: $Name_User", "times", FontWeight.bold,
                14, Colors.orange);
            Urgency_Level = TextCards("Urgency: $Urgencia", "times",
                FontWeight.bold, 14, Colors.orange);
            if (User_Assign_Name != "") {
              User_Assign = TextCards("User Assign: $User_Assign_Name", "times",
                  FontWeight.bold, 14, Colors.orange);
            }
          } else if (Urgencia == "Critic") {
            colors = AppThemes.colors.RedCard.withOpacity(0.4);

            DescriptionTicket = TextCards(
                Description, "times", FontWeight.bold, 20, Colors.red);
            UserName = TextCards(
                "User: $Name_User", "times", FontWeight.bold, 14, Colors.red);
            Urgency_Level = TextCards(
                "Urgency: $Urgencia", "times", FontWeight.bold, 14, Colors.red);
            if (User_Assign_Name != "") {
              User_Assign = TextCards("User Assign: $User_Assign_Name", "times",
                  FontWeight.bold, 14, Colors.red);
            }
          }


            return CardTicket(
                Name_User,
                Area,
                Description,
                Status,
                User_Assign_Name,
                DescriptionTicket,
                Scale,
                UserName,
                Urgency_Level,
                Urgencia,
                User_Assign,
                User_Assign_Id,
                DocId,
                colors,
                preferences,
                context);

        });
  }

  Widget CardTicket(
      String Name_User,
      String Area,
      String Description,
      String status,
      String User_Assign_Name,
      Container DescriptionTicket,
      Container Scale,
      Container UserName,
      Container TextUrgency,
      String Urgency,
      Container User_Assign,
      int User_Assign_Id,
      String DocId,
      Color CardColor,
      SharedPreferences preferences,
      BuildContext context) {
    if (Area == preferences.getString("Area") || Name_User == preferences.getString("User_Name")) {
      return Container(
        padding: EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 10),
        margin: EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 0),
        child: Card(
          elevation: 0,
          color: CardColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: ResolvedTicket(context, preferences, DocId,
                        User_Assign_Id, Name_User, status),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: ScaleTicket(
                        context, preferences, DocId, User_Assign_Id, status),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                child: DescriptionTicket,
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                child: UserName,
              ),
              DropDownUrgency(Urgency, DocId, preferences, TextUrgency),
              Container(
                margin: EdgeInsets.only(top: 5),
                padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                child: User_Assign,
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                child: Scale,
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AssignToMe(context, preferences, DocId, User_Assign_Name),
                      AssignUser(context, preferences, DocId),
                    ],
                  )),
            ],
          ),
        ),
      );
    }else{
      return Container();
    }
  }

  Widget ListUsers(
      List ListUsers, SharedPreferences preferences, String DocId) {
    return ListView.builder(
        itemCount: ListUsers.length,
        itemBuilder: (context, index) {
          DocumentSnapshot document = ListUsers[index];

          Map<String, dynamic> data = document.data() as Map<String, dynamic>;

          String Name_User = data["Name"];
          String Cargo = data["Cargo"];
          String Area = data["Area"];
          int Id_User = data["Id"];

          if (Area == preferences.getString("Area")) {
            return CardUsers(Name_User, Cargo, DocId, Name_User, Id_User,
                preferences, context);
          }
        });
  }

  Widget CardUsers(
      String Name_User,
      String Description,
      String DocId,
      String Name,
      int Id,
      SharedPreferences preferences,
      BuildContext context) {
    final ScreenSize = MediaQuery.of(context);
    Size size = ScreenSize.size;
    return Container(
      width: size.width,
      padding: EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 0),
      margin: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 0),
      child: Card(
        elevation: 0.7,
        color: AppThemes.colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 0),
              child: Text(Name_User,
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: "times",
                      fontWeight: FontWeight.bold,
                      color: Colors.orange)),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text("Cargo: $Description",
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: "times",
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent)),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: AssignUserTicket(context, preferences, DocId, Name, Id),
            ),
          ],
        ),
      ),
    );
  }

  DropDownUrgency(String Urgency, String DocId, SharedPreferences preferences,
      Container TextUrgency) {
    if (preferences.getInt("Level_User")! >= 2) {
      return Container(
        width: 150,
        height: 55,
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.only(left: 10, right: 10, top: 5),
        child: DropdownButtonFormField(
          value: Urgency,
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
          icon: const Icon(
            Icons.arrow_drop_down_circle,
            color: Colors.blueAccent,
          ),
          items: EmergencyList.map((e) {
            return DropdownMenuItem(
                child: TextCards(
                    e, "times", FontWeight.normal, 14, Colors.blueAccent),
                value: e);
          }).toList(),
          onChanged: (val) {
            {
              UrgencyTicket = val as String;
              fireStoreServices.UpdateTicketUrgency(UrgencyTicket, DocId);
            }
          },
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.only(left: 10, right: 10, top: 5),
        child: TextUrgency,
      );
    }
  }

  TextCards(String Tittle, String FontFamily, FontWeight fontWeight,
      double fontsize, Color color) {
    return Container(
      child: Text(
        Tittle,
        style: TextStyle(
            fontFamily: FontFamily,
            fontWeight: fontWeight,
            fontSize: fontsize,
            color: color),
      ),
    );
  }

  AssignToMe(BuildContext context, SharedPreferences preferences, String DocId,
      String User_Assign_Name) {
    if (User_Assign_Name == "") {
      return buttons_menu.Button_assigntome(context, preferences, DocId);
    }
    return Container();
  }

  AssignUser(
      BuildContext context, SharedPreferences preferences, String DocId) {
    if (preferences.getInt("Level_User")! >= 2) {
      return buttons_menu.Button_assign(context, preferences, DocId);
    }
    return Container();
  }

  AssignUserTicket(BuildContext context, SharedPreferences preferences,
      String DocId, String Name, int Id) {
    if (preferences.getInt("Level_User")! >= 2) {
      return buttons_menu.Button_assignUser(
          context, preferences, DocId, Name, Id);
    }
    return Container();
  }

  ScaleTicket(BuildContext context, SharedPreferences preferences, String DocId,
      int Id_User, String Status) {
    if (preferences.getInt("Id_User")! == Id_User && Status != "Resuelto") {
      return buttons_menu.Button_Scale(context, preferences, DocId);
    }
    return Container();
  }

  ResolvedTicket(BuildContext context, SharedPreferences preferences,
      String DocId, int Id_User, String Name_User, String Status) {
    if (preferences.getInt("Id_User")! == Id_User && Status != "Resuelto") {
      return buttons_menu.Button_resolved(
          context, preferences, DocId, Id_User, Name_User);
    }
    return Container();
  }
}
