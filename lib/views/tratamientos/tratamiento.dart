import 'package:flutter/material.dart';
import 'package:gestion_ambiental_2/controller/tratamiento_controller.dart';
import 'package:get/get.dart';

class TratamientosPage extends StatelessWidget {
  final TratamientoController controller = Get.put(TratamientoController());

  TratamientosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tratamientos'),
      ),
      body: Column(
        children: [
          // Campo de texto para buscar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                controller
                    .filtrarTratamientos(value); // Filtramos en tiempo real
              },
              decoration: InputDecoration(
                labelText: 'Buscar tratamientos',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              if (controller.tratamientosFiltrados.isEmpty) {
                return Center(child: Text('No se encontraron tratamientos.'));
              }

              // Obtenemos el tamaño de la pantalla
              final screenWidth = MediaQuery.of(context).size.width;
              final crossAxisCount = screenWidth > 580 ? 6 : 1;

              return GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount, // Responsivo
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 1, // Relación de aspecto de las tarjetas
                ),
                itemCount: controller.tratamientosFiltrados.length,
                itemBuilder: (context, index) {
                  final tratamiento = controller.tratamientosFiltrados[index];
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            tratamiento.nombreTratamiento,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 8),
                          Text(
                            tratamiento.descripcion,
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 12),
                          // Chip redondeado para mostrar el nombre del responsable
                          Chip(
                            label: Text(
                              tratamiento.responsableNombre,
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
