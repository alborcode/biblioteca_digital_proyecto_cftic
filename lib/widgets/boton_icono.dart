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

class BotonIcono extends StatelessWidget {
  final IconData icono;
  final String texto;
  // La accion es de tipo Callback ya que se envia una funcion con la accion
  final VoidCallback accion;

  const BotonIcono({
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
        style: ElevatedButton.styleFrom(
          // Color primario de nuestro tema
          primary: AppTheme.primario,
          onPrimary: Colors.white,
          onSurface: Colors.grey,
          shadowColor: Colors.black,
          elevation: 5,
          // Redondeado del boton
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
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
}
