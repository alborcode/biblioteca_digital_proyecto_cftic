
/*
* Clase Caja de Texto para importar donde se usen cajas de Texto en la APP
* Se pasará el controlador de forma obligatoria
* Como parametros opcionales se puede enviar
* el hinttext, el labeltext, el helpertext y el icono del prefijo
* tambien si se quiere mostrar texto (password)
* tambien se puede mandar el tipo de teclado a mostrar con ese campo de texto
* para rellenar email    -> TextInputType.emailAddress
* para rellenar texto    -> TextInputType.text
* para rellenar numeros  -> TextInputType.number
* para rellenar fechas   -> TextInputType.datetime
* para rellenar importes -> TextInputType.numberWithOptions
*/

import 'package:flutter/material.dart';

class CajaTexto extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final String? label;
  final String? helper;
  final IconData? icono;
  final TextInputType? teclado;
  final bool nomostrar;

  const CajaTexto({
    Key? key,
    required this.controller,
    this.hint,
    this.label,
    this.helper,
    this.icono,
    this.teclado,
    // Por defecto se muestra
    this.nomostrar = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: nomostrar,
      keyboardType: teclado,
      decoration: InputDecoration(
        // Condicionamos si se ha mandado el prefixIcon o no
        prefixIcon: icono == null ? null : Icon(icono),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.black, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.black, width: 1),
        ),
        contentPadding:
            const EdgeInsets.only(left: 10, top: 20, right: 10),
        filled: true,
        fillColor: const Color(0xffF5F6FA),
        hintText: hint,
        hintStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        labelText: label,
        helperText: helper
      ),
    );
  }
}
