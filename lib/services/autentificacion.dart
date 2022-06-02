
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Importacion de Pantallas
import 'package:biblioteca_digital_proyecto_cftic/screens/screens.dart';
// Importamos Widgets personalizados
import 'package:biblioteca_digital_proyecto_cftic/widgets/widgets.dart';

class Autentificacion {

  // Funcion para Validar si estamos conectados
  static void checkSignedIn(BuildContext context) {
    Autentificacion.initializeFirebase();
    // Si el usuario es igual a la instancia de usuario actual de Firebase
    User? user = FirebaseAuth.instance.currentUser;
    // Si el usuario no es nulo es que estamos conectados y enviamos a Home
    if (user != null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Inicio())
      );
    }
  }

  // Funcion para inicializar la conexion a Firebase
  static Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  // Funcion para desconexion
  static Future<void> signout({required BuildContext context}) async {
    await FirebaseAuth.instance.signOut();
  }

  // Funcion para crear usuario
  static void signup(BuildContext context,String email, String password) {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.createUserWithEmailAndPassword(
        email: email, password: password)
        .then((_) {
          // Mandamos a verificar email
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const VerificarEmail()));
    });
  }

  // Funcion para conexion con usuario y contraseña
  static void signin(BuildContext context, String email, String password) {
    final auth = FirebaseAuth.instance;
    auth.signInWithEmailAndPassword(email: email, password: password).then((_)
    {
      // Mandamos a pagina de Inicio si se ha conectado
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Inicio())
      );
    });
  }

  // Funcion para resetear Password
  static void resetPassword(BuildContext context, String email) {
    final auth = FirebaseAuth.instance;
    auth.sendPasswordResetEmail(email: email);
  }

  // Funcion para conectarse con Google
  static Future<void> signinWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken
    );
    try {
      final UserCredential userCredential =
      await auth.signInWithCredential(credential);
      // Mandamos a pagina Inicio
      Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const Inicio()));
      // Control de errores
    } on FirebaseAuthException catch (e) {
      // Se mueve el mensaje de error devuelto por Firebase
      String userError = e.message.toString();
      if (e.code == 'account-exists-with-different-credential') {
        userError = 'La cuenta existe con unas credenciales diferentes.';
      }
      else if (e.code == 'invalid-credential') {
        userError = 'Credenciales invalidas.';
      }
      // Se visualiza el mensaje de error
      mensaje(context, userError);
    }
  }

}
