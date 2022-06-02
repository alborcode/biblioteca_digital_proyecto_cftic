class Libro {
  final int idLibro;
  final String titulo;
  final String autor;
  final String tematica;
  final String urlDescarga;
  final String imagenPortada;
  final String body;

  Libro({
    this.idLibro = 0,
    required this.titulo,
    required this.autor,
    required this.tematica,
    required this.urlDescarga,
    required this.imagenPortada,
    required this.body
  });

  factory Libro.fromJson(Map<String, dynamic> json) {
    return Libro(
      idLibro: json['idLibro'],
      titulo: json['titulo'],
      autor: json['autor'],
      tematica: json['tematica'],
      urlDescarga: json['urlDescarga'],
      imagenPortada: json['imagenPortada'],
      body: json['body'],
    );
  }
}