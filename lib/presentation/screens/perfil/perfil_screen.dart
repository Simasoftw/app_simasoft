import 'package:app_simasoft/data/repository/login_repo.dart';
import 'package:app_simasoft/data/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:app_simasoft/data/controllers/auth/login_controller.dart';
import 'package:app_simasoft/core/utils/my_color.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient: Get.find()));
    Get.put(LoginController(loginRepo: Get.find()));

    super.initState();
  }

  Widget build(BuildContext context) {
    // Asegura que el controller esté disponible

    return Scaffold(
      backgroundColor: MyColor.primaryColor, // morado oscuro
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: const Text("Tu perfil"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GetBuilder<LoginController>(
                builder:
                    (controller) => SingleChildScrollView(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: MyColor.secondaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                const CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  controller.nombreUsuario,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  '# de tu Celular',
                                  style: TextStyle(color: Colors.white70),
                                ),
                                Text(
                                  controller.celular,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          _opcionTile(Iconsax.setting_2, 'Ajustes'),
                          _opcionTile(
                            Iconsax.document,
                            'Documentos y certificados',
                          ),
                          _opcionTile(Iconsax.info_circle, 'Ayuda'),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
              ),
            ),

            // Zona fija al final
            const Divider(color: Colors.white54),
            ListTile(
              onTap: () {
                Get.find<LoginController>().logoutUser();
              },
              leading: const Icon(Iconsax.logout, color: Colors.white),
              title: const Text("Salir", style: TextStyle(color: Colors.white)),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Última conexión 02 de junio de 2025",
                    style: TextStyle(color: Colors.white38, fontSize: 12),
                  ),
                  Text(
                    "Versión 6.0.43",
                    style: TextStyle(color: Colors.white38, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _opcionTile(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.white,
        size: 16,
      ),
      onTap: () {
        // Acción pendiente
      },
    );
  }
}
