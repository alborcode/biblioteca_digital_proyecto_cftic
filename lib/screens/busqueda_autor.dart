
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Importar libreria para acceso documentos locales
import 'package:path_provider/path_provider.dart';

import 'dart:io';

// Importacion de Pantallas
import 'package:biblioteca_digital_proyecto_cftic/screens/screens.dart';

// Importamos Widgets personalizados
import 'package:biblioteca_digital_proyecto_cftic/widgets/widgets.dart';


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

  String nombrefichero = "";

  // Create a reference from an HTTPS URL Note that in the URL, characters are URL escaped!

  // Create a storage reference from our app
  final storageRef = FirebaseStorage.instance.ref();

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
                                      nombrefichero = data![index]["urlDescarga"];
                                      ventanaDescarga(context, nombrefichero);
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

  void ventanaDescarga(BuildContext context, nombrefichero) {
    showDialog
      (context: context,
        builder: (ctx) => AlertaDialogo(
            titulo: "Descargar",
            texto: "Pulse boton descargar para descargar este libro a su dispositivo",
            textoBoton1: "Descargar",
            textoBoton2: "Cancelar",
            // Accion de Descarga
            accion: () async {
              //donwloadFile(nombrefichero);
              final pathReference = storageRef.child("libros/$nombrefichero");
              donwloadFile(pathReference);
            }
        )
      );
  }


  Future<void> donwloadFile(Reference ref) async {
//    final islandRef = storageRef.child("libros/$nombrefichero");
    final appDocDir = await getApplicationDocumentsDirectory();
    //final filePath = '${appDocDir.absolute}/libros/$nombrefichero';
    final filePath = '${appDocDir.path}/libros/${ref.name}';
    final file = File(filePath);
    await ref.writeToFile(file);

//    final downloadTask = islandRef.writeToFile(file);
    //downloadTask.snapshotEvents.listen((taskSnapshot) {
      /*switch (TaskSnapshot.state){
        case TaskState.success:
          print("Se ha descargado el archivo correctamente");
          break;
        case TaskState.error:
          print("Error en la descarga");
          break;
        }*/
    //});

    //mensaje(context, 'Descargado ${ref.name}');
  }

  /*Future<void> donwloadFileURL(Reference ref) async {
    final nombrelibroURL = nombrefichero;
    final url = await ref.getDownloadURL();

    final tempdir = await getTemporaryDirectory();
    final path = "${tempdir.path}${ref.name}";

    await Dio().download(
        url,
        path,
        onReceiveProgress: (received, total){
          double progress = received / total;
          setState((){
            downloadProgress = progress;
            mensajeProgreso(context, nombrelibroURL, downloadProgress);
          });
        }
    );

    if (url.contains('.mp4')){
      await GallerySaver.saveVideo(path, toDcim: true);
    }else if (url.contains('.jpg')){
      await GallerySaver.saveImage(path, toDcim: true);
    }

  }*/

  // Generamos con Future funcion asincrona getLibrosAutor de consulta
  Future<String> getLibrosAutor(String filtro) async {
    urlapi = "$urlbuscar$filtro";
    // Para poder usar await el metodo tiene que ser asincrono en el Future
    var res = await http.get(
        Uri.parse(urlapi), headers: {"Accept": "application/json"});

    int statusCode = res.statusCode;
    if (statusCode != 200){
      mensaje(context, 'No hay datos a mostrar');
    }

    // Entrara en SetState cuando haya obtenido los resultados
    setState(() {
      data = json.decode(res.body);
    });
    return "Realizado!";
  }

}
