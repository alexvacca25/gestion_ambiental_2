import 'package:flutter/material.dart';
import 'package:gestion_ambiental_2/controller/rol_controller.dart';
import 'package:gestion_ambiental_2/services/rol_services.dart';

import 'package:get/get.dart';

class RolesViews extends StatelessWidget {
  RolesViews({super.key});

  final RolController rolController = Get.put(
    RolController(rolService: RolService()),
  );

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Roles'),
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
                rolController.filterRoles(value);
              },
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (rolController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (rolController.filteredRoles.isEmpty) {
          return const Center(child: Text('No hay residuos disponibles'));
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount =
                constraints.maxWidth > 580 ? 6 : 1; // Ajusta columnas
            double childAspectRatio =
                constraints.maxWidth > 580 ? 0.7 : 0.8; // Ajusta proporción

            return GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 9.0,
                mainAxisSpacing: 9.0,
                childAspectRatio: childAspectRatio,
              ),
              itemCount: rolController.filteredRoles.length,
              itemBuilder: (BuildContext context, int index) {
                final rol = rolController.filteredRoles[index];

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
                          child: Text(rol.nombreRol[0]),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          rol.nombreRol,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          rol.descripcion,
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
                                Get.toNamed('/addRoles', arguments: rol);
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
                                  rolController.deleteRol(rol.idRol);
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
          Get.toNamed('/addRoles');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
