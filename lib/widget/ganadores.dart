

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config/config.dart';

class Ganadores {

  void elGanador <Widget>(BuildContext context, String ganador, Function resetBoard){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(shape: RoundedRectangleBorder(),
      content: Card(
        child: Column(
          children: [Text("JUEGO TERMINADO"),
          SizedBox(height: 10,),
          Text("El ganador es: $ganador"),
          SizedBox(height: 10,),
          ElevatedButton(onPressed: (){
            resetBoard();
            Navigator.of(context).pop();
          }, child: Text("Nuevo Juego")),
          SizedBox(height: 10,),
            ElevatedButton(onPressed: (){exit(0);}, child: Text("Salir"))
          ],
        ),
      ),
      );
    });
  }
}