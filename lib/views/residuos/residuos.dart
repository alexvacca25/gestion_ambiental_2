import 'package:flutter/material.dart';
import 'package:gestion_ambiental_2/services/residuos_services.dart';
import 'package:get/get.dart';
import 'package:gestion_ambiental_2/controller/residuos_controller.dart';

class ResiduosViews extends StatelessWidget {
  ResiduosViews({super.key});

  final ResiduoController residuoController = Get.put(
    ResiduoController(residuoService: ResiduoService()),
  );

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Residuos'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Buscar residuos...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) {
                residuoController.filterResiduos(value);
              },
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (residuoController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (residuoController.filteredResiduos.isEmpty) {
          return const Center(child: Text('No hay residuos disponibles'));
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount =
                constraints.maxWidth > 580 ? 6 : 2; // Ajusta columnas
            double childAspectRatio =
                constraints.maxWidth > 580 ? 0.9 : 0.8; // Ajusta proporción

            return GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: childAspectRatio,
              ),
              itemCount: residuoController.filteredResiduos.length,
              itemBuilder: (BuildContext context, int index) {
                final residuo = residuoController.filteredResiduos[index];

                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          child: Text(residuo.nombre_residuo[0]),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          residuo.nombre_residuo,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          residuo.descripcion,
                          style: const TextStyle(fontSize: 14.0),
                          textAlign: TextAlign.center,
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                Get.toNamed('/addResiduo', arguments: residuo);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                // Llama al controlador para eliminar el residuo
                                final result = await Get.defaultDialog(
                                  title: 'Confirmación',
                                  middleText:
                                      '¿Estás seguro de que deseas eliminar este residuo?',
                                  textConfirm: 'Sí',
                                  textCancel: 'No',
                                  confirmTextColor: Colors.white,
                                  onConfirm: () {
                                    Get.back(
                                        result:
                                            true); // Retorna verdadero si se confirma
                                  },
                                  onCancel: () {
                                    Get.back(
                                        result:
                                            false); // Retorna falso si se cancela
                                  },
                                );

                                if (result == true) {
                                  residuoController
                                      .deleteResiduo(residuo.idResiduo);
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/addResiduo');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
