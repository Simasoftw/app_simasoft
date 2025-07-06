import 'dart:convert';

import 'package:app_simasoft/core/utils/dimensions.dart';
import 'package:app_simasoft/core/utils/my_color.dart';
import 'package:app_simasoft/core/utils/style.dart';
import 'package:app_simasoft/data/controllers/loan/loan_controller.dart';
import 'package:app_simasoft/data/controllers/requets/requests_controller.dart';
import 'package:app_simasoft/data/controllers/user/user_controller.dart';
import 'package:app_simasoft/data/model/Loan_applications/Loan_applications.dart';
import 'package:app_simasoft/data/model/User/user.model.dart';
import 'package:app_simasoft/data/model/requets/requets.dart';
import 'package:app_simasoft/presentation/screens/home/widgets/profile.dart';
import 'package:app_simasoft/presentation/screens/perfil/solicitudHistory_screen.dart';
import 'package:app_simasoft/presentation/widgets/icons/iconNotification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'widgets/card_item_requets.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets/detail_loan.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late UserController userController;
  late RequestController requetsController;
  User? user;
  LoanApplications? loan;
  List<Requets>? requets;
  final formatter = NumberFormat("#,##0", "en_US");

  Future<void> loadRequest(
    String title,
    String typeRequest,
    int userId,
    int companyId,
    String titleButton,
  ) async {
    showDialog(
      context: context,
      builder:
          (context) => LoanSelectorWidget(
            title: title,
            selectedIndex: '1', // O el valor dinámico que tengas
            nameCustomer: 'Juan Pérez',
            userId: userId,
            companyId: companyId,
            typeRequest: typeRequest,
            titleButton: titleButton,
          ),
    );
  }

  Future<void> abrirNequi() async {
    const nequiScheme = 'nequi://'; // Ejemplo, debe ser el correcto para Nequi

    if (await canLaunchUrl(Uri.parse(nequiScheme))) {
      await launchUrl(Uri.parse(nequiScheme));
    } else {
      // Si no está instalada, abre Play Store
      const playStoreUrl =
          'https://play.google.com/store/apps/details?id=com.nequi.MobileApp';
      if (await canLaunchUrl(Uri.parse(playStoreUrl))) {
        await launchUrl(
          Uri.parse(playStoreUrl),
          mode: LaunchMode.externalApplication,
        );
      } else {
        throw 'No se pudo abrir Nequi ni Play Store.';
      }
    }
  }

  Future<void> findLoan() async {
    final loanController = Get.find<LoanController>();
    await loanController.loanFilterByClient();
    loan = loanController.currentLoan;
    if(loan?.clientId != null){
      loadRequets(loan!.clientId ?? 0);
      setState(() {});
    }
   
  }

  Future<void> loadUser() async {
    final result = await userController.getUser();
    setState(() {
      user = result;
    });
  }

  Future<void> loadRequets(int id) async {
    final result = await requetsController.requetsRepo.getRequets(id);
    final responseJson = jsonDecode(result.responseJson);
    setState(() {
      requets =
          (responseJson as List).map((item) => Requets.fromJson(item)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    userController = Get.find<UserController>();
    requetsController = Get.find<RequestController>();
    loadUser();
    findLoan();
  }

  @override
  Widget build(BuildContext context) {
    if (user == null || loan == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Inicio',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: Dimensions.space20,
            color: MyColor.colorWhite,
          ),
        ),
        backgroundColor: MyColor.homeColor,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: NotificationIcon(
              notificationCount: requets?.length ?? 0,
              onTap: () {
                Get.to(() => SolicitudHistoryScreen(dataRequets: requets));
              },
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Container(
                  color: MyColor.homeColor,
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.space16),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Dimensions.space10),
                        Profile(),
                        Center(
                          child: Text(
                            "👋 Hola, ${user?.fullName.split(" ")[0]}",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: Dimensions.space25,
                              color: MyColor.colorWhite,
                            ),
                          ),
                        ),
                        SizedBox(height: Dimensions.space16),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.space16,
                            vertical: Dimensions.space16,
                          ),
                          width: Dimensions.widthFull,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              Dimensions.cardMediumRadius,
                            ),
                            color: MyColor.colorWhite,
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Crédito Actual",
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  fontSize: Dimensions.space20,
                                  color: MyColor.primaryTextColor,
                                ),
                              ),
                              Text(
                                "\$ ${formatter.format(loan?.currentLoanAmount ?? 0)}",
                                style: boldOverMega,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: Dimensions.space16),
                        CardRequest(
                          icon: Iconsax.favorite_chart_copy,
                          text: "Adelanto de nómina",
                          callback:
                              () => loadRequest(
                                "Solicitud de adelanto de nomina",
                                "PAYROLL_ADVANCE",
                                loan?.clientId ?? 0,
                                loan?.companyId ?? 0,
                                "Solicitar Adelanto",
                              ),
                        ),
                        SizedBox(height: Dimensions.space16),
                        CardRequest(
                          icon: Iconsax.wallet_money_copy,
                          text: "Retanqueo de crédito",
                          callback:
                              () => loadRequest(
                                "Solicitud de retanqueo",
                                "REFUELING",
                                loan?.clientId ?? 0,
                                loan?.companyId ?? 0,
                                "Solicitar Retanqueo",
                              ),
                        ),
                        SizedBox(height: Dimensions.space16),
                        CardRequest(
                          icon: Iconsax.gift_copy,
                          text: "Bono de cumpleaños",
                          callback: () => (),
                          typeLoan: "Bono de cumpleaños",
                        ),

                        SizedBox(height: Dimensions.space16),
                        // 🟨 Aquí agregamos espacio flexible si hay poco contenido
                        Expanded(child: Container()),

                        // 🟩 Botón pegado al fondo
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => abrirNequi(),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                vertical: Dimensions.space15,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  Dimensions.space10,
                                ),
                              ),
                              backgroundColor: MyColor.iconsColor,
                            ),
                            child: Text(
                              'Ir a pagar',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                fontSize: Dimensions.space20,
                                color: MyColor.homeColor,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: Dimensions.space16),
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
