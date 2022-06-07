/*
*
* CLASE PARA CREAR UN ALERT DIALOG
* Se enviara como parametros
* - titulo: titulo de alerta
* - texto: texto de alerta
* Esta clase debe envolverse en un showDialog:
* showDialog(
*   barrierDismissible: false,
*   context: context,
*   builder: ( context) {
*     return AlertaDialogo(titulo: 'Alerta', texto: 'Texto Alerta')
*   }
* )
*/

import 'package:flutter/material.dart';

import 'package:biblioteca_digital_proyecto_cftic/theme/app_theme.dart';

  // Revisar si es funcion o se genera con
  // @override
  // Widget build(BuildContext context) {
class AlertaDialogo extends StatelessWidget {

  final String titulo;
  final String texto;
  final VoidCallback accion;
  final String textoBoton1;
  final String textoBoton2;

  const AlertaDialogo({
    Key? key,
    required this.titulo,
    required this.texto,
    required this.accion,
    required this.textoBoton1,
    this.textoBoton2 = "Cancelar"
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 5,
      title: Text(titulo),
      content: Column(
          // Ajustamos el contenido de la alerta al texto
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(texto),
            const SizedBox(height: 10,)
          ],
      ),
      actions: [
        TextButton(
          onPressed:accion,
          child: Text(textoBoton1,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(textoBoton2,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}