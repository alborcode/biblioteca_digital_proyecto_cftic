
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';

// Importar libreria para acceso documentos locales
import 'package:path_provider/path_provider.dart';

// Importamos Widgets personalizados
import 'package:biblioteca_digital_proyecto_cftic/widgets/widgets.dart';


class BusquedaAutor extends StatefulWidget {
  // Se define ruta de PantallaLoginEmail
  const BusquedaAutor({Key? key}) : super(key: key);

  @override
  BusquedaAutorState createState() => BusquedaAutorState();
}

class BusquedaAutorState extends State<BusquedaAutor> {
  // Variables para el controlador
  final TextEditingController busquedaController = TextEditingController();
  // Variables para el foco
  final FocusNode _busquedaFocus = FocusNode();

  // Funcion para vaciar controladores
  void _reset() {
    busquedaController.clear();
  }

  final String urlbuscar = "https://apibiblioteca.azurewebsites.net/biblioteca/GetAutores/";
  String urlapi = "";
  // La variable data recupera los datos del webapi en una lista o coleccion
  List? data;
  String mensajeStatus = "";

  // Para sacar URL de Imagen a mostrar
  String? downloadURL;
  // Referencia para Storage
  FirebaseStorage storageRefImagen = FirebaseStorage.instance;
  String collectionNameFile = "libros";
  FirebaseStorage storageRefLibro = FirebaseStorage.instance;
  String collectionNameImage = "portadas";

  String nombreimagen = "";
  String nombrefichero = "";
  // Crear referencia a Storage app
  final storageRef = FirebaseStorage.instance.ref();

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
                    child: BotonIconoAnimado(
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
          //double? progress = downloadProgress[index];
          return Container(
              padding: const EdgeInsets.only(left:10.0, right:5.0),
              child: Column(
                children: [
                  Row(
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:5.0, right:10.0, top: 10),
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                FutureBuilder(
                                  future: loadUbicacionImagen(data![index]["imagenPortada"]),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return const Text("Error en descarga de Portada",);
                                    }
                                    if (snapshot.connectionState == ConnectionState.done) {
                                      return SizedBox(
                                        height: 80,
                                        width: 50,
                                        child: Image.network(
                                          snapshot.data.toString(),
                                        ),
                                      );
                                    }
                                    return const Center(child: CircularProgressIndicator());
                                  },
                                ),
                              ]
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:5.0, right:5.0, top: 10),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // Alineamos en la columna los textos a la izquierda
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: <Widget>[
                                  Text(data![index]["titulo"],
                                      style: const TextStyle(
                                        fontSize: 14.0, color: Colors.black,)),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(data![index]["autor"],
                                      style: const TextStyle(
                                          fontSize: 14.0, color: Colors.black)),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(data![index]["tematica"],
                                      style: const TextStyle(
                                          fontSize: 14.0, color: Colors.grey)),
                                ],
                              ),
                            ]
                        ),
                      ),
                      // Usamos Spacer para que alinea la ultima fia a la derecha
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(left:5.0, right:5.0, top: 10),
                        child: Column(
                          // Alineamos Icono en Fila despues de Datos
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            IconButton(
                                icon: const Icon(Icons.download_rounded),
                                splashColor: Colors.brown,
                                // Al presionar en boton muestra dialogo de descarga
                                onPressed: () async {
                                    nombrefichero = data![index]["urlDescarga"];
                                    final url = await loadUbicacionFile(nombrefichero);
                                    openFile(
                                      url,
                                      nombrefichero,
                                    );
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Añadimos dentro la columna un segundo elemento el divider
                  const Padding(
                    padding: EdgeInsets.only(top:5.0),
                    child: Divider(
                      thickness: 1,
                    ),
                  ),
                ],
              )
          );
        }
    );
  }


  // Future para cargar URL segun nombre de fichero guardado
  Future loadUbicacionFile(nombrelibro) async {
    try {
      await downloadURLFile(nombrelibro);
      return downloadURL;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }

  // Future que recupera la URL de la Imagen
  Future<void> downloadURLFile(nombrelibro) async {
    downloadURL = await FirebaseStorage.instance
        .ref("libros")
        .child(nombrelibro)
        .getDownloadURL();
    debugPrint(downloadURL.toString());
  }

  Future openFile(String url, String nombrefichero) async {
    final file = await downloadFile(url,nombrefichero);
    if (file == null) return;
    OpenFile.open(file.path);
  }

  Future<File?> downloadFile(String url, String nombrefichero) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final file = File('${appDocDir.path}/$nombrefichero');
    try{
      final response = await Dio().get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: 0,
        ),
      );
      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      return file;
    } catch(e){
      return null;
    }
  }

    // Future para cargar URL segun nombre de fichero guardado
    Future loadUbicacionImagen(nombreimagen) async {
      try {
        await downloadURLImagen(nombreimagen);
        return downloadURL;
      } catch (e) {
        debugPrint("Error - $e");
        return null;
      }
    }

    // Future que recupera la URL de la Imagen
    Future<void> downloadURLImagen(nombreimagen) async {
      downloadURL = await FirebaseStorage.instance
          .ref("portadas")
          .child(nombreimagen)
          .getDownloadURL();
      debugPrint(downloadURL.toString());
    }

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