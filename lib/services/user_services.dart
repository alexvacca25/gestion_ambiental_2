import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/user_model.dart';

class UserService {
  final String baseUrl = 'http://127.0.0.1:8000/api';

  // Obtener todos los usuarios
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/usuarios'));

      if (response.statusCode == 200) {
        final List<dynamic> usersJson = jsonDecode(response.body);
        return usersJson.map((json) => UserModel.fromJson(json)).toList();
      } else {
        throw Exception('Error al obtener usuarios');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Map<String, dynamic>> updateUser(UserModel userData) async {
    try {
      print(userData.toJson());
      final url = Uri.parse('$baseUrl/usuarios/estado');
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode( userData.toJson()),
      );

      print(response.body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body); // Devuelve la respuesta como un mapa
      } else {
        throw Exception('Error al actualizar el usuario: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
