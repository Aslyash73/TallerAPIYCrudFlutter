class Usuario {
  final String id;
  final String nombre;
  final String apellidos;
  final String correo;
  final String genero;
  final String telefono;

  Usuario(
      {required this.id,
      required this.nombre,
      required this.apellidos,
      required this.correo,
      required this.genero,
      required this.telefono});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['CLI_ID'],
      nombre: json['CLI_NOMBRES'],
      apellidos: json['CLI_APELLIDOS'],
      correo: json['CLI_CORREO'],
      genero: json['CLI_GENERO'],
      telefono: json['CLI_TELEFONO'],
    );
  }
}
