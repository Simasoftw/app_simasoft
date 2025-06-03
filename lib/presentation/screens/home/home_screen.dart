import 'package:app_simasoft/core/utils/dimensions.dart';
import 'package:app_simasoft/core/utils/my_color.dart';
import 'package:app_simasoft/core/utils/style.dart';
import 'package:app_simasoft/presentation/screens/home/widgets/profile.dart';
import 'package:flutter/material.dart';


import 'widgets/card_item_requets.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'widgets/detail_loan.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  Future<void> loadRequest(String title, String typeRequest) async {
    showDialog(
      context: context,
      builder: (context) => LoanSelectorWidget(
        title: title ,
        selectedIndex: '1', // O el valor dinámico que tengas
        nameCustomer: 'Juan Pérez',
        typeRequest: '', // También puedes pasar el nombre del cliente
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: MyColor.homeColor,
        width: Dimensions.widthFull,
        padding: EdgeInsets.symmetric(horizontal: Dimensions.space16),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Dimensions.space10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text("👋 Hola, Carlo",
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: Dimensions.space25,
                            color: MyColor.colorWhite
                        ),
                      ),
                      const Text("¡Bienvenido, de vuelta!",
                        style: TextStyle(
                            color: MyColor.colorWhite
                        ),
                      ),
                    ],
                  ),
                  Profile()

                ],
              ),
              SizedBox(height: Dimensions.space16),
              Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.space16,
                      vertical: Dimensions.space16
                  ),
                  width: Dimensions.widthFull,
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.cardMediumRadius),
                  color: MyColor.colorWhite,

                ),
                child: Column(
                  children: [
                    Text("Saldo pendiente"),
                    SizedBox(
                      height: Dimensions.space8,
                    ),
                    Text("5.000.000", style: boldOverMega,),
                  ],
                )
              ),
              SizedBox(
                height: Dimensions.space16,
              ),
              CardRequest(
                icon: Iconsax.favorite_chart_copy,
                text: "Adelanto de nómina",
                callback: () =>  loadRequest(
                    "Solicitud de adelanto de nomina",
                    "PAYROLL_ADVANCE"
                ),
              ),
              SizedBox(
                height: Dimensions.space16,
              ),
              CardRequest(
                icon: Iconsax.wallet_money_copy,
                text: "Retanqueo de crédito",
                callback: () =>  loadRequest(
                    "Solicitud de retanqueo",
                    "REFUELING"
                ),
              ),
              SizedBox(
                height: Dimensions.space16,
              ),
              CardRequest(
                icon: Iconsax.gift_copy,
                text: "Bono de cumpleaños",

                callback: () =>  loadRequest(
                  "",
                  ""
                ),
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: Expanded(
                  child: ElevatedButton(
                    onPressed: ()=>{},
                    style: ElevatedButton.styleFrom(
                      padding:  EdgeInsets.symmetric(vertical: Dimensions.space15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.space10)),
                      backgroundColor: MyColor.colorAmber,
                    ),
                    child:  Text('Ir a pagar', style: boldOverWhiteLarge),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.space16),
            ],
          ),
        ),
      ),
    );
  }
}
