import 'package:flutter/material.dart';
import 'package:biblioteca_digital_proyecto_cftic/services/autentificacion.dart';

// Importamos Widgets personalizados
import 'package:biblioteca_digital_proyecto_cftic/widgets/widgets.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController emailController = TextEditingController();
  late String _email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BIBLIOTECA ONLINE',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: CajaTexto(
              controller: emailController,
              hint: 'tuemail@mail.com',
              label: 'Introduce tu email',
              helper: 'Email para recibir correo de reestablecimiento',
              icono: Icons.email,
              nomostrar: false,
                teclado: TextInputType.emailAddress
            ),
          ),
          Container(
            width: 200,
            height: 50,
            child: BotonIconoAnimado(
              accion: () {
                String email = emailController.text;
                Autentificacion.resetPassword(context, email);
                mensaje(context, 'Se ha enviado un correo para reiniciar la contraseña');
                // Volvemos a pantalla anterior
                Navigator.of(context).pop();
              },
              icono: Icons.lock_reset,
              texto: 'Reset Contraseña',
            ),
          )
        ],
      ),
    );
  }
}