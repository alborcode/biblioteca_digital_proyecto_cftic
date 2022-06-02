// CLASE ESTATICA DE RUTAS PARA USO SIN NECESIDAD DE INSTANCIAR CLASE

import 'package:flutter/material.dart';

// Importacion de Pantallas
import 'package:biblioteca_digital_proyecto_cftic/screens/screens.dart';

import 'package:biblioteca_digital_proyecto_cftic/models/menu_opciones.dart';

class AppRoutes{

  // Definicion estatica de ruta inicial
  // uso initialRoute: AppRoutes.rutaInicial
  static const rutaInicial = '/home';

  // Definicion estatica de Mapa de Rutas
  // uso onGenerateRoute: AppRoutes.rutas
  static Map<String, Widget Function (BuildContext)> rutas = {
    '/Registro'       : (BuildContext contest) => const Registro(),
    '/Conexion'       : (BuildContext contest) => const Conexion(),
    '/Home'           : (BuildContext contest) => const Inicio(),
    /*'/BuscarAutor'    : (BuildContext contest) => const BusquedaAutor(),*/
    '/BuscarTitulo'   : (BuildContext contest) => const BusquedaTitulo(),
    '/BuscarTematica' : (BuildContext contest) => const BusquedaTematica(),
    '/AltaLibro'      : (BuildContext contest) => const AltaLibro(),
  };

  // Definicion estatica de OnGenerateRoute
  // uso onGenerateRoute: AppRoutes.rutaInexistente
  static Route<dynamic> rutaInexistente (RouteSettings settings) {
    return MaterialPageRoute(
        builder: (context) => const Inicio (),
    );
  }

  // Definicion de Menu como objeto con Ruta
  static final menuOpciones = <MenuOpcion>[
    MenuOpcion(
      ruta: '/BuscarAutor',
      nombre: 'Busqueda por Autor',
      pantalla: const BusquedaAutor(),
      icono: Icons.assignment_ind,
    ),
    MenuOpcion(
        ruta: '/BuscarTitulo',
        nombre: 'Busqueda por Titulo',
        pantalla: const BusquedaTitulo(),
        icono: Icons.app_registration
    ),
    MenuOpcion(
        ruta: '/BuscarTematica',
        nombre: 'Busqueda por Temática',
        pantalla: const BusquedaTematica(),
        icono: Icons.bookmark
    ),
    MenuOpcion(
        ruta: '/AltaLibro',
        nombre: 'Subir Libro',
        pantalla: const AltaLibro(),
        icono: Icons.start
    ),
  ];

  // Definicion para generar rutas de forma dinamica
  static Map<String, Widget Function (BuildContext)> getAppRoutes() {
    Map<String, Widget Function (BuildContext)> appRoutes = {};
    for (final opcion in menuOpciones){
      appRoutes.addAll({opcion.ruta: (BuildContext context) => opcion.pantalla});
    }
    return appRoutes;
  }

}