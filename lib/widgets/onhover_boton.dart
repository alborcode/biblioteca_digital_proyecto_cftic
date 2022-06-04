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

class OnHoverBoton extends StatefulWidget {
  final Widget child;

  const OnHoverBoton({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  OnHoverBotonState createState() => OnHoverBotonState();
}

class OnHoverBotonState extends State<OnHoverBoton>{
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final hoveredTransforma = Matrix4.identity()..scale(1.1);
    //final hoveredTransform = Matrix4.identity()..translate(12, -8, 0);
    final transforma = isHovered ? hoveredTransforma: Matrix4.identity();
    return MouseRegion(
      onEnter: (event) => onEntered(true),
      onExit: (event) => onEntered(false),
        child: AnimatedContainer(
          duration: const Duration (milliseconds: 200),
          transform: transforma,
            child: widget.child
        )
    );
  }

  void onEntered(bool isHovered) => setState((){
    this.isHovered = isHovered;
  });

}