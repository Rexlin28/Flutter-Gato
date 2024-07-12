import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gato/widget/save.dart';
import '../db/db.dart';
import '../db/resultado.dart';
import '../config/config.dart';


class Ganadores {
  int circulo = 0;
  int cruz = 0;
  int empate = 0;
  void elGanador <Widget>(BuildContext context, String ganador, Function resetBoard, int circulo, int cruz, int empate){
    this.circulo = circulo;
    this.cruz = cruz;
    this.empate = empate;
    showDialog(context: context, builder: (BuildContext context){
      return Container(
        height: 200,
        width: 500,
        child: AlertDialog(shape: RoundedRectangleBorder(),
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
              ElevatedButton(onPressed: ()async{
                Save saving = Save();
                await saving.guardando(context);
                if(saving.verificador) {

                  Resultado res = Resultado(circulo, cruz, empate);
                  DB db = DB();
                  await db.insertar(res);
                  debugPrint("holaa ${res.toString()}");
                }
                exit(0);
                }, child: Text("Salir"))
            ],
          ),
        ),
        ),
      );
    });
  }
}