/*
*
* CLASE PARA CREAR UN BOTON CON ICONO
* Se enviara como parametros
* - icono: de tipo Icondata (Icons.nombredeicono)
* - texto: texto que aparecerá en el botón
* - accion: funcion que se ejecutará al presionar el botón
*
 */

import 'package:flutter/material.dart';

import 'package:biblioteca_digital_proyecto_cftic/theme/app_theme.dart';

class BotonIconosinTexto extends StatelessWidget {
  final IconData icono;
  // La accion es de tipo Callback ya que se envia una funcion con la accion
  final VoidCallback accion;

  const BotonIconosinTexto({
    Key? key,
    required this.icono,
    required this.accion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Envolvemos en Center el ElevatedButton para que los muestre centrados
    // y del tamaño del icono y texto y no expanda los botones
    return Center(
      child: CircleAvatar(
        backgroundColor: Colors.brown,
        child: IconButton(
          color: Colors.white,
          icon: Icon(icono),
          onPressed: accion,
        ),
      ),
    );
  }
}
