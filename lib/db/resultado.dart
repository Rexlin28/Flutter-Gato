

class Resultado{
  int? id;
  int? circulo;
  int? cruz;
  int? empate;
  String? fecha;


  Resultado( this.circulo, this.cruz, this.empate);

  Resultado.frontMap(Map<String, dynamic> mapa){
    id = mapa["id"];
    circulo = mapa["circulo"];
    cruz = mapa["cruz"];
    empate = mapa["empate"];
    fecha = mapa["fecha"];
  }

  Map<String, dynamic> mapeador(){
    return{
      "id":id,
      "cruz":cruz,
      "circulo":circulo,
      "empate":empate,
      "fecha":fecha
    };
  }
}