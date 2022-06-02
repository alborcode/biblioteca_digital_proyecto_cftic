// https://www.youtube.com/watch?v=5F58y1YaRYs


import 'package:flutter/material.dart';

// Importamos librerias para control asincrono
import 'dart:async';
import 'dart:convert';
import 'dart:io';

// Importar Libreria para acceso a API
import 'package:http/http.dart';

// Importar Librerias Firebase
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

// Importar Libreria para seleccion ficheros y upload
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:image_picker/image_picker.dart';

// Importamos Widgets personalizados
import 'package:biblioteca_digital_proyecto_cftic/widgets/widgets.dart';

class AltaLibro extends StatefulWidget {
  // Se define ruta de PantallaLoginEmail
  const AltaLibro({Key? key}) : super(key: key);

  @override
  AltaLibroState createState() => AltaLibroState();
}

class AltaLibroState extends State<AltaLibro> {
  // Definicion de Controladores de Cajas de Texto
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController autorController = TextEditingController();
  final TextEditingController urlController = TextEditingController();
  final TextEditingController portadaController = TextEditingController();
  // Definicion de Control Dropdown
  final _dropdownFormKey = GlobalKey<FormState>();

  final String urlinsertar =
      "https://apibiblioteca.azurewebsites.net/biblioteca/";
  String urlapi = "";

  String imageName = "";
  XFile? imagePath;

  var filePath;
  File? fileName;

  final ImagePicker _picker = ImagePicker();

  FirebaseFirestore firestoreRef = FirebaseFirestore.instance;
  FirebaseStorage storageRef = FirebaseStorage.instance;
  String collectionName = "libros";

  String uploadFileName = "";

  bool _isLoading = false;

  String valorseleccionado = "Programacion";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'BIBLIOTECA ONLINE',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              })),
      endDrawer: const MenuLateral(),
      body: SingleChildScrollView(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                strokeWidth: 4.0,
                backgroundColor: Colors.grey,
                color: Colors.brown,
              ))
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Texto de Pantalla
                  const Padding(
                    padding: EdgeInsets.only(top: 30.0),
                    child: Text(
                      "Alta de Libro",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  Padding(
                    // Definimos margenes entre Titulo y primera caja
                    padding:
                        const EdgeInsets.only(left: 10, top: 30, right: 10),
                    child: CajaTexto(
                      controller: tituloController,
                      hint: 'Introduce el Titulo del Libro',
                      icono: Icons.book,
                      nomostrar: false,
                      teclado: TextInputType.text,
                    ),
                  ),
                  Padding(
                    // Definimos margenes entre primera caja y segunda caja
                    padding:
                        const EdgeInsets.only(left: 10, top: 20, right: 10),
                    child: CajaTexto(
                        controller: autorController,
                        hint: 'Introduce el Autor del Libro',
                        icono: Icons.assignment_ind,
                        nomostrar: false,
                        teclado: TextInputType.text),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 20, right: 10),
                    child: Form(
                      key: _dropdownFormKey,
                      child: Column(children: [
                        // Llamo a Funcion Lista Desplegable
                        listaDesplegable(),
                      ]),
                    ),
                  ),
                  Row(
                    // Centra los elementos en la fila horizontalmente
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
           /*           Padding(
                        // Añado margenes entre botones y con respecto a la caja
                        padding:
                            const EdgeInsets.only(top: 30, left: 10, right: 10),
                        child: BotonIcono(
                          accion: () {
                            imagePicker();
                          },
                          icono: Icons.photo,
                          texto: 'Seleccionar Portada',
                        ),
                      ),*/
                      Padding(
                        // Añado margenes entre botones y con respecto a la caja
                        padding:
                            const EdgeInsets.only(top: 30, left: 10, right: 10),
                        child: BotonIconosinTexto(
                          accion: () {
                            imagePicker();
                          },
                          icono: Icons.photo,
                        ),
                      ),
                      Padding(
                        // Añado margenes entre botones y con respecto a la caja
                        padding:
                        const EdgeInsets.only(top: 30, left: 5, right: 5),
                        child: BotonIconosinTexto(
                          accion: () {
                            imagePickerCamera();
                          },
                          icono: Icons.photo_camera,
                        ),
                      ),
                      Padding(
                        // Añado margenes entre botones y con respecto a la caja
                        padding:
                            const EdgeInsets.only(top: 30, left: 5, right: 5),
                        child: BotonIcono(
                          accion: () {
                            _uploadImage();
                            String tituloinsert = tituloController.text;
                            String autorinsert = autorController.text;
                            String tematicainsert = valorseleccionado;
                            String urlinsert = ""; //---------------------------------------------
                            String imageninsert = uploadFileName;
                            altaRegistro(tituloinsert, autorinsert,
                                tematicainsert, urlinsert, imageninsert);
                          },
                          icono: Icons.photo_camera_back,
                          texto: 'Subir portada',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    // Centra los elementos en la fila horizontalmente
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        // Añado margenes entre botones y con respecto a la caja
                        padding:
                            const EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: BotonIcono(
                          accion: () {
                            // imagePicker(); //---------------------------------------------
                          },
                          icono: Icons.book,
                          texto: 'Seleccionar libro',
                        ),
                      ),
                      Padding(
                        // Añado margenes entre botones y con respecto a la caja
                        padding:
                            const EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: BotonIcono(
                          accion: () {
                            //_uploadFile(); //---------------------------------------------
                          },
                          icono: Icons.start,
                          texto: 'Alta libro',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }

  // Generamos en Lista los elementos del menu desplegable
  List<DropdownMenuItem<String>> get elementosLista {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: 'Programacion', child: Text('Programación')),
      const DropdownMenuItem(value: 'Sistemas', child: Text('Sistemas')),
      const DropdownMenuItem(
          value: 'Ciberseguridad', child: Text('Ciberseguridad')),
      const DropdownMenuItem(value: 'Ofimatica', child: Text('Ofimatica')),
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
      onChanged: (String? nuevovalor) {
        setState(() {
          valorseleccionado = nuevovalor!;
        });
      },
    );
  }

  imageFile() async {
    //final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    final path = await FlutterDocumentPicker.openDocument();
    setState(() {
      filePath = path;
      //fileName = file.name.toString();
      fileName = File(path!);
    });
  }

  /*_uploadFile() {
    if (fileName == null){
      print("No hay fichero");
      return null;
    }

    setState(() {
      _isLoading = true;
    });

    firebase_storage.UploadTask uploadTask;
    var uniqueKey = firestoreRef.collection(collectionName);

    uploadFileName =
        DateTime
            .now()
            .millisecondsSinceEpoch
            .toString() + ".jpg";
    Reference reference =
    storageRef.ref().child(collectionName).child(uploadFileName);
    UploadTask uploadTask = reference.putFile(File(imagePath!.path));
    uploadTask.snapshotEvents.listen((event) {
      print("${event.bytesTransferred}\t${event.totalBytes}");
    });

    uploadTask.whenComplete(() async {
      var uploadPath = await uploadTask.snapshot.ref.getDownloadURL();
      firestoreRef.collection(collectionName).doc(uniqueKey.id).set({
        "image": uploadPath,
        "titulo": tituloController.text,
        "autor": autorController.text,
        "tematica": valorseleccionado
      });
      setState(() {
        _isLoading = false;
      });
    });
  }*/

  imagePicker() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imagePath = image;
        imageName = image.name.toString();
      });
    }
  }

  imagePickerCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile;
        imageName = pickedFile.name.toString();
        //imageName = File(pickedFile.path).toString();
      });
    }
  }

  _uploadImage() {
    setState(() {
      _isLoading = true;
    });
    var uniqueKey = firestoreRef.collection(collectionName);

    uploadFileName = DateTime.now().millisecondsSinceEpoch.toString() + ".jpg";
    Reference reference =
        storageRef.ref().child(collectionName).child(uploadFileName);
    UploadTask uploadTask = reference.putFile(File(imagePath!.path));
    uploadTask.snapshotEvents.listen((event) {
      print("${event.bytesTransferred}\t${event.totalBytes}");
    });

    uploadTask.whenComplete(() async {
      var uploadPath = await uploadTask.snapshot.ref.getDownloadURL();
      firestoreRef.collection(collectionName).doc(uniqueKey.id).set({
        "image": uploadPath,
        "titulo": tituloController.text,
        "autor": autorController.text,
        "tematica": valorseleccionado
      });
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<HttpClientResponse?> altaRegistro(tituloinsert, autorinsert,
      tematicainsert, urlinsert, imageninsert) async {
    final url = Uri.parse(urlinsertar);
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      // Si el ID es autoincremental no lo enviamos
      //"idLibro": 0,
      "titulo": tituloinsert,
      "autor": autorinsert,
      "tematica": tematicainsert,
      "urlDescarga": "",
      "imagenPortada": imageninsert
    };
    // Pasamos de Mapa a json
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      url,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );

    int statusCode = response.statusCode;
    if (statusCode == 200) {
      mensaje(context, 'Insercion realizada correctamente');
      //print("Insercion realizada correctamente");
    } else {
      //print("Error en Post");
      mensaje(context, 'Error en el Alta');
    }

    String responseBody = response.body;
    return null;
  }
}