/*
*
* CLASE PARA CREAR UN BOTON FLOTANTE (FloatingActionButton)
* Se enviara como parametros
* - icono: de tipo Icondata (Icons.nombredeicono)
* - accion: funcion que se ejecutará al presionar el botón
*
 */

import 'package:flutter/material.dart';

import 'package:biblioteca_digital_proyecto_cftic/theme/app_theme.dart';

class BotonFlotante extends StatelessWidget {

  const BotonFlotante({
    Key? key,
    required this.icono,
    required this.accion,
  }) : super(key: key);

  final IconData icono;
  // La accion es de tipo Callback ya que se envia una funcion con la accion
  final VoidCallback accion;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppTheme.primario,
      onPressed: accion,
      child: Icon (
          icono,
          color: Colors.black,
          size: 24.0,
      ),
    );
  }
}
