class Tratamiento {
  final int idTratamiento;
  final String nombreTratamiento;
  final String descripcion;
  final int idResponsable;
  final String responsableNombre;
  final String responsableEmail;

  Tratamiento({
    required this.idTratamiento,
    required this.nombreTratamiento,
    required this.descripcion,
    required this.idResponsable,
    required this.responsableNombre,
    required this.responsableEmail,
  });

  // Factory constructor para crear una instancia desde JSON
  factory Tratamiento.fromJson(Map<String, dynamic> json) {
    return Tratamiento(
      idTratamiento: json['id_tratamiento'] as int,
      nombreTratamiento: json['nombre_tratamiento'] as String,
      descripcion: json['descripcion'] as String,
      idResponsable: json['id_responsable'] as int,
      responsableNombre: json['responsable_nombre'] as String,
      responsableEmail: json['responsable_email'] as String,
    );
  }

  // Método para convertir una instancia a JSON
  Map<String, dynamic> toJson() {
    return {
      'id_tratamiento': idTratamiento,
      'nombre_tratamiento': nombreTratamiento,
      'descripcion': descripcion,
      'id_responsable': idResponsable,
      'responsable_nombre': responsableNombre,
      'responsable_email': responsableEmail,
    };
  }

  // Factory para crear una lista de Tratamientos desde una lista JSON
  static List<Tratamiento> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => Tratamiento.fromJson(json)).toList();
  }

  // Método para convertir una lista de Tratamientos a una lista JSON
  static List<Map<String, dynamic>> listToJson(List<Tratamiento> tratamientos) {
    return tratamientos.map((tratamiento) => tratamiento.toJson()).toList();
  }
}
