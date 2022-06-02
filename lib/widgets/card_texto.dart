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

class CardTexto extends StatelessWidget {

  const CardTexto({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const ListTile(
            leading: Icon(Icons.photo, color: AppTheme.primario,),
            title: Text('Soy un titulo'),
            subtitle: Text('Ad et cillum incididunt duis Lorem consectetur'),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {},
                    child: const Text('Cancel'),
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text('Ok')
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
