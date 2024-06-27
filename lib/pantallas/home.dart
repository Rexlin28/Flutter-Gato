import 'dart:io';
import 'package:gato/widget/estasSeguro.dart';
import 'package:restart_app/restart_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'controles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text("El Gato"),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == "Reset") {
                setState(() async {
                  Seguro check = Seguro();
                  check.asegurar(context);
                  bool algo = check.checar;
                  if (algo) {
                    Restart.restartApp();
                  }
                });

                // nada
              } else if (value == "Salir") {
                setState(() async {
                  Seguro reseteo = Seguro();
                  reseteo.asegurar(context);
                  bool algo2 = reseteo.checar;
                  if (algo2) {
                    exit(0);
                  }
                });
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Reset',
                child: Text('Nuevo Juego'),
              ),
              const PopupMenuItem<String>(
                value: 'Salir',
                child: Text('Salir'),
              ),
            ],
          )
        ],
      ),
      body: Center(
        child: Stack(
          children: [Image.asset("imagenes/board.png"), Controles()],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          child: Row(
            children: [
              CupertinoButton(
                  child: Text("salir"),
                  onPressed: () {
                    exit(0);
                  }),
              CupertinoButton(
                  child: Text("Reiniciar"),
                  onPressed: () {
                    Restart.restartApp();
                  }),
              CupertinoButton(
                  child: Text("Juego Nuevo"),
                  onPressed: () {
                    Restart.restartApp();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
