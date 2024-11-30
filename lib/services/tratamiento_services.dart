import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/tratamiento.dart';

class TratamientoService {
  final String baseUrl = 'http://127.0.0.1:8000/api';

  Future<List<Tratamiento>> fetchTratamientos() async {
    final response = await http.get(Uri.parse('$baseUrl/tratamiento'));

    if (response.statusCode == 200) {
      // Parseamos la lista de JSON a una lista de objetos Tratamiento
      List<dynamic> jsonList = json.decode(response.body);
      return Tratamiento.listFromJson(jsonList);
    } else {
      throw Exception('Error al obtener los tratamientos: ${response.statusCode}');
    }
  }
}
