import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../main.dart';

class Menu_Functions extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

  void SignOutLog(BuildContext context) async {
    Navigator.of(
        context).push(MaterialPageRoute(builder: (context) => MyApp()));
  }

  Widget build(BuildContext context) {
    return MaterialApp();
  }




}