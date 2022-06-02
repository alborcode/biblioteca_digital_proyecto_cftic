
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:biblioteca_digital_proyecto_cftic/services/autentificacion.dart';

// Importacion de Pantallas
import 'package:biblioteca_digital_proyecto_cftic/screens/screens.dart';
// Importamos Widgets personalizados
import 'package:biblioteca_digital_proyecto_cftic/widgets/widgets.dart';

class Conexion extends StatefulWidget {
  // Se define ruta de PantallaLoginEmail
  const Conexion({Key? key}) : super(key: key);

  @override
  ConexionState createState() => ConexionState();
}

class ConexionState extends State<Conexion> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final colorblanco = const Color(0xffF5F6FA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('BIBLIOTECA ONLINE',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Texto de Pantalla
            const Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: Text(
                "Conexión",
                style: TextStyle(fontSize: 30),
              ),
            ),
            Padding(
              // Definimos margenes entre Titulo y primera caja
              padding: const EdgeInsets.only(left: 10, top: 30, right: 10),
              child: CajaTexto(
                  controller: emailController,
                  hint: 'Introduce tu email',
                  icono: Icons.email,
                  nomostrar: false,
                  teclado: TextInputType.emailAddress,
              ),
            ),
            Padding(
              // Definimos margenes entre primera caja y segunda caja
              padding: const EdgeInsets.only(left: 10, top: 20, right: 10),
              child: CajaTexto(
                  controller: passwordController,
                  hint: 'Introduce tu password',
                  icono: Icons.password,
                  nomostrar: true,
                  teclado: TextInputType.text
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              // Con GestureDetector podemos detectar cuando se hace click
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const ResetPassword())
                  );
                },
                child: const Text('Contraseña Olvidada',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline
                  ),
                ),
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
                      String email = emailController.text;
                      String password = passwordController.text;
                      Autentificacion.signin(context, email, password);
                    },
                    icono: Icons.login_outlined,
                    texto: 'Conexión',
                  ),
                ),
                Padding(
                  // Añado margenes entre botones y con respecto a la caja
                  padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
                  child: BotonImagen(
                    accion: () {
                      Autentificacion.signinWithGoogle(context: context);
                    },
                    nombreicono: "google_logo",
                    // Genera el boton segun tamaño texto se ponen espacios para mismo tamaño
                    texto: 'Google   ',
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('¿No tienes una cuenta? '),
                  // Con GestureDetector podemos detectar cuando se hace click
                  GestureDetector(
                    onTap: () {
                      // Se envia a pagina Registro
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const Registro())
                      );
                    },
                    child: const Text('Registrate',
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
