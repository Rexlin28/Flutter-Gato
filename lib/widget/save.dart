

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Save{
  bool verificador = false;
  Future<void> guardando (BuildContext context) async{
    await showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(shape: RoundedRectangleBorder(),
        content: Container(
          width: 500,
          height: 250,
          child: Card(

            child: Column(
              children: [
                Text("Quieres guardar el progreso?"),
                SizedBox(height: 5,),
                ElevatedButton(onPressed: () async{
                  this.verificador = true;
                  Navigator.of(context).pop();
                }, child: Text("Aceptar")),
                SizedBox(height: 5,),
                ElevatedButton(onPressed: () async{
                  this.verificador = false;
                  Navigator.of(context).pop();
                }, child: Text("Cancelar")),
              ],
            ),
          ),
        ),);
    }

    );

  }
}