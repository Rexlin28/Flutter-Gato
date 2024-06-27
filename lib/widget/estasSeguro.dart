

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Seguro {

  bool checar = false;
  void asegurar <Widget>(BuildContext context){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(shape: RoundedRectangleBorder(),
      content: Card(
        child: Column(
          children: [
            Text("ESTAS SEGURO???"),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: () async{
              this.checar = true;

              Navigator.of(context).pop();
            }, child: Text("Aceptar")),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: () async{
              this.checar = false;
              Navigator.of(context).pop();
            }, child: Text("Cancelar")),
          ],
        ),
      ),);
    }

    );

  }
}