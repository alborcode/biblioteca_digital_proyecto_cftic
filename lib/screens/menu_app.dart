
import 'package:flutter/material.dart';

// Importacion Rutas de la Aplicacion
import 'package:biblioteca_digital_proyecto_cftic/routes/app_routes.dart';

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
          itemBuilder: (context, i) =>
              ListTile(
                leading: Icon(AppRoutes.menuOpciones[i].icono),
                title: Text(AppRoutes.menuOpciones[i].nombre),
                onTap: (){
                  Navigator.pushNamed(context, AppRoutes.menuOpciones[i].ruta);
                },
              ),
          separatorBuilder: (_, __) => const Divider(),
          itemCount: AppRoutes.menuOpciones.length,
        )
    );
  }
}