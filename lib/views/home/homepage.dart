import 'package:flutter/material.dart';
import 'package:gestion_ambiental_2/controller/estadisticas_controller.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:gestion_ambiental_2/controller/auth_controller.dart';
import 'package:gestion_ambiental_2/models/user_menu.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final DashboardController dashboardController =
      Get.put(DashboardController());
  final AuthController controlu = Get.find();

  @override
  Widget build(BuildContext context) {
    final UserMenu user = UserMenu(
      name: controlu.userMenu!.nombre,
      email: controlu.userMenu!.email,
      avatarUrl: controlu.userMenu!.fotoUrl,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      drawer: _buildDrawer(context, user),
      body: Obx(() {
        if (dashboardController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (dashboardController.error.value.isNotEmpty) {
          return Center(
              child: Text('Error: ${dashboardController.error.value}'));
        }

        final tableStats = dashboardController.tableStats;
        final chartData = dashboardController.chartData;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Estadísticas de Tablas",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              // Tarjetas de estadísticas
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tableStats.length,
                  itemBuilder: (context, index) {
                    final stat = tableStats[index];
                    return _buildStatCard(
                      stat['nombre_tabla'],
                      stat['cantidad_registros'],
                    );
                  },
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                "Residuos Totales por Mes",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              // Gráfico de líneas
              Expanded(
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(
                    title: AxisTitle(text: "Meses"),
                    labelPlacement: LabelPlacement.onTicks,
                  ),
                  primaryYAxis: NumericAxis(
                    title: AxisTitle(text: "Total Residuos"),
                  ),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  title:
                      ChartTitle(text: 'Gráfico de Residuos Totales por Mes'),
                  series: <ChartSeries>[
                    LineSeries<Map<String, dynamic>, String>(
                      dataSource: chartData,
                      xValueMapper: (data, _) => [
                        'Ene',
                        'Feb',
                        'Mar',
                        'Abr',
                        'May',
                        'Jun',
                        'Jul',
                        'Ago',
                        'Sep',
                        'Oct',
                        'Nov',
                        'Dic'
                      ].elementAt(data['mes'] - 1),
                      yValueMapper: (data, _) => data['total_residuos'],
                      name: 'Residuos',
                      markerSettings: const MarkerSettings(isVisible: true),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  // Método para construir las tarjetas de estadísticas
  Widget _buildStatCard(String title, int count) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              count.toString(),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  // Método para construir el Drawer
  Drawer _buildDrawer(BuildContext context, UserMenu user) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user.name),
            accountEmail: Text(user.email),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(user.avatarUrl),
            ),
            decoration: BoxDecoration(color: Colors.blue.shade700),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => Get.toNamed('/'),
          ),
          ListTile(
            leading: const Icon(Icons.person_pin_outlined),
            title: const Text('Gestionar Usuarios'),
            onTap: () => Get.toNamed('/usuarios'),
          ),
          ListTile(
            leading: const Icon(Icons.person_add_alt),
            title: const Text('Gestionar Roles'),
            onTap: () => Get.toNamed('/roles'),
          ),
          ListTile(
            leading: const Icon(Icons.recycling),
            title: const Text('Residuos'),
            onTap: () => Get.toNamed('/residuo'),
          ),
          ListTile(
            leading: const Icon(Icons.medical_information_rounded),
            title: const Text('Gestion de Tratamientos'),
            onTap: () => Get.toNamed('/tratamiento'),
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout'),
            onTap: () {
              Get.snackbar('Logout', 'You have been logged out.');
            },
          ),
        ],
      ),
    );
  }
}
