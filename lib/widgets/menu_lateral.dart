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
import 'package:flutter/scheduler.dart';

import 'package:biblioteca_digital_proyecto_cftic/services/autentificacion.dart';

import 'package:biblioteca_digital_proyecto_cftic/theme/app_theme.dart';

// Importacion de Pantallas
import 'package:biblioteca_digital_proyecto_cftic/screens/screens.dart';
// Importamos Widgets personalizados
import 'package:biblioteca_digital_proyecto_cftic/widgets/widgets.dart';

class MenuLateral extends StatelessWidget {

  const MenuLateral({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Envolvemos en Center el ElevatedButton para que los muestre centrados
    // y del tamaño del icono y texto y no expanda los botones
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Primer item la cabecera
          /*const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.brown
              ),
              child: Text('Menu Biblioteca',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14
                ),
              )
          ),*/
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.brown),
            accountName: Text(
              "Alberto Rubio & Antonio Turel",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(
              "proyectoflutter2022@gmail.com",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            currentAccountPicture: FlutterLogo(),
          ),
          ListTile(
            leading: const Icon(Icons.assignment_ind),
            title: const Text('Busqueda por Autor'),
            // Actualiza el estado de la aplicación
            onTap: () {
              // Cierra el drawer
              Navigator.pop(context);
              // Se envia a pagina Busqueda de Autor
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) =>
                  const BusquedaAutor()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.app_registration),
            title: const Text('Busqueda por Titulo'),
            onTap: () {
              // Cierra el drawer
              Navigator.pop(context);
              // Se envia a pagina Busqueda por Titulo
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) =>
                  const BusquedaTitulo()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.bookmark),
            title: const Text('Busqueda por Tematica'),
            onTap: () {
              // Cierra el drawer
              Navigator.pop(context);
              // Se envia a pagina Busqueda Tematica
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) =>
                  const BusquedaTematica()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.start),
            title: const Text('Alta Libro'),
            onTap: () {
              // Cierra el drawer
              Navigator.pop(context);
              // Se envia a pagina Busqueda de Autor
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) =>
                  const AltaLibro()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Desconectarse'),
            onTap: () {
              // Cierra el drawer
              Navigator.pop(context);
              //sign out
              SchedulerBinding.instance.addPostFrameCallback((_) {
                // AL presionar se desconecta
                Autentificacion.signout(context: context);
                // Se envia a pantalla de conexion
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Conexion()));
              });
            },
          ),
          AboutListTile(
            icon: const Icon(
              Icons.info,
            ),
            /*applicationIcon: Image.asset(
              'assets/images/Books.png',
              width: 55.0,
              height: 55.0,
            ),*/
            applicationIcon: const Icon(
              Icons.book,
            ),
            applicationName: 'Biblioteca Online',
            applicationVersion: '1.0.0',
            applicationLegalese: '© 2022 A.Rubio & A.Turel',
            aboutBoxChildren: [
              const SizedBox(height: 20),
              RichText(
                text: const TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      style: TextStyle(color: Colors.brown),
                        text: "Aplicacion Biblioteca Online donde podras compartir y "
                              "descargar libros de licencia libre (Creative Commons). "),
                  ],
                ),
              ),
            ],
            child: const Text('Acerca de'),
          ),
        ],
      ),
    );
  }
}
