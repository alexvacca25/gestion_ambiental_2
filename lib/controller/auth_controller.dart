import 'package:gestion_ambiental_2/models/login_model.dart';
import 'package:gestion_ambiental_2/models/register_model.dart';
import 'package:gestion_ambiental_2/services/auth_services.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthService _authService = Get.put(AuthService());

  // Métodos para manejar el registro
  Future<void> registerUser(String email, String password) async {
    final UserRegister user = UserRegister(
      email: email,
      password: password,
      fechaCreacion: DateTime.now().toIso8601String(),
    );

    final result = await _authService.registerUser(user.toJson());

    if (result['resultado'] == 1) {
      Get.snackbar('Éxito', result['mensaje'],
          snackPosition: SnackPosition.BOTTOM);
      // Redirigir a otra página si es necesario
      Get.toNamed('/login');
    } else {
      Get.snackbar('Error', result['mensaje'],
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  var authenticatedUser = Rxn<AuthenticatedUser>();

  // Método para manejar el inicio de sesión
  Future<void> loginUser(String email, String password) async {
    final result = await _authService.loginUser(email, password);
    print(result);
    if (result.containsKey('data')) {
      print(result['data']['estado']);
      if (result['data']['estado'] == 'activo') {
        authenticatedUser.value = AuthenticatedUser.fromJson(result);

        Get.snackbar('Éxito', result['mensaje'],
            snackPosition: SnackPosition.BOTTOM);
        Get.toNamed('/home'); // Redirige al usuario al home después del login
      } else {
        Get.snackbar('Error', 'Usuario Inactivo');
      }
    } else {
      Get.snackbar('Error', result['mensaje'],
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  AuthenticatedUser? get userMenu => authenticatedUser.value;
}
