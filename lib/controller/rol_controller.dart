import 'package:gestion_ambiental_2/models/roles_model.dart';
import 'package:gestion_ambiental_2/services/rol_services.dart';
import 'package:get/get.dart';


class RolController extends GetxController {
  final RolService rolService;

  var roles = <Rol>[].obs;
  var filteredRoles = <Rol>[].obs;
  var isLoading = false.obs;

  RolController({required this.rolService});

  @override
  void onInit() {
    super.onInit();
    fecthRoles();
  }

  void fecthRoles() async {
    isLoading.value = true;
    try {
      final fetchedRoles = await rolService.fecthRol();
      roles.value = fetchedRoles;
      filteredRoles.value = fetchedRoles;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void filterRoles(String query) {
    if (query.isEmpty) {
      filteredRoles.value = roles;
    } else {
      filteredRoles.value = roles
          .where((rol) =>
              rol.nombreRol.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  Future<void> createRol(Rol rol) async {
    isLoading.value = true;
    try {
      final response = await rolService.createRol(rol);
      if (response['resultado'] == 1) {
        fecthRoles(); // Actualiza la lista tras añadir
        Get.snackbar('Éxito', response['mensaje']);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateRol(Rol rol) async {
    isLoading.value = true;
    try {
      final response = await rolService.updateRol(rol);
      if (response['resultado'] == 1) {
        fecthRoles();

        Get.snackbar('Éxito', response['mensaje']);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteRol(int idRol) async {
    isLoading.value = true;
    try {
      final response = await rolService.deleteRol(idRol);
      if (response['resultado'] == 1) {
        fecthRoles();
        Get.snackbar('Éxito', response['mensaje']);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
