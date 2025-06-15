import 'dart:ui';
import 'package:app_simasoft/core/utils/dimensions.dart';
import 'package:app_simasoft/core/utils/my_color.dart';
import 'package:app_simasoft/data/controllers/profile/profile_controller.dart';
import 'package:app_simasoft/data/repository/profile_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';



class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileDetailScreenState createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    Get.put(ProfileRepo(apiClient: Get.find()));
    Get.put(ProfileController(profileRepo: Get.find()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: const Text("Perfil"),
          centerTitle: true,
        ),
        body: GetBuilder<ProfileController>(
          builder:
              (controller) => SingleChildScrollView(
            child: Container(
              padding:  EdgeInsets.all(Dimensions.space16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: Dimensions.space16),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(Dimensions.space16),
                                child: Image.asset("assets/avatar.png",
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: Dimensions.space16),
                              Text("",
                                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                              ),
                              SizedBox(height: Dimensions.space16),
                              Divider(height: 1, color: Colors.grey[200]),
                              SizedBox(height: Dimensions.space16),
                              //_buildDetailRow("Teléfono", widget.user.fullName ?? "No disponible"),
                              //_buildDetailRow("Cédula", widget.user.email ?? "No registrada"),

                            ],
                          ),
                        ),
                        /*widget.user.rolName == "pollster" ? Positioned(
                          top: 8,
                          right: 8,
                          child: IconButton(
                            icon: Icon(Icons.more_vert, color: Colors.grey[700]),
                            onPressed: () {
                              _showBottomSheet(context);
                            },
                          ),
                        ) : SizedBox.shrink(),*/
                      ],
                    ),
                  ),
                ],
              ),
            ),

                ),
        ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          title: const Text("Opciones", style: TextStyle(fontWeight: FontWeight.bold)),
          message: Column(
            children: [
              _customSheetAction(
                icon: CupertinoIcons.add_circled_solid,
                text: "Asignar vivienda",
                color: MyColor.primaryColor,
                onTap: () {

                },
              ),
              _customSheetAction(
                icon: CupertinoIcons.pencil,
                text: "Editar datos del encuestador",
                color: MyColor.primaryColor,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              _customSheetAction(
                icon: CupertinoIcons.trash,
                text: "Eliminar al encuestador",
                color: CupertinoColors.destructiveRed,
                onTap: () {

                },
              ),
            ],
          ),
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            isDefaultAction: true,
            child: const Text("Cancelar", style: TextStyle(color: Colors.black)),
          ),
        );
      },
    );
  }

  Widget _customSheetAction({
    required IconData icon,
    required String text,
    required Color color,
    required VoidCallback onTap,
  }) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(color: color, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, String id) {
    showCupertinoDialog(
      context: context,
      builder: (dialogContext) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: CupertinoAlertDialog(
            title: const Text("¿Estás seguro?", style: TextStyle(fontWeight: FontWeight.bold)),
            content: const Text("Esta acción eliminará al encuestador permanentemente."),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text("Cancelar"),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  // authBloc.add(ProfileUpdateEvent());
                  Navigator.pop(dialogContext);
                },
                isDestructiveAction: true,
                child: const Text("Eliminar"),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$title :", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
          Text(value, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
        ],
      ),
    );
  }
}
