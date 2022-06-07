
import 'package:flutter/material.dart';

// Importacion Rutas de la Aplicacion
import 'package:biblioteca_digital_proyecto_cftic/routes/app_routes.dart';
import 'package:flutter/scheduler.dart';

import 'package:biblioteca_digital_proyecto_cftic/services/autentificacion.dart';
import 'conexion.dart';

class MenuApp extends StatelessWidget{
  const MenuApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    // Devuelve Multiprovider de paquete Provider para metodos Autentificacion Firebase
    return Scaffold(
        appBar: AppBar(
            title: const Text ('Biblioteca Online'),
            elevation: 0,
        ),
        body: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, i) =>
          ListTile(
            //hoverColor: Colors.brown,
            //iconColor: Colors.orangeAccent,
            leading: InkWell(
                splashColor: Colors.orangeAccent,
                child: Icon(AppRoutes.menuOpciones[i].icono)
            ),
            title: InkWell(
                splashColor: Colors.orangeAccent,
                child: Text(AppRoutes.menuOpciones[i].nombre)
            ),
            onTap: (){
              if (AppRoutes.menuOpciones[i].nombre == 'Desconexion') {
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  Autentificacion.signout(context: context);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const Conexion()));
                });
              } else {
                  Navigator.pushNamed(context, AppRoutes.menuOpciones[i].ruta);
              }
            },
          ),
          separatorBuilder: (_, __) => const Divider(),
          itemCount: AppRoutes.menuOpciones.length,
        ),
    );
  }

}

