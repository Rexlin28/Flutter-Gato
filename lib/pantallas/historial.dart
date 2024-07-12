import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../db/db.dart';
import '../db/resultado.dart';

class Historial extends StatefulWidget {
  const Historial({super.key});

  @override
  State<Historial> createState() => _HistorialState();
}

class _HistorialState extends State<Historial> {
  List<Resultado> historial = [];

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    query();
  }


  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(title: Wrap(children: [Text("Historial      "), Icon(Icons.history)],),),
      body: Builder(builder: (context)  {

        if(historial.isEmpty){
          return const Center(
              child: Column(
                children: [
                  CircularProgressIndicator(
                  color: Colors.blueGrey,),
                  Text("Aun sin datos")
                ],
              ),);
        }else{
          return Material(child: ListView.builder(itemCount: historial.length,
          itemBuilder: (context, index){
            return Card(
              child: ListTile(
                leading: const Icon(Icons.videogame_asset),
                title: Text("Juego Numero #${historial[index].id}!"),
                subtitle: Text("Cruz: ${historial[index].cruz} Circulo: ${historial[index].circulo} Empates: ${historial[index].empate}  Hora y Fecha: ${historial[index].fecha}"),
                tileColor: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),//Sacado de: https://stackoverflow.com/questions/51340588/flutter-how-can-i-make-a-random-color-generator-background
              ),
            );
          },),);
        }
      },),
    );
  }

  Future<void> query() async{
    historial = await DB.consulta().whenComplete((){
      setState(() {
      });
    });
  }
}
