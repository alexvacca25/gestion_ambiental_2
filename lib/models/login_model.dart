class AuthenticatedUser {
  final int idUsuario;
  final String nombre;
  final String email;
  final String estado;
  final String fotoUrl;
  final String telefono;
  final String cargo;
  final String profesion;
  final String token;

  AuthenticatedUser({
    required this.idUsuario,
    required this.nombre,
    required this.email,
    required this.estado,
    required this.fotoUrl,
    required this.telefono,
    required this.cargo,
    required this.profesion,
    required this.token,
  });

  factory AuthenticatedUser.fromJson(Map<String, dynamic> json) {
    return AuthenticatedUser(
      idUsuario: json['data']['id_usuario'],
      nombre: json['data']['nombre'] ?? '',
      email: json['data']['email'],
      estado: json['data']['estado'],
      fotoUrl: json['data']['foto_url'] ?? '',
      telefono: json['data']['telefono'] ?? '',
      cargo: json['data']['cargo'] ?? '',
      profesion: json['data']['profesion'] ?? '',
      token: json['token'],
    );
  }
}
