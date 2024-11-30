import 'package:flutter/material.dart';
import 'package:gestion_ambiental_2/views/auth/login.dart';
import 'package:gestion_ambiental_2/views/auth/register.dart';
import 'package:gestion_ambiental_2/views/home/homepage.dart';
import 'package:gestion_ambiental_2/views/residuos/add_residuos.dart';
import 'package:gestion_ambiental_2/views/residuos/residuos.dart';
import 'package:gestion_ambiental_2/views/roles/add_rol.dart';
import 'package:gestion_ambiental_2/views/roles/rol_list.dart';
import 'package:gestion_ambiental_2/views/tratamientos/tratamiento.dart';
import 'package:gestion_ambiental_2/views/usuarios/usuarios_list.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const Login()),
        GetPage(name: '/register', page: () => const Register()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/usuarios', page: () => UserListView()),
        GetPage(name: '/roles', page: () => RolesViews()),
        GetPage(name: '/addRoles', page: () => const AddEditRolesViews()),
        GetPage(name: '/residuo', page: () => ResiduosViews()),
        GetPage(name: '/addResiduo', page: () => const AddEditResiduosViews()),
        GetPage(name: '/tratamiento', page: () => TratamientosPage()),
      
      ],
    );
  }
}
