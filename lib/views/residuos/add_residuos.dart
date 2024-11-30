import 'package:flutter/material.dart';
import 'package:gestion_ambiental_2/controller/residuos_controller.dart';
import 'package:gestion_ambiental_2/models/residuos.dart';
import 'package:gestion_ambiental_2/views/widget/input.dart';
import 'package:get/get.dart';

class AddEditResiduosViews extends StatelessWidget {
  const AddEditResiduosViews({super.key});

  @override
  Widget build(BuildContext context) {
    final ResiduoController residuoController = Get.find();

    // Verificar si se recibe un objeto para edición
    final Residuo? residuo = Get.arguments; // Objeto pasado desde navegación

    // Controladores de texto para los campos
    final TextEditingController txtTipo = TextEditingController(
      text: residuo?.nombre_residuo ?? '', // Prellenar si es edición
    );
    final TextEditingController txtDescripcion = TextEditingController(
      text: residuo?.descripcion ?? '', // Prellenar si es edición
    );

    final bool isEditing = residuo != null; // Modo edición si hay residuo

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Residuo' : 'Adicionar Residuo'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double cardWidth =
              constraints.maxWidth > 580 ? 500 : constraints.maxWidth * 0.9;

          return SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    width: cardWidth,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          isEditing
                              ? 'Formulario de Edición de Residuo'
                              : 'Formulario de Adición de Residuo',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        InputText(
                          controlador: txtTipo,
                          titulo: 'Tipo de Residuo',
                        ),
                        const SizedBox(height: 16),
                        InputText(
                          controlador: txtDescripcion,
                          titulo: 'Descripción',
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            if (isEditing) {
                              // Modo edición
                              final editedResiduo = Residuo(
                                idResiduo: residuo.idResiduo,
                                nombre_residuo: txtTipo.text,
                                descripcion: txtDescripcion.text,
                              );
                              residuoController
                                  .updateResiduo(editedResiduo)
                                  .then((_) {
                                Get.snackbar(
                                    'Éxito', 'Residuo editado correctamente');
                                Get.back(); // Cierra la vista
                              });
                            } else {
                              // Modo adición
                              final newResiduo = Residuo(
                                idResiduo: 0,
                                nombre_residuo: txtTipo.text,
                                descripcion: txtDescripcion.text,
                              );
                              residuoController
                                  .createResiduo(newResiduo)
                                  .then((_) {
                                Get.snackbar(
                                    'Éxito', 'Residuo creado correctamente');
                                Get.back(); // Cierra la vista
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: Text(isEditing ? 'Actualizar' : 'Guardar'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
