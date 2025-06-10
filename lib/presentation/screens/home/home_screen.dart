import 'package:app_simasoft/core/utils/dimensions.dart';
import 'package:app_simasoft/core/utils/my_color.dart';
import 'package:app_simasoft/core/utils/style.dart';
import 'package:app_simasoft/data/controllers/loan/loan_controller.dart';
import 'package:app_simasoft/data/controllers/user/user_controller.dart';
import 'package:app_simasoft/data/model/Loan_applications/Loan_applications.dart';
import 'package:app_simasoft/data/model/User/user.model.dart';
import 'package:app_simasoft/presentation/screens/home/widgets/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  User? user;
  LoanApplications? loan;

  Future<void> loadRequest(String title, String typeRequest, int userId, int companyId) async {
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
    loan = loanController.currentLoan ;
    setState(() {});
  }

  Future<void> loadUser() async {
    final result = await userController.getUser();
    setState(() {
      user = result;
    });
  }

  @override
  void initState() {
    super.initState();
    userController = Get.find<UserController>();
    loadUser();
    findLoan();
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    body: LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
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
                          "👋 Hola, ${user?.fullName}",
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
                          borderRadius: BorderRadius.circular(Dimensions.cardMediumRadius),
                          color: MyColor.colorWhite,
                        ),
                        child: Column(
                          children: [
                            Text("Saldo pendiente", style: semiBoldOverLarge),
                            Text("\$ ${loan?.currentLoanAmount ?? 0}", style: boldOverMega),
                          ],
                        ),
                      ),
                      SizedBox(height: Dimensions.space16),
                      CardRequest(
                        icon: Iconsax.favorite_chart_copy,
                        text: "Adelanto de nómina",
                        callback: () => loadRequest("Solicitud de adelanto de nomina", "PAYROLL_ADVANCE", loan!.clientId, loan!.companyId),
                      ),
                      SizedBox(height: Dimensions.space16),
                      CardRequest(
                        icon: Iconsax.wallet_money_copy,
                        text: "Retanqueo de crédito",
                        callback: () => loadRequest("Solicitud de retanqueo", "REFUELING", loan!.clientId, loan!.companyId),
                      ),
                      SizedBox(height: Dimensions.space16),
                      CardRequest(
                        icon: Iconsax.gift_copy,
                        text: "Bono de cumpleaños",
                        callback: () => loadRequest("", "", 0, 0),
                      ),

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
                              borderRadius: BorderRadius.circular(Dimensions.space10),
                            ),
                            backgroundColor: MyColor.iconsColor,
                          ),
                          child: Text('Ir a pagar', style: boldHomeOverLarge),
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
