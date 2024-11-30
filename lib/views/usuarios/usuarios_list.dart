import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gestion_ambiental_2/controller/user_controller.dart';

class UserListView extends StatelessWidget {
  UserListView({super.key});

  final UserController userController = Get.put(UserController());
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    userController.fetchUsers(); // Cargar los usuarios al inicializar

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Usuarios'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Buscar usuario...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) {
                userController.filterUsers(value);
              },
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (userController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (userController.filteredUsers.isEmpty) {
          return const Center(child: Text('No hay usuarios disponibles'));
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = constraints.maxWidth > 580 ? 6 : 1;
            return GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: crossAxisCount > 1 ? 1 : 0.85,
              ),
              itemCount: userController.filteredUsers.length,
              itemBuilder: (context, index) {
                final user = userController.filteredUsers[index];
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
                          backgroundImage: NetworkImage(user.fotoUrl),
                          radius: 50,
                        ),
                        const SizedBox(height: 12.0),
                        Text(
                          user.nombre,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 6.0),
                        Text(
                          user.email,
                          style: const TextStyle(
                              fontSize: 14.0, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 6.0),
                        RichText(
                          text: TextSpan(
                            text: 'Profesión: ',
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: user.profesion,
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6.0),
                        Text(
                          'Teléfono: ${user.telefono}',
                          style: const TextStyle(fontSize: 14.0),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Cargo: ${user.cargo}',
                          style: const TextStyle(fontSize: 14.0),
                          textAlign: TextAlign.center,
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Activo:'),
                            Checkbox(
                              value: user.estado == 'activo',
                              onChanged: (value) {
                                user.estado = value! ? 'activo' : 'inactivo';
                                userController.updateUser(user);
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
    );
  }
}
