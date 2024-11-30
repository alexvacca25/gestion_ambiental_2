import 'package:gestion_ambiental_2/services/tratamiento_services.dart';
import 'package:get/get.dart';

import '../models/tratamiento.dart';

class TratamientoController extends GetxController {
  final TratamientoService _service = TratamientoService();

  var tratamientos = <Tratamiento>[].obs; // Lista observable de tratamientos
  var tratamientosFiltrados = <Tratamiento>[].obs; // Lista filtrada de tratamientos
  var isLoading = false.obs; // Estado de carga

  @override
  void onInit() {
    super.onInit();
    fetchTratamientos();
  }

  // Método para obtener los tratamientos desde el servicio
  void fetchTratamientos() async {
    isLoading.value = true;
    try {
      final data = await _service.fetchTratamientos();
      tratamientos.value = data;
      tratamientosFiltrados.value = data; // Inicialmente, los filtrados son iguales a todos
    } catch (e) {
      Get.snackbar('Error', 'No se pudieron cargar los tratamientos');
    } finally {
      isLoading.value = false;
    }
  }

  // Método para filtrar tratamientos por nombre o responsable
  void filtrarTratamientos(String query) {
    if (query.isEmpty) {
      // Si el filtro está vacío, mostramos todos los tratamientos
      tratamientosFiltrados.value = tratamientos;
    } else {
      // Filtramos por coincidencias en el nombre del tratamiento o del responsable
      tratamientosFiltrados.value = tratamientos.where((tratamiento) {
        final nombreTratamiento = tratamiento.nombreTratamiento.toLowerCase();
        final responsableNombre = tratamiento.responsableNombre.toLowerCase();
        final filtro = query.toLowerCase();

        return nombreTratamiento.contains(filtro) ||
            responsableNombre.contains(filtro);
      }).toList();
    }
  }
}
