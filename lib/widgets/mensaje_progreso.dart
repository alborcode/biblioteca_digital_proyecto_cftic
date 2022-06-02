import 'package:flutter/material.dart';

// Al no ser nombre de clase por convencion va en minuscula
void mensajeProgreso(BuildContext context, String filename, double progress) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: ListTile(
        title: Text(filename),
        subtitle: progress != null
          ? LinearProgressIndicator(
                value: progress,
              backgroundColor: Colors.brown,
            )
          : null,
        /*trailing: IconButton(
          icon: const Icon(
            Icons.download,
            color: Colors.black,
          ),
          onPressed: () => donwloadFileURL(file),
        ),*/
      )
    )
  );
}
