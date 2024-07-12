import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../db/db.dart';
import 'controles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}



class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    abrirDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Center(
        child: Stack(
          children: [ Controles()],
        ),
      ),

    );
  }

  void abrirDB() {
    DB.db().whenComplete(() async {
      //await agregar();
      debugPrint("abriendoDB");
    });
  }
}
