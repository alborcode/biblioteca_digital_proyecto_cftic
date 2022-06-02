import 'package:flutter/material.dart';

class Boton extends StatelessWidget {
  // la accion del boton y el texto son obligatorios
  const Boton({
    Key? key,
    required this.accion,
    required this.icono,
    required this.texto,
  }) : super(key: key);

  // La accion es de tipo Callback ya que se envia una funcion con la accion
  final VoidCallback accion;
  final IconData icono;
  final String texto;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          // Ponemos un tamaño minimo al boton
          //minimumSize: const Size(double.infinity, 1),
          //padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          padding: const EdgeInsets.all(8.0),
          // Redondeamos los botones
          shape: const StadiumBorder(),
      ),
      onPressed: accion,
      // Padding del boton
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            //Align(alignment: Alignment.center),
            Icon(icono),
            // Padding entre icono y texto
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(texto,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    wordSpacing: 1,
                    letterSpacing: 1
                )
              ),
            ),
          ],
        ),
      )
    );
  }
}
