// INSTALACION
Agrega Firebase Authentication desde la raíz del proyecto Flutter, ejecutar
$ flutter pub add firebase_storage
$ Importe el complemento
import 'package:firebase_storage/firebase_storage.dart';

// CREAR INSTANCIA
final storage = FirebaseStorage.instance;

// PARA DESCARGAR UN ARCHIVO PRIMERO CREAR REFERENCIA
// Create a storage reference from our app
final storageRef = FirebaseStorage.instance.ref();

// Create a reference with an initial file path and name
final pathReference = storageRef.child("images/stars.jpg");

// Create a reference to a file from a Google Cloud Storage URI
final gsReference =
FirebaseStorage.instance.refFromURL("gs://YOUR_BUCKET/images/stars.jpg");

// Create a reference from an HTTPS URL
// Note that in the URL, characters are URL escaped!
final httpsReference = FirebaseStorage.instance.refFromURL(
"https://firebasestorage.googleapis.com/b/YOUR_BUCKET/o/images%20stars.jpg");

//DESCARGAR ARCHIVOS
// Descargar a Memoria
final islandRef = storageRef.child("images/island.jpg");
try {
    const oneMegabyte = 1024 * 1024;
    final Uint8List? data = await islandRef.getData(oneMegabyte);
    // Data for "images/island.jpg" is returned, use this as needed.
} on FirebaseException catch (e) {
    // Handle any errors.
}
// Descargar a Archivo local
final islandRef = storageRef.child("images/island.jpg");
final appDocDir = await getApplicationDocumentsDirectory();
final filePath = "${appDocDir.absolute}/images/island.jpg";
final file = File(filePath);
final downloadTask = islandRef.writeToFile(file);
downloadTask.snapshotEvents.listen((taskSnapshot) {
    switch (taskSnapshot.state) {
        case TaskState.running:
            // TODO: Handle this case.
            break;
        case TaskState.paused:
            // TODO: Handle this case.
            break;
        case TaskState.success:
            // TODO: Handle this case.
            break;
        case TaskState.canceled:
            // TODO: Handle this case.
            break;
        case TaskState.error:
            // TODO: Handle this case.
            break;
    }
});

// Descargar datos a través de URL
final imageUrl = await storageRef.child("users/me/profile.png").getDownloadURL();

// SUBIR ARCHIVOS PRIMERO HAY QUE CREAR UNA REFERENCIA
// Create a storage reference from our app
final storageRef = FirebaseStorage.instance.ref();
// Create a reference to "mountains.jpg"
final mountainsRef = storageRef.child("mountains.jpg");
// Create a reference to 'images/mountains.jpg'
final mountainImagesRef = storageRef.child("images/mountains.jpg");
// While the file names are the same, the references point to different files
assert(mountainsRef.name == mountainImagesRef.name);
assert(mountainsRef.fullPath != mountainImagesRef.fullPath);

Una vez que haya creado una referencia adecuada, llame al putFile() , putString() o putData() para cargar el archivo en Cloud Storage.

Obtener una URL de descarga
Después de cargar un archivo, puede obtener una URL para descargar el archivo llamando al método getDownloadUrl() en la Reference :
await mountainsRef.getDownloadURL();

Administrar cargas
Los eventos de pausa y reanudación generan cambios de estado de pause y progress respectivamente. Cancelar una carga hace que la carga falle con un error que indica que la carga se canceló.
final task = mountainsRef.putFile(largeFile);
// Pause the upload.
bool paused = await task.pause();
print('paused, $paused');
// Resume the upload.
bool resumed = await task.resume();
print('resumed, $resumed');
// Cancel the upload.
bool canceled = await task.cancel();
print('canceled, $canceled');

Supervisar el progreso de carga
Puede escuchar el flujo de eventos de una tarea para controlar el éxito, el fracaso, el progreso o las pausas en su tarea de carga:
TaskState.running	Se emite periódicamente a medida que se transfieren los datos y se puede utilizar para completar un indicador de carga/descarga.
TaskState.paused	Se emite cada vez que la tarea está en pausa.
TaskState.success	Se emite cuando la tarea se ha completado correctamente.
TaskState.canceled	Se emite cada vez que se cancela la tarea.
TaskState.error	Se emite cuando falla la carga. Esto puede suceder debido a tiempos de espera de la red, fallas de autorización o si cancela la tarea.
mountainsRef.putFile(file).snapshotEvents.listen((taskSnapshot) {
    switch (taskSnapshot.state) {
        case TaskState.running:
            // ...
            break;
        case TaskState.paused:
            // ...
            break;
        case TaskState.success:
            // ...
            break;
        case TaskState.canceled:
            // ...
            break;
        case TaskState.error:
            // ...
            break;
        }
    });

Ejemplo
final appDocDir = await getApplicationDocumentsDirectory();
final filePath = "${appDocDir.absolute}/path/to/mountains.jpg";
final file = File(filePath);
// Create the file metadata
final metadata = SettableMetadata(contentType: "image/jpeg");
// Create a reference to the Firebase Storage bucket
final storageRef = FirebaseStorage.instance.ref();
// Upload file and metadata to the path 'images/mountains.jpg'
final uploadTask = storageRef
    .child("images/path/to/mountains.jpg")
    .putFile(file, metadata);

// Listen for state changes, errors, and completion of the upload.
uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
    switch (taskSnapshot.state) {
        case TaskState.running:
            final progress =
                100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
            print("Upload is $progress% complete.");
            break;
        case TaskState.paused:
            print("Upload is paused.");
            break;
        case TaskState.canceled:
            print("Upload was canceled");
            break;
        case TaskState.error:
            // Handle unsuccessful uploads
            break;
        case TaskState.success:
            // Handle successful uploads on complete
            // ...
            break;
    }
});
