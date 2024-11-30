import 'package:flutter/material.dart';

import 'package:gestion_ambiental_2/controller/rol_controller.dart';

import 'package:gestion_ambiental_2/models/roles_model.dart';
import 'package:gestion_ambiental_2/views/widget/input.dart';
import 'package:get/get.dart';

class AddEditRolesViews extends StatelessWidget {
  const AddEditRolesViews({super.key});

  @override
  Widget build(BuildContext context) {
    final RolController rolController = Get.find();

    // Verificar si se recibe un objeto para edición
    final Rol? rol = Get.arguments; // Objeto pasado desde navegación

    // Controladores de texto para los campos
    final TextEditingController txtTipo = TextEditingController(
      text: rol?.nombreRol ?? '', // Prellenar si es edición
    );
    final TextEditingController txtDescripcion = TextEditingController(
      text: rol?.descripcion ?? '', // Prellenar si es edición
    );

    final bool isEditing = rol != null; // Modo edición si hay residuo

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Rol' : 'Adicionar Rol'),
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
                              ? 'Formulario de Edición de Roles'
                              : 'Formulario de Adición de Roles',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        InputText(
                          controlador: txtTipo,
                          titulo: 'Nombre de Rol',
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
                              final editedRol = Rol(
                                idRol: rol.idRol,
                                nombreRol: txtTipo.text,
                                descripcion: txtDescripcion.text,
                              );
                              rolController
                                  .updateRol(editedRol)
                                  .then((_) {
                                Get.snackbar(
                                    'Éxito', 'Residuo editado correctamente');
                                Get.back(); // Cierra la vista
                              });
                            } else {
                              // Modo adición
                              final newRol = Rol(
                                idRol: 0,
                                nombreRol: txtTipo.text,
                                descripcion: txtDescripcion.text,
                              );
                              rolController
                                  .createRol(newRol)
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
