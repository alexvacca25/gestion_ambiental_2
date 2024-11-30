class UserModel {
  final int idUsuario;
  final String nombre;
  final String email;
  var estado;
  final String fotoUrl;
  final String telefono;
  final String cargo;
  final String profesion;

  UserModel({
    required this.idUsuario,
    required this.nombre,
    required this.email,
    required this.estado,
    required this.fotoUrl,
    required this.telefono,
    required this.cargo,
    required this.profesion,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      idUsuario: json['id_usuario'],
      nombre: json['nombre'],
      email: json['email'],
      estado: json['estado'],
      fotoUrl: json['foto_url'],
      telefono: json['telefono'],
      cargo: json['cargo'],
      profesion: json['profesion'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_usuario': idUsuario,
      'nombre': nombre,
      'email': email,
      'estado': estado,
      'foto_url': fotoUrl,
      'telefono': telefono,
      'cargo': cargo,
      'profesion': profesion,
    };
  }
}
