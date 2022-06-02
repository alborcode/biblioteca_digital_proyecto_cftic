// Clase para creacion de Menu Opcion

import 'package:flutter/material.dart' show IconData, Widget;

class MenuOpcion {
  final String ruta;
  final IconData icono;
  final String nombre;
  final Widget pantalla;

  MenuOpcion({
    required this.ruta,
    required this.icono,
    required this.nombre,
    required this.pantalla
  });
}