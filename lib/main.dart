
import 'package:flutter/material.dart';

// Se importan paquetes autorizacion Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:biblioteca_digital_proyecto_cftic/services/autentificacion.dart';

// Importamos personalizacion del Tema
import 'package:biblioteca_digital_proyecto_cftic/theme/app_theme.dart';
// Importacion de Pantallas
import 'package:biblioteca_digital_proyecto_cftic/screens/screens.dart';
// Importamos Widgets personalizados
import 'package:biblioteca_digital_proyecto_cftic/widgets/widgets.dart';
import 'package:biblioteca_digital_proyecto_cftic/routes/app_routes.dart';


//void main(){
  Future<void> main() async {
  // La interfaz usuario no se represente hasta que no se complete inicialización
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Autentificacion.initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Hubo un error en la Aplicacion');
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              title: 'Biblioteca Online',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.miTemaClaro,
              //home: const Conexion(),
              home: const Inicio(),
              routes: AppRoutes.rutas
            );
          }
          // Se añade un indicador de progreso
          return const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange)
          );
        }
    );
  }
}