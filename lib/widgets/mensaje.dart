import 'package:flutter/material.dart';

// Al no ser nombre de clase por convencion va en minuscula
void mensaje(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}
