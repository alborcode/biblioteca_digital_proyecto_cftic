//import 'dart:html';

//import 'dart:html';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Importacion de Pantallas
import 'package:biblioteca_digital_proyecto_cftic/screens/screens.dart';

// Importamos Widgets personalizados
import 'package:biblioteca_digital_proyecto_cftic/widgets/widgets.dart';
import 'package:path_provider/path_provider.dart';


class BusquedaAutor extends StatefulWidget {
  // Se define ruta de PantallaLoginEmail
  const BusquedaAutor({Key? key}) : super(key: key);

  @override
  BusquedaAutorState createState() => BusquedaAutorState();
}

class BusquedaAutorState extends State<BusquedaAutor> {
  final TextEditingController busquedaController = TextEditingController();

  // Funcion para vaciar controladores
  void _reset() {
    busquedaController.clear();
  }

  // Variables para el foco
  final FocusNode _busquedaFocus = FocusNode();

  //final String urlbuscar = "https://apibiblioteca.azurewebsites.net/biblioteca/GetAutor/";
  final String urlbuscar = "https://apibiblioteca.azurewebsites.net/biblioteca/GetAutores/";
  String urlapi = "";

  // La variable data recupera los datos del webapi en una lista o coleccion
  List? data;

  String mensajeStatus = "";

  // Create a reference from an HTTPS URL Note that in the URL, characters are URL escaped!

  // Create a storage reference from our app
  final storageRef = FirebaseStorage.instance.ref('/Image').listAll();

  //final httpsReference = FirebaseStorage.instance.refFromURL(
  // "https://firebasestorage.googleapis.com/b/YOUR_BUCKET/o/images%20stars.jpg");
  // gs://biblioteca-online-flutter.appspot.com/Image/1654077777068.jpg


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text('BIBLIOTECA ONLINE',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                }
            )
        ),
        endDrawer: const MenuLateral(),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Texto de Pantalla
              const Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Text(
                  "Busqueda por Autor",
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Padding(
                // Definimos margenes entre Titulo y primera caja
                padding: const EdgeInsets.only(left: 10, top: 30, right: 10),
                child: CajaTexto(
                  controller: busquedaController,
                  hint: 'Introduce autor libro a buscar',
                  icono: Icons.search,
                  nomostrar: false,
                  teclado: TextInputType.text,
                ),
              ),
              Row(
                // Centra los elementos en la fila horizontalmente
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    // Añado margenes entre botones y con respecto a la caja
                    padding: const EdgeInsets.only(
                        top: 30, left: 10, right: 10),
                    child: BotonIcono(
                      accion: () {
                        getLibrosAutor(busquedaController.text);
                        _busquedaFocus.unfocus();
                        _reset();
                        if (data == null) {
                          mensajeStatus =
                          'No se han encontrados datos para la busqueda';
                          mensaje(context, mensajeStatus);
                        }
                      },
                      icono: Icons.search,
                      texto: 'Buscar',
                    ),
                  ),
                ],
              ),
              // Añadimos Linea Divisoria
              const Divider(
                thickness: 5,
                color: Colors.brown,
              ),
              Expanded(
                  child: listado()
              ),
            ]
        )
    );
  }


  ListView listado() {
    return ListView.builder(
      // El numero de elementos será la longitud de la lista data
      itemCount: data == null ? 0 : data!.length,
      // Por cada registro recorro el json
      itemBuilder: (BuildContext context, int index) {
        return Container(
            padding: const EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
            child: Card(
                elevation: 0,
                color: Colors.transparent,
                child: Column(
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: <Widget>[
                                const Text("Título: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey)),
                                // Añadimos el toString dado que el campo es numerico
                                Text(data![index]["titulo"],
                                    style: const TextStyle(
                                        fontSize: 16.0, color: Colors.black)),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                const Text("Autor: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey)),
                                // Añadimos el toString dado que el campo es numerico
                                Text(data![index]["autor"],
                                    style: const TextStyle(
                                        fontSize: 16.0, color: Colors.black)),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                const Text("Temática: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey)),
                                // Admiracion dado que es nulable
                                Text(data![index]["tematica"],
                                    style: const TextStyle(
                                        fontSize: 16.0, color: Colors.black)),
                              ],
                            ),
                          ]
                      ),
                      Row(
                        // Alineamos Icono en Fila despues de Datos
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                                backgroundColor: Colors.brown,
                                foregroundColor: Colors.white,
                                child: IconButton(
                                    icon: const Icon(Icons.download_rounded),
                                    splashColor: Colors.brown,
                                    // Al presionar en boton muestra dialogo de descarga
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (ctx) =>
                                              AlertaDialogo(
                                                  titulo: "Descargar",
                                                  texto: "Pulse boton descargar para descargar este libro a su dispositivo",
                                                  textoBoton1: "Descargar",
                                                  textoBoton2: "Cancelar",
                                                  // Accion de Descarga
                                                  accion: () async {
                                                    /*final httpsReference = FirebaseStorage.instance.refFromURL(
                                                  data![index]["urlDescarga"]);
                                              // Llamada a url guarda para descargar
                                              //final islandRef = storageRef.child("images/island.jpg");

                                              final appDocDir = await getApplicationDocumentsDirectory();
                                              final filePath = "${appDocDir.absolute}/image/island.jpg";
                                              final file = File(filePath);
                                              //final file = File(httpsReference)

                                              final downloadTask = httpsReference.writeToFile(file);
                                              downloadTask.snapshotEvents.listen((taskSnapshot) {
                                                switch (taskSnapshot.state) {
                                                  case TaskState.running:
                                                  // TODO: Handle this case.
                                                    break;
                                                  case TaskState.paused:
                                                  // TODO: Handle this case.
                                                    break;
                                                  case TaskState.success:
                                                  // TODO: Handle this case.
                                                    break;
                                                  case TaskState.canceled:
                                                  // TODO: Handle this case.
                                                    break;
                                                  case TaskState.error:
                                                  // TODO: Handle this case.
                                                    break;*/
                                                    //_donwloadFile(file);
                                                  }
                                              )
                                      );
                                    }
                                )
                            )
                          ]
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top:5.0),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                    ]
                )
            )
        );
      },
    );
  }



// Generamos con Future funcion asincrona getDoctoresData
// Tipo Future que devolvera un String (al ser consulta)
Future<String> getLibrosAutor(String filtro) async {
  urlapi = "$urlbuscar$filtro";
  // Para poder usar await el metodo tiene que ser asincrono en el Future
  var res = await http.get(
      Uri.parse(urlapi), headers: {"Accept": "application/json"});
  // Entrara en SetState cuando haya obtenido los resultados
  //listado();
  setState(() {
    data = json.decode(res.body);
    //var resBody = json.decode(res.body);
    // resBody["titulo"];
    // resBody["Autor"];
    // resBody["Teamtica"];

    // Deserializamos el body del Json en String
    // var resBody = json.decode(res.body);
    // Se vuelca en la lista el array de results
    // data = resBody["Empleados"];
    // Se recoge sin variable

  });
  return "Realizado!";
}

 /* Future _donwloadFile(Reference ref) async {
    final dir = await getApplicationDocumentsDirectory();
    final filepath = "${dir}/image/";
    final file = File('${dir.path}/${ref.name}');
    //final file = File(data![index]["urlDescarga"]);

    await ref.writeToFile(file);

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Downloaded ${ref.name}')));
  }*/

}
