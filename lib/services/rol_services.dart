import 'dart:convert';

import 'package:gestion_ambiental_2/models/roles_model.dart';
import 'package:http/http.dart' as http;

class RolService {
  final String baseURL;

  RolService({this.baseURL = "http://127.0.0.1:8000/api"});

  Future<List<Rol>> fecthRol() async {
    final url = Uri.parse('$baseURL/roles');
    print(url);
    final response = await http.get(url);
    print(response);
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return Rol.listFromJson(jsonData);
    } else {
      throw Exception('Error al Obtener Residuos: ${response.reasonPhrase}');
    }
  }

  Future<Map<String, dynamic>> createRol(Rol rol) async {
    final url = Uri.parse('$baseURL/roles');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(rol.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al Crear Residuo: ${response.reasonPhrase}');
    }
  }

  Future<Map<String, dynamic>> updateRol(Rol rol) async {
    final url = Uri.parse('$baseURL/roles');
    final response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(rol.toJson()),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al Actualizar Residuo: ${response.reasonPhrase}');
    }
  }

  Future<Map<String, dynamic>> deleteRol(int idRol) async {
    final url = Uri.parse('$baseURL/roles');
    final response = await http.delete(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({"id_rol": idRol}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al Eliminar Residuo: ${response.reasonPhrase}');
    }
  }
}
