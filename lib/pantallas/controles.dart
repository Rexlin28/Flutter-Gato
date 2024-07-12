import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gato/db/db.dart';
import '../config/config.dart';
import '../db/resultado.dart';
import '../widget/celda.dart';
import '../widget/estasSeguro.dart';
import '../widget/ganadores.dart';
import '../widget/save.dart';
import 'historial.dart';

class Controles extends StatefulWidget {
  const Controles({super.key});

  @override
  State<Controles> createState() => _ControlesState();
}

class _ControlesState extends State<Controles> {
  estados inicial = estados.cruz;
  int contador = 0;
  int circulear = 0;
  int empatear = 0;
  int cruzar = 0;
  Ganadores ganador = Ganadores();

  @override
  Widget build(BuildContext context) {
    double ancho, alto;
    ancho = MediaQuery.of(context).size.width;
    alto = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text("El Gato"),
        actions: [
          PopupMenuButton(
            onSelected: (value) async {
              if (value == "Reset") {
                setState(() async {
                  Seguro check = Seguro();
                  await check.asegurar(context);
                  debugPrint(check.checar.toString());
                  if (check.checar) {
                    resetBoard();
                  }
                });

                // nada
              }else if(value == "Bases"){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Historial()));
              }else if (value == "Salir") {
                setState(() async {
                  Seguro reseteo = Seguro();
                  await reseteo.asegurar(context);
                  if (reseteo.checar) {
                    Save saving = Save();
                    await saving.guardando(context);
                    if(saving.verificador){
                      Resultado res = Resultado(this.cruzar, this.circulear, this.empatear);
                      DB db = DB();
                      await db.insertar(res);
                    }
                    exit(0);
                  }
                });
              }else if(value =="Guardar"){
                Resultado res = Resultado(this.circulear, this.cruzar, this.empatear);
                DB db = DB();
                await db.insertar(res);
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Reset',
                child: Text('Nuevo Juego'),
              ),
              const PopupMenuItem<String>(
                value: 'Bases',
                child: Text('Historial'),
              ),
              const PopupMenuItem<String>(
                value: 'Salir',
                child: Text('Salir'),
              ),
              const PopupMenuItem<String>(
                value: 'Guardar',
                child: Text('Guardar'),
              )],
          )
        ],
      ),
      body: Center(
        child: Stack(children: [
          Image.asset("imagenes/board.png"),
          SizedBox(
            width: ancho,
            height: alto,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: ancho,
                    height: ancho,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Celda(
                                  inicial: tablero[0],
                                  alto: ancho / 3,
                                  ancho: ancho / 3,
                                  press: () => press(0)),
                              Celda(
                                  inicial: tablero[1],
                                  alto: ancho / 3,
                                  ancho: ancho / 3,
                                  press: () => press(1)),
                              Celda(
                                  inicial: tablero[2],
                                  alto: ancho / 3,
                                  ancho: ancho / 3,
                                  press: () => press(2)),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Celda(
                                  inicial: tablero[3],
                                  alto: ancho / 3,
                                  ancho: ancho / 3,
                                  press: () => press(3)),
                              Celda(
                                  inicial: tablero[4],
                                  alto: ancho / 3,
                                  ancho: ancho / 3,
                                  press: () => press(4)),
                              Celda(
                                  inicial: tablero[5],
                                  alto: ancho / 3,
                                  ancho: ancho / 3,
                                  press: () => press(5)),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Celda(
                                  inicial: tablero[6],
                                  alto: ancho / 3,
                                  ancho: ancho / 3,
                                  press: () => press(6)),
                              Celda(
                                  inicial: tablero[7],
                                  alto: ancho / 3,
                                  ancho: ancho / 3,
                                  press: () => press(7)),
                              Celda(
                                  inicial: tablero[8],
                                  alto: ancho / 3,
                                  ancho: ancho / 3,
                                  press: () => press(8)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: [
                      Text("Circulo: $circulear"),
                      SizedBox(height: 10),
                      Text("Cruz: $cruzar"),
                      SizedBox(height: 10),
                      Text("Empate: $empatear"),
                    ],
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoButton(
                  child: Text("Salir"),
                  onPressed: () async {
                    Save saving = Save();
                    await saving.guardando(context);
                    if(saving.verificador){
                      Resultado res = Resultado(this.cruzar, this.circulear, this.empatear);
                      DB db = DB();
                      await db.insertar(res);
                    }
                    exit(0);
                  }),
              CupertinoButton(
                  child: Text("Reiniciar"),
                  onPressed: () {
                    resetBoard();
                    this.circulear = 0;
                    this.empatear = 0;
                    this.cruzar = 0;
                  }),
              CupertinoButton(
                  child: Text("Juego Nuevo"),
                  onPressed: () {
                    resetBoard();
                  })
            ],
          ),
        ),
      ),
    );
  }

  void press(int index) {
    debugPrint("presionado");
    if (tablero[index] == estados.vacio) {
      tablero[index] = inicial;
      inicial = inicial == estados.cruz ? estados.circulo : estados.cruz;
      setState(() {});
      if (++contador >= 4) {
        for (int i = 0; i < tablero.length; i += 3) {
          iguales(i, i + 1, i + 2);
        }
        for (int i=0; i<3; i++){
          iguales(i, i+3, i+6);
        }
        iguales(0, 4, 8);
        iguales(2, 4, 6);
        debugPrint(resultado.toString());
        if (resultado[estados.cruz] == true) {
          // cruz
          debugPrint("Gana la cruz");
          contador = 0;
          cruzar++;
          ganador.elGanador(context, "Cruz", resetBoard, this.circulear, this.cruzar, this.empatear);
          points[estados.cruz] = (points[estados.cruz] ?? 0) + 1;
        } else if (resultado[estados.circulo] == true) {
          //circulo
          debugPrint("Gana el circulo");
          contador = 0;
          circulear++;
          ganador.elGanador(context, "Circulo", resetBoard,this.circulear, this.cruzar, this.empatear);
          points[estados.circulo] = (points[estados.circulo] ?? 0) + 1;
        } else if (contador >= 9) {
          //empate
          debugPrint("EMPATADOS!!!");
          contador = 0;
          empatear++;
          ganador.elGanador(context, "EMPATEE!!", resetBoard,this.circulear, this.cruzar, this.empatear);
          points[estados.vacio] = (points[estados.vacio] ?? 0) + 1;
        }
      }
    }
  }

  void iguales(int a, int b, int c) {
    if (tablero[a] != estados.vacio) {
      if (tablero[a] == tablero[b] && tablero[b] == tablero[c]) {
        resultado[tablero[a]] = true;
      }
    }
  }

  void resetBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        tablero[i] = estados.vacio;
      }
      resultado[estados.cruz] = false;
      resultado[estados.circulo] = false;
      inicial = estados.cruz;
    });
  }
}
