
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

// Importacion de Pantallas
import 'package:biblioteca_digital_proyecto_cftic/screens/screens.dart';
// Importamos Widgets personalizados
import 'package:biblioteca_digital_proyecto_cftic/widgets/widgets.dart';

class VerificarEmail extends StatefulWidget {
  const VerificarEmail({Key? key}) : super(key: key);

  @override
  State<VerificarEmail> createState() => _VerificarEmailState();
}

class _VerificarEmailState extends State<VerificarEmail> {
  final auth = FirebaseAuth.instance;
  User? user;
  late Timer timer;

  @override
  void initState() {
    user = auth.currentUser;
    user!.sendEmailVerification();

    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('BIBLIOTECA ONLINE',
            style: TextStyle(fontWeight: FontWeight.bold),
          )
      ),

      body: Center(
        child: Text(
            'Se ha enviado un email a ${user!.email} por favor verificalo para activar tu cuenta'),
      ),

    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser;
    await user!.reload();
    if (user!.emailVerified) {
      timer.cancel();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Inicio()));
    }
  }
}
