import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../config/config.dart';
import '../widget/celda.dart';
import '../widget/ganadores.dart';

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

    return SizedBox(
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
    );
  }

  void press(int index) {
    debugPrint("presionado");
    if (tablero[index] == estados.vacio) {
      tablero[index] = inicial;
      inicial = inicial == estados.cruz ? estados.circulo : estados.cruz;
      setState(() {});
      if (++contador >= 5) {
        for (int i = 0; i < tablero.length; i += 3) {
          iguales(i, i + 1, i + 2);
        }
        iguales(0, 4, 8);
        iguales(2, 4, 6);
        debugPrint(resultado.toString());
        if (resultado[estados.cruz] == true) { // cruz
          debugPrint("Gana la cruz");
          ganador.elGanador(context, "Cruz", resetBoard);
          contador = 0;
          cruzar++;
        } else if (resultado[estados.circulo] == true) { //circulo
          debugPrint("Gana el circulo");
          ganador.elGanador(context, "Circulo", resetBoard);
          contador = 0;
          circulear++;
        } else if (contador >= 9) { //empate
          debugPrint("EMPATADOS!!!");
          ganador.elGanador(context, "EMPATEE!!", resetBoard);
          contador = 0;
          empatear++;
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
