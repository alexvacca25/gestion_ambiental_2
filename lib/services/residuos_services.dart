import 'dart:convert';

import 'package:gestion_ambiental_2/models/residuos.dart';
import 'package:http/http.dart' as http;

class ResiduoService {
  final String baseURL;

  ResiduoService({this.baseURL = "http://127.0.0.1:8000/api"});

  Future<List<Residuo>> fecthResiduos() async {
    final url = Uri.parse('$baseURL/residuos');
    print(url);
    final response = await http.get(url);
    print(response);
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return Residuo.listFromJson(jsonData);
    } else {
      throw Exception('Error al Obtener Residuos: ${response.reasonPhrase}');
    }
  }

  Future<Map<String, dynamic>> createResiduo(Residuo residuo) async {
    final url = Uri.parse('$baseURL/residuos');
    print(json.encode(residuo.toJson()));
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(residuo.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al Crear Residuo: ${response.reasonPhrase}');
    }
  }


Future<Map<String, dynamic>> updateResiduo(Residuo residuo) async {
    final url = Uri.parse('$baseURL/residuos');
    final response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "id_residuo": residuo.idResiduo,
        "nombre_residuo": residuo.nombre_residuo,
        "descripcion": residuo.descripcion,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al Actualizar Residuo: ${response.reasonPhrase}');
    }
  }


   Future<Map<String, dynamic>> deleteResiduo(int idResiduo) async {
    final url = Uri.parse('$baseURL/residuos');
    final response = await http.delete(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({"id_residuo": idResiduo}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al Eliminar Residuo: ${response.reasonPhrase}');
    }
  }
}
