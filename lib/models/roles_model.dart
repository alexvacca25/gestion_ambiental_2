class Rol {
  final int idRol;
  final String nombreRol;
  final String descripcion;

  Rol({
    required this.idRol,
    required this.nombreRol,
    required this.descripcion,
  });

  // Factory constructor para crear una instancia desde JSON
  factory Rol.fromJson(Map<String, dynamic> json) {
    return Rol(
      idRol: json['id_rol'] as int,
      nombreRol: json['nombre_rol'] as String,
      descripcion: json['descripcion'] as String,
    );
  }

  // Método para convertir una instancia a JSON
  Map<String, dynamic> toJson() {
    return {
      'id_rol': idRol,
      'nombre_rol': nombreRol,
      'descripcion': descripcion,
    };
  }

  // Factory para crear una lista de Residuos desde una lista JSON
  static List<Rol> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => Rol.fromJson(json)).toList();
  }

  // Método para convertir una lista de Residuos a una lista JSON
  static List<Map<String, dynamic>> listToJson(List<Rol> roles) {
    return roles.map((rol) => rol.toJson()).toList();
  }
}
