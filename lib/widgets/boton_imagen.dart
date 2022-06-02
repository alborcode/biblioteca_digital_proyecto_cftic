/*
 *
 * Clase que genera un boton con Imagen
 * Necesario para usar Icono Google que no existe en Flutter
 *
 */

import 'package:flutter/material.dart';

import 'package:biblioteca_digital_proyecto_cftic/theme/app_theme.dart';

class BotonImagen extends StatelessWidget {
  // la accion del boton y el texto son obligatorios
  const BotonImagen({
    Key? key,
    required this.nombreicono,
    required this.texto,
    required this.accion,
  }) : super(key: key);

  final String nombreicono;
  final String texto;
  // La accion es de tipo Callback ya que se envia una funcion con la accion
  final VoidCallback accion;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          constraints: const BoxConstraints(
            //maxWidth: 130,
            maxHeight: 34,
          ),
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
            //icon: Icon(icono),
            icon: Image.asset('assets/icons/$nombreicono.png',
                  height: 24,
                  fit: BoxFit.fitHeight,
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
        ),
      ],
    );
  }
}
