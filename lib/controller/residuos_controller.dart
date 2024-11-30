import 'package:get/get.dart';
import 'package:gestion_ambiental_2/models/residuos.dart';
import 'package:gestion_ambiental_2/services/residuos_services.dart';

class ResiduoController extends GetxController {
  final ResiduoService residuoService;

  var residuos = <Residuo>[].obs;
  var filteredResiduos = <Residuo>[].obs;
  var isLoading = false.obs;

  ResiduoController({required this.residuoService});

  @override
  void onInit() {
    super.onInit();
    fecthResiduos();
  }

  void fecthResiduos() async {
    isLoading.value = true;
    try {
      final fetchedResiduos = await residuoService.fecthResiduos();
      residuos.value = fetchedResiduos;
      filteredResiduos.value = fetchedResiduos;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void filterResiduos(String query) {
    if (query.isEmpty) {
      filteredResiduos.value = residuos;
    } else {
      filteredResiduos.value = residuos
          .where((residuo) => residuo.nombre_residuo
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    }
  }

  // void deleteResiduo(int id) async {
  //   isLoading.value = true;
  //   try {
  //     await residuoService.deleteResiduo(id);
  //     residuos.removeWhere((residuo) => residuo.id == id);
  //     filteredResiduos.removeWhere((residuo) => residuo.id == id);
  //     Get.snackbar('Éxito', 'Residuo eliminado correctamente');
  //   } catch (e) {
  //     Get.snackbar('Error', e.toString());
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  Future<void> createResiduo(Residuo residuo) async {
    isLoading.value = true;
    try {
      final response = await residuoService.createResiduo(residuo);
      if (response['resultado'] == 1) {
        fecthResiduos(); // Actualiza la lista tras añadir
        Get.snackbar('Éxito', response['mensaje']);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateResiduo(Residuo residuo) async {
    isLoading.value = true;
    try {
      final response = await residuoService.updateResiduo(residuo);
      if (response['resultado'] == 1) {
        int index =
            residuos.indexWhere((r) => r.idResiduo == residuo.idResiduo);
        if (index != -1) {
          residuos[index] = residuo;
          residuos.refresh();
        }
        Get.snackbar('Éxito', response['mensaje']);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteResiduo(int idResiduo) async {
    isLoading.value = true;
    try {
      final response = await residuoService.deleteResiduo(idResiduo);
      if (response['resultado'] == 1) {
        residuos.removeWhere((residuo) => residuo.idResiduo == idResiduo);
        Get.snackbar('Éxito', response['mensaje']);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
