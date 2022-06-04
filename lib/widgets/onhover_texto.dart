/*
*
* CLASE PARA CREAR UN BOTON CON ICONO
* Se enviara como parametros
* - icono: de tipo Icondata (Icons.nombredeicono)
* - texto: texto que aparecerá en el botón
* - accion: funcion que se ejecutará al presionar el botón
*
 */

import 'package:flutter/material.dart';
// Libreria para animaciones
import 'package:sprung/sprung.dart';

class OnHoverTexto extends StatefulWidget {
  final Widget child;

  const OnHoverTexto({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  OnHoverTextoState createState() => OnHoverTextoState();
}

class OnHoverTextoState extends State<OnHoverTexto>{
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final hoveredTransforma = Matrix4.identity()
      ..translate(8, 0, 0)
      ..scale(1.1);
    final transforma = isHovered ? hoveredTransforma: Matrix4.identity();
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) => dentro(true),
      onExit: (event) => dentro(false),
        child: AnimatedContainer(
          //curve: Sprung.overDamped,
          duration: const Duration (milliseconds: 300),
          transform: transforma,
            child: widget.child
        )
    );
  }

  void dentro(bool isHovered) => setState((){
    this.isHovered = isHovered;
  });

}