class UserRegister {
  final String email;
  final String password;
  final String fechaCreacion;

  UserRegister({
    required this.email,
    required this.password,
    required this.fechaCreacion,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'fecha_creacion': fechaCreacion,
    };
  }

  factory UserRegister.fromJson(Map<String, dynamic> json) {
    return UserRegister(
      email: json['email'],
      password: json['password'],
      fechaCreacion: json['fecha_creacion'],
    );
  }
}
