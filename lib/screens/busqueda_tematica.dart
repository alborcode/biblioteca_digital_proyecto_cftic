
// Pendiente
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Importacion de Pantallas
import 'package:biblioteca_digital_proyecto_cftic/screens/screens.dart';
// Importamos Widgets personalizados
import 'package:biblioteca_digital_proyecto_cftic/widgets/widgets.dart';


class BusquedaTematica extends StatefulWidget {
  // Se define ruta de PantallaLoginEmail
  const BusquedaTematica({Key? key}) : super(key: key);

  @override
  BusquedaTematicaState createState() => BusquedaTematicaState();
}

class BusquedaTematicaState extends State<BusquedaTematica> {
  final _dropdownFormKey = GlobalKey<FormState>();
  final TextEditingController busquedaController = TextEditingController();

  String valorseleccionado = "Programacion";

  final String urlbuscar = "https://apibiblioteca.azurewebsites.net/biblioteca/GetTematica/";
  String urlapi = "";
  // La variable data recupera los datos del webapi en una lista o coleccion
  List? data;

  String mensajeStatus = "";

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
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
              Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Text("Busqueda por Tematica",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ],
              ),
            Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 30, right: 10),
                    child: Form(
                      key: _dropdownFormKey,
                      // Llamo a Funcion Lista Desplegable
                          child: listaDesplegable(),
                      ),
                    ),
                ],
              ),
            Row(
              // Centra los elementos en la fila horizontalmente
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: BotonIcono(
                    accion: () {
                      //if (_dropdownFormKey.currentState!.validate()) {
                      getLibrosTematica(valorseleccionado);
                      //Acciones si el desplegable es correcto
                      //}
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
              //Container(child: listado()),
          ]
        )
    );
  }

  // Generamos en Lista los elementos del menu desplegable
  List<DropdownMenuItem<String>> get elementosLista{
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: 'Programacion',
          child: Text('Programación')
      ),
      const DropdownMenuItem(
          value: 'Sistemas',
          child: Text('Sistemas')
      ),
      const DropdownMenuItem(
          value: 'Ciberseguridad',
          child: Text('Ciberseguridad')
      ),
      const DropdownMenuItem(
          value: 'Bases_Datos',
          child: Text('Bases de Datos')
      ),
      const DropdownMenuItem(
          value: 'Web',
          child: Text('Web')
      ),
    ];
    return menuItems;
  }

  DropdownButtonFormField<String> listaDesplegable() {
    return DropdownButtonFormField(
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        filled: true,
        fillColor: Colors.transparent,
      ),
      validator: (value) => value == null ? "Selecciona una Temática" : null,
      //dropdownColor: Colors.white60,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 14,
        //height: 8
      ),
      //icon: const Icon(Icons.flag),
      value: valorseleccionado,
      items: elementosLista,
      onChanged: (String? nuevovalor){
        setState(() {
          valorseleccionado = nuevovalor!;
        });
      },
    );
  }

  ListView listado() {
    return ListView.builder(
      // El numero de elementos será la longitud de la lista data
        itemCount: data == null ? 0 : data!.length,
        // Por cada registro recorro el json
        itemBuilder: (BuildContext context, int index) {
          return Container(
              padding: const EdgeInsets.only(top:5.0, left:10.0, right:10.0),
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
                                  ventanaDescarga(context);
                                }
                            ),
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


  // Generamos con Future funcion asincrona getDoctoresData
  // Tipo Future que devolvera un String (al ser consulta)
  Future<String> getLibrosTematica(String filtro) async {
    urlapi = "$urlbuscar$filtro";
    // Para poder usar await el metodo tiene que ser asincrono en el Future
    var res = await http.get(Uri.parse(urlapi), headers: {"Accept": "application/json"});

    int statusCode = res.statusCode;
    if (statusCode != 200){
      mensaje(context, 'No hay datos a mostrar');
    }
    // Entrara en SetState cuando haya obtenido los resultados
    //listado();

    setState(() {
      data = json.decode(res.body);
      //data = json.decode(res.body);
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

}

