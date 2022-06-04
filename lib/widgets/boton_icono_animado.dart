/*
*
* CLASE PARA CREAR UN BOTON CON ICONO ANIMADO QUE CAMBIE DE COLOR
* Se enviara como parametros
* - icono: de tipo Icondata (Icons.nombredeicono)
* - texto: texto que aparecerá en el botón
* - accion: funcion que se ejecutará al presionar el botón
*
 */

import 'package:flutter/material.dart';


class BotonIconoAnimado extends StatelessWidget {
  final IconData icono;
  final String texto;
  // La accion es de tipo Callback ya que se envia una funcion con la accion
  final VoidCallback accion;

  const BotonIconoAnimado({
    Key? key,
    required this.icono,
    required this.texto,
    required this.accion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Envolvemos en Center el ElevatedButton para que los muestre centrados
    // y del tamaño del icono y texto y no expanda los botones
    return Center(
      child: ElevatedButton.icon(
        // Definicion de Estilos del boton
        style: ButtonStyle(
          overlayColor: getColor(Colors.white, Colors.orangeAccent),
          foregroundColor: getColor(Colors.white, Colors.black),
          backgroundColor: getColor(Colors.brown, Colors.white),
          side: getBorder(Colors.transparent, Colors.black54),
          // Redondeado del boton
        ),
        // Icono a mostrar en el boton
        icon: Icon(
          // Icono pasado por parametro
          icono,
          color: Colors.black,
          size: 24.0,
        ),
        // Texto y estilo del texto del boton
        label: Text(texto,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            // wordSpacing: 1,
            // letterSpacing: 1
          ),
        ),
        onPressed: accion,
        // onLongPress: accion,
      ),
    );
  }

  MaterialStateProperty<Color> getColor(Color color, Color colorPressed){
    final getColor = (Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)){
        return colorPressed;
      }else{
        return color;
      }
    };
    return MaterialStateProperty.resolveWith(getColor);
  }

  MaterialStateProperty<BorderSide> getBorder(Color color, Color colorPressed){
    final getBorder = (Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)){
        return BorderSide(color: colorPressed, width: 2);
      }else{
        return BorderSide(color: color, width: 2);
      }
    };
    return MaterialStateProperty.resolveWith(getBorder);
  }

}
