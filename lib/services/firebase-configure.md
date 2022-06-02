
Agrega Firebase a tu app de Flutter

Requisitos previos

    Instala el editor o IDE que prefieras.

    Configura un dispositivo o emulador para ejecutar la app. Los emuladores deben usar una imagen que cuente con Google Play.

    Asegúrate de que tu app cumpla con los siguientes requisitos:
        Se segmenta al nivel de API 19 (KitKat) o superior.
        Usa Android 4.4 o una versión posterior.

    Instala Flutter para tu sistema operativo específico, incluidos estos componentes:
        SDK de Flutter
        Bibliotecas compatibles
        Software y SDK específicos para cada plataforma

    Accede a Firebase con tu Cuenta de Google.

Paso 1: Instala las herramientas de línea de comandos obligatorias

Si aún no lo has hecho, instala Firebase CLI.

Accede a Firebase con tu Cuenta de Google ejecutando el siguiente comando:

$ firebase login

Para instalar la CLI de FlutterFire, ejecuta el siguiente comando desde cualquier directorio:

 $ dart pub global activate flutterfire_cli

Paso 2: Configura tus apps para usar Firebase

Usa la CLI de FlutterFire a fin de configurar tus apps de Flutter para conectarte a Firebase.

Desde el directorio de tu proyecto de Flutter, ejecuta el siguiente comando para iniciar el flujo de trabajo de configuración de la app:

$ flutterfire configure

Paso 3: Inicializa Firebase en tu app

Desde el directorio de tu proyecto de Flutter, ejecuta el siguiente comando para instalar el complemento principal:

$ flutter pub add firebase_core

Desde el directorio de tu proyecto de Flutter, ejecuta el siguiente comando para asegurarte de que la configuración de Firebase de tu app de Flutter esté actualizada:

$ flutterfire configure

En el archivo lib/main.dart, importa el complemento principal de Firebase y el archivo de configuración que generaste antes:

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Además, en tu archivo lib/main.dart, inicializa Firebase con el objeto DefaultFirebaseOptions exportado por el archivo de configuración:

await Firebase.initializeApp(
options: DefaultFirebaseOptions.currentPlatform,
);

Vuelve a compilar tu aplicación de Flutter:

$ flutter run

Paso 4: Agrega complementos de Firebase

Puedes acceder a Firebase en tu app de Flutter a través de los distintos complementos de Firebase para Flutter
, uno para cada producto de Firebase (por ejemplo, Cloud Firestore, Authentication, Analytics, etcétera).

Como Flutter es un framework multiplataforma, cada complemento de Firebase es aplicable para usar en
plataformas web, de Apple y de Android. Por lo tanto, si agregas un complemento de Firebase a tu app
de Flutter, el complemento se usará en las versiones para Apple, Android y la Web.

A continuación, te mostramos cómo agregar un complemento de Flutter de Firebase:

    Desde el directorio de tu proyecto de Flutter, ejecuta el siguiente comando:

$ flutter pub add PLUGIN_NAME

Desde el directorio de tu proyecto de Flutter, ejecuta el siguiente comando:

$ flutterfire configure

Ejecutar este comando garantiza que la configuración de Firebase de tu app de Flutter esté actualizada y que, para Crashlytics y Performance Monitoring en Android, se agreguen los complementos de Gradle necesarios a tu app.

Una vez que lo hagas, vuelve a crear tu proyecto de Flutter:

$ flutter run

Complementos disponibles
PRODUCTO 	                    NOMBRE DEL COMPLEMENTO 	
Analytics 	                    firebase_analytics
Verificación de aplicaciones 	firebase_app_check
Authentication 	                firebase_auth
Cloud Firestore 	            cloud_firestore
Cloud Functions 	            cloud_functions
Cloud Messaging 	            firebase_messaging
Cloud Storage 	                firebase_storage
Crashlytics 	                firebase_crashlytics
Dynamic Links 	                firebase_dynamic_links
In‑App Messaging 	            firebase_in_app_messaging
Instalaciones de Firebase 	    firebase_app_installations
ML Model Downloader 	        firebase_ml_model_downloader
Performance Monitoring 	        firebase_performance
Realtime Database 	            firebase_database
Remote Config 	                firebase_remote_config
