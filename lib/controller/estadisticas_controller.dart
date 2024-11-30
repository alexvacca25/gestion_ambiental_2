import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DashboardController extends GetxController {
  final String baseUrl = 'http://127.0.0.1:8000';

  // Variables observables
  var tableStats = <Map<String, dynamic>>[].obs; // Estadísticas de tablas
  var chartData = <Map<String, dynamic>>[].obs; // Datos para el gráfico
  var isLoading = true.obs; // Estado de carga
  var error = ''.obs; // Estado de error

  @override
  void onInit() {
    super.onInit();
    fetchDashboardData();
  }

  Future<void> fetchDashboardData() async {
    try {
      isLoading.value = true;
      error.value = '';

      // Fetch table statistics
      final tableResponse =
          await http.get(Uri.parse('$baseUrl/api/estadisticas/panel'));
      if (tableResponse.statusCode == 200) {
        tableStats.value =
            List<Map<String, dynamic>>.from(json.decode(tableResponse.body));
      } else {
        throw Exception('Error fetching table statistics');
      }

      // Fetch chart data
      final chartResponse =
          await http.get(Uri.parse('$baseUrl/api/estadisticas/grafico'));
      if (chartResponse.statusCode == 200) {
        chartData.value =
            List<Map<String, dynamic>>.from(json.decode(chartResponse.body));
      } else {
        throw Exception('Error fetching chart data');
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
