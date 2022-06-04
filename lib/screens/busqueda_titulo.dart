

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:http/http.dart' as http;

// Importamos Widgets personalizados
import 'package:biblioteca_digital_proyecto_cftic/widgets/widgets.dart';


class BusquedaTitulo extends StatefulWidget {
  // Se define ruta de PantallaLoginEmail
  const BusquedaTitulo({Key? key}) : super(key: key);

  @override
  BusquedaTituloState createState() => BusquedaTituloState();
}

class BusquedaTituloState extends State<BusquedaTitulo> {
  final TextEditingController busquedaController = TextEditingController();

  // Funcion para vaciar controladores
  void _reset() {
    busquedaController.clear();
  }

  // Variables para el foco
  final FocusNode _busquedaFocus = FocusNode();

  //final String urlbuscar = "https://apibiblioteca.azurewebsites.net/Biblioteca/GetTitulo/";
  final String urlbuscar = "https://apibiblioteca.azurewebsites.net/Biblioteca/GetTitulos/";
  String urlapi = "";
  // La variable data recupera los datos del webapi en una lista o coleccion
  List? data;

  String mensajeStatus = "";

  String? downloadURL;
  // Referencia para Storage
  FirebaseStorage storageRef = FirebaseStorage.instance;
  String collectionNameFile = "libros";
  String collectionNameImage = "portadas";

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
              "Busqueda por Titulo",
              style: TextStyle(fontSize: 30),
            ),
          ),
          Padding(
            // Definimos margenes entre Titulo y primera caja
            padding: const EdgeInsets.only(left: 10, top: 30, right: 10),
            child: CajaTexto(
              controller: busquedaController,
              hint: 'Introduce titulo libro a buscar',
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
              padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
              child: BotonIcono(
                accion: () {
                  getLibrosTitulo(busquedaController.text);
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
              padding: const EdgeInsets.only(left:10.0, right:5.0),
              child: Card(
                  elevation: 0,
                  color: Colors.transparent,
                  child: Row(
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
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
                                  return const Text("Something went wrong",);
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
                        padding: const EdgeInsets.only(left:10.0, right:5.0, top: 10),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // Alineamos en la columna los textos a la izquierda
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                      ),
                      Row(
                        // Alineamos Icono en Fila despues de Datos
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          IconButton(
                              icon: const Icon(Icons.download_rounded),
                              splashColor: Colors.brown,
                              // Al presionar en boton muestra dialogo de descarga
                              onPressed: () {
                                ventanaDescarga(context);
                              }
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top:5.0),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                    ],
                  )
              )
          );
        }
    );
  }


  void ventanaDescarga(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) =>
        AlertaDialogo(
          titulo: "Descargar",
          texto: "Pulse boton descargar para descargar este libro a su dispositivo",
          textoBoton1: "Descargar",
          textoBoton2: "Cancelar",
          accion: () {
            // Llamada a url guarda para descargar
          },
        )
      );
  }


  Future loadUbicacionImagen(nombrefichero) async {
    try {
      await downloadURLImagen(nombrefichero);
      return downloadURL;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }

  // Future que recupera la URL de la Imagen
  Future<void> downloadURLImagen(nombrefichero) async {
    downloadURL = await FirebaseStorage.instance
        .ref("portadas")
        .child(nombrefichero)
        .getDownloadURL();
    debugPrint(downloadURL.toString());
  }

  // Generamos con Future funcion asincrona getLibrosTitulo de consulta en API
  Future<String> getLibrosTitulo(String filtro) async {
    urlapi = "$urlbuscar$filtro";
    // Para poder usar await el metodo tiene que ser asincrono en el Future
    var res = await http.get(Uri.parse(urlapi), headers: {"Accept": "application/json"});

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
