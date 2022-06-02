/*
* Clase Card actualizada para importar donde se usen Cards en la APP
* Tendrá mismas caracteristicas y se pasará el controlador y el hinttext
* true o false para obscuretext (para password no aparezcan caracteres)
* tambien se mandara el tipo de teclado a mostrar con ese campo de texto
* para rellenar email    -> TextInputType.emailAddress
* para rellenar texto    -> TextInputType.text
* para rellenar numeros  -> TextInputType.number
* para rellenar fechas   -> TextInputType.datetime
* para rellenar importes -> TextInputType.numberWithOptions
*/

import 'package:flutter/material.dart';

import 'package:biblioteca_digital_proyecto_cftic/theme/app_theme.dart';

class CardImagen extends StatelessWidget {
  // La Url de la imagen es obligatoria, el texto de pie de pagina no
  final String imageurl;
  final String? textoPie;

  const CardImagen({
    Key? key,
    required this.imageurl,
    this.textoPie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      // Para que no se salga la imagen y respete los bordes redondeados
      clipBehavior: Clip.antiAlias,
      // Definimos los bordes
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      // Decimos que la sombra la genere con el color primario y con opacidad del 50%
      shadowColor: AppTheme.primario.withOpacity(0.5),
      elevation: 10,
      child: Column(
        children: [
          // Con FadeinImage muestra la imagen haciendo Fade desde una imagen original en assets
          FadeInImage(
            image: NetworkImage(imageurl),
            placeholder: const AssetImage('assets/images/Books.png'),
            // Damos de ancho todo el disponible en la pantalla
            width: double.infinity,
            height: 230,
            // Decimos que la imagen se adapte a todo el tamaño posible
            fit: BoxFit.cover,
            // Definimos duracion de la animación
            fadeInDuration: const Duration(milliseconds: 300),
          ),
          // Sacamos el contenedor con el pie de foto si no es nulo
          if (textoPie != null)
            Container(
                // Añadimos alineacion en el container para que se justifique a la derecha
                alignment: AlignmentDirectional.centerEnd,
                padding: const EdgeInsets.only(right: 20, top: 10, bottom: 10),
                // Si nos han pasado el Texto del Pie de foto lo ponemos sino ''
                //child: Text(textoPie ?? '')
                // Si entra en if tendra valor por lo que añadimos el nullcheck (!)
                child: Text(textoPie!)
            ),
        ],
      ),
    );
  }
}
