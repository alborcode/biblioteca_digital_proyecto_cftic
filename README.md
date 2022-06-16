# Introducción

El proyecto de desarrollo de esta aplicación (bibliotecaonline) ha sido desarrollada en Android Studio y en este repositorio se encuentran los ficheros editables para que funcione su ejecución.
El proyecto forma parte del curso **[Flutter y Dart](https://cftic.centrosdeformacion.empleo.madrid.org/curso-flutter-y-dart)** impartido en el Centro de Referencia Nacional de Desarrollo Informático y Comunicaciones (**[CFTIC](https://cftic.centrosdeformacion.empleo.madrid.org/)**) a través de la empresa **[CAS Training](https://cas-training.com/)**.

# Objetivo

Desarrollar una aplicación híbrida multiplataforma que se pueda ejecutar en **[Android](https://developer.android.com/)** e **[iOS](https://developer.apple.com/)**.

# Alcance

La biblioteca digital estará especializada en libros digitales para estudiantes de todas las edades que están en colegios, institutos, universidades y centros de formación.

Las herramientas y tecnologías que se han usado son las siguientes:
1. **[Android Studio](https://developer.android.com/studio?hl=es&gclid=CjwKCAjwqauVBhBGEiwAXOepkSgaLDm3UMAlENvAFdmN4PEyA9Z7bDEbZm1tjpBk7PC1ihPEtxI0LhoCY_MQAvD_BwE&gclsrc=aw.ds)** para el framework de desarrollo **[Flutter](https://flutter.dev/?gclid=CjwKCAjwqauVBhBGEiwAXOepkecnRxnps5kWigJJX3jomkpK0SNLQYntdl2SmmNM8eYOx-JNEHh4zBoCf78QAvD_BwE&gclsrc=aw.ds)** en el lenguaje de programación **[Dart](https://dart.dev/)**.
2. **[Visual Studio](https://visualstudio.microsoft.com/es/vs/)** para el desarrollo de la API que generará una web service en **[Azure](https://azure.microsoft.com/es-es/)**.
3. **[Google Cloud Platform](https://cloud.google.com/gcp/?hl=es&utm_source=google&utm_medium=cpc&utm_campaign=emea-es-all-es-bkws-all-all-trial-e-gcp-1011340&utm_content=text-ad-none-any-DEV_c-CRE_593880918206-ADGP_Hybrid%20%7C%20BKWS%20-%20EXA%20%7C%20Txt%20~%20GCP%20~%20General%23v1-KWID_43700060384861666-kwd-26415313501-userloc_1005417&utm_term=KW_google%20cloud%20platform-NET_g-PLAC_&gclid=CjwKCAjwqauVBhBGEiwAXOepkZUs04dV8OsIx1RxFyvrIgjjymahHPaMydnn-4J7Ege9h85r6_sYRBoCUE8QAvD_BwE&gclsrc=aw.ds)** para el almacenamiento de los libros y la autenticación de usuarios a través de la plataforma de desarrollo **[Firebase](https://firebase.google.com/)**. 

# Principales ficheros editables

## ~/android/build.gradle

Configuración básica para que la aplicación funcione. A continuación, un ejemplo:
~~~
    dependencies {
        classpath 'com.android.tools.build:gradle:7.1.2'
        // START: FlutterFire Configuration
        classpath 'com.google.gms:google-services:4.3.10'
        // END: FlutterFire Configuration
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
    }
~~~

## ~/android/app/build.gradle

Configuración básica para que la aplicación funcione. A continuación, un ejemplo:
~~~
defaultConfig {
        minSdkVersion 21
}
~~~

## ~/pubspec.yaml

Todas las librerías que se han utilizado, como por ejemplo las siguientes:
~~~
# Librerias acceso Api
http: ^0.13.4
dio: ^4.0.6
~~~

## ~/lib/*

Todos los ficheros necesarios para el diseño y funcionalidad de la aplicación.