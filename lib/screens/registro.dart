
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:biblioteca_digital_proyecto_cftic/services/autentificacion.dart';

// Importamos Widgets personalizados
import 'package:biblioteca_digital_proyecto_cftic/widgets/widgets.dart';


class Registro extends StatefulWidget {
  const Registro({Key? key}) : super(key: key);

  @override
  RegistroState createState() => RegistroState();
}

class RegistroState extends State<Registro> {
  // Definicion de Controladores de cajas de texto
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('BIBLIOTECA ONLINE',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        // Añadimos un SingleChildScrollView para poder hacer Scroll al mostrar teclado
        body: SingleChildScrollView(
          child: Column(
            // Centramos en columna los hijos
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: Text(
                  "Datos Registro",
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Padding(
                // Damos margenes entre Titulo y caja
                padding: const EdgeInsets.only(top: 50.0, left: 20, right: 20),
                child: CajaTexto(
                    controller: emailController,
                    hint: 'Introduce tu email',
                    icono: Icons.email,
                    nomostrar: false,
                    teclado: TextInputType.emailAddress
                ),
              ),
              Padding(
                // Damos margenes entre cajas
                padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                child: CajaTexto(
                    controller: passwordController,
                    hint: 'Introduce tu password',
                    icono: Icons.password,
                    nomostrar: true,
                    teclado: TextInputType.visiblePassword
                ),
              ),
              Padding(
                // Damos margen entre ultima caja y boton
                padding: const EdgeInsets.all(80.0),
                // Llamamos a BotonconIcono para sacar boton registrarse
                child: BotonIconoAnimado(
                  accion: () {
                    String email = emailController.text;
                    String password = passwordController.text;
                    Autentificacion.signup(context, email, password);
                    // Navigator.pushNamed(context, '/Conexion');
                  },
                  icono: Icons.login_outlined,
                  texto: 'Registrarse',
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
