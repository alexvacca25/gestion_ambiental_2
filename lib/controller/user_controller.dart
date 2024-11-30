import 'package:get/get.dart';
import '../models/user_model.dart';
import '../services/user_services.dart';

class UserController extends GetxController {
  final UserService _userService = UserService();

  var users = <UserModel>[].obs;
  var filteredUsers = <UserModel>[].obs;
  var isLoading = false.obs;

  Future<void> fetchUsers() async {
    isLoading.value = true;
    try {
      final fetchedUsers = await _userService.getUsers();
      users.value = fetchedUsers;
      filteredUsers.value = fetchedUsers; // Inicializar lista filtrada
    } catch (e) {
      Get.snackbar('Error', 'No se pudieron cargar los usuarios');
    } finally {
      isLoading.value = false;
    }
  }

  void filterUsers(String query) {
    if (query.isEmpty) {
      filteredUsers.value = users;
    } else {
      filteredUsers.value = users
          .where((user) =>
              user.nombre.toLowerCase().contains(query.toLowerCase()) ||
              user.email.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  Future<void> updateUser(UserModel userData) async {
    try {
      isLoading.value = true;
      final result = await _userService.updateUser(userData);

      filteredUsers.refresh();

      Get.snackbar('Éxito', 'Usuario actualizado correctamente');
    } catch (e) {
      Get.snackbar('Error', 'No se pudo actualizar el usuario');
    } finally {
      isLoading.value = false;
    }
  }
}
