// INSTALACION
Agrega Firebase Authentication desde la raíz del proyecto Flutter, ejecutar
$ flutter pub add firebase_auth
$ Importe el complemento 
import 'package:firebase_auth/firebase_auth.dart';

// CREAR CUENTA USUARIO (llamando a createUserWithEmailAndPassword o 
// Iniciando sesión por primera vez mediante un proveedor (Google, Facebook o Apple.)
try {
  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
  email: emailAddress,
  password: password,
  );
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
  }
  } catch (e) {
    print(e);
  }


// LOGIN USUARIO
try {
  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
  email: emailAddress,
  password: password
  );
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    print('No user found for that email.');
  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
  }
}

//CERRAR SESION USUARIO
await FirebaseAuth.instance.signOut();

//Eviar un correo electrónico de restablecimiento de contraseña
await FirebaseAuth.instance.sendPasswordResetEmail(email: "user@example.com");

// Borrar Usuario
await user?.delete();

// Establecer direccion de correo electronico  
await user?.updateEmail("janeq@example.com");


//Autentificacion Personalizada
// Crear Token Personalizado
String uid = "some-uid";
String customToken = FirebaseAuth.getInstance().createCustomToken(uid);
// Send token back to client

try {
    final userCredential =
      await FirebaseAuth.instance.signInWithCustomToken(token);
    print("Sign-in successful.");
  } on FirebaseAuthException catch (e) {
    switch (e.code) {
    case "invalid-custom-token":
      print("The supplied token is not a Firebase custom auth token.");
      break;
    case "custom-token-mismatch":
      print("The supplied token is for a different Firebase project.");
      break;
    default:
      print("Unkown error.");
    }
  }

