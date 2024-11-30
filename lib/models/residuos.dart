class Residuo {
  final int idResiduo;
  final String nombre_residuo;
  final String descripcion;

  Residuo({
    required this.idResiduo,
    required this.nombre_residuo,
    required this.descripcion,
  });

  // Factory constructor para crear una instancia desde JSON
  factory Residuo.fromJson(Map<String, dynamic> json) {
    return Residuo(
      idResiduo: json['id_residuo'] as int,
      nombre_residuo: json['tipo_residuo'] as String,
      descripcion: json['descripcion'] as String,
    );
  }

  // Método para convertir una instancia a JSON
  Map<String, dynamic> toJson() {
    return {
      'id_residuo': idResiduo,
      'nombre_residuo': nombre_residuo,
      'descripcion': descripcion,
    };
  }

  // Factory para crear una lista de Residuos desde una lista JSON
  static List<Residuo> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => Residuo.fromJson(json)).toList();
  }

  // Método para convertir una lista de Residuos a una lista JSON
  static List<Map<String, dynamic>> listToJson(List<Residuo> residuos) {
    return residuos.map((residuo) => residuo.toJson()).toList();
  }
}
