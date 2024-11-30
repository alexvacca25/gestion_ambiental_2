import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService extends GetxService {
  final String baseUrl = 'http://127.0.0.1:8000/api/auth';

  Future<Map<String, dynamic>> registerUser(Map<String, dynamic> userData) async {
    try {
      final url = Uri.parse('$baseUrl/register');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userData),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Error al registrar usuario');
      }
    } catch (e) {
      return {'resultado': 0, 'mensaje': e.toString()};
    }
  }


 Future<Map<String, dynamic>> loginUser(String email, String password) async {
    try {
      final url = Uri.parse('$baseUrl/login');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      
      print(response.body);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Error al iniciar sesión');
      }
    } catch (e) {
      return {'mensaje': e.toString()};
    }
  }

}
