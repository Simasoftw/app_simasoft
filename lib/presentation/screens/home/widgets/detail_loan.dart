import 'package:app_simasoft/core/utils/dimensions.dart';
import 'package:app_simasoft/core/utils/my_color.dart';
import 'package:app_simasoft/core/utils/style.dart';
import 'package:app_simasoft/data/controllers/requets/requests_controller.dart';
import 'package:app_simasoft/data/repository/requets_repo.dart';
import 'package:app_simasoft/data/services/api_service.dart';
import 'package:app_simasoft/presentation/widgets/button/rounded_button.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

class LoanSelectorWidget extends StatefulWidget {
  final String selectedIndex;
  final String nameCustomer;
  final String typeRequest;
  final String title;

  const LoanSelectorWidget({
    Key? key,
    required this.selectedIndex,
    required this.nameCustomer,
    required this.typeRequest,
    required this.title,
  }) : super(key: key);

  @override
  _LoanSelectorWidgetState createState() => _LoanSelectorWidgetState();
}

class _LoanSelectorWidgetState extends State<LoanSelectorWidget> {
  int? _value;
  String period = "SEMANAL";
  final valueLoan = TextEditingController();
  final NumberFormat numSanitizedFormat = NumberFormat('en_US');

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(RequetsRepo(apiClient: Get.find()));
    Get.put(RequestController(requetsRepo: Get.find()));

    super.initState();
  }

  @override
  void dispose() {
    valueLoan.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        padding:  EdgeInsets.all(Dimensions.space16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.cardRadius),
          color: const Color(0xD5D6D6D8),
        ),
        child: GetBuilder<RequestController>(
          builder: (controller) =>  SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title,
                  style: boldOverLarge
                ),
                SizedBox(height: Dimensions.space16),
                Text(
                  "Seleccionar el período de tiempo",
                  style: TextStyle(fontSize: Dimensions.space16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: Dimensions.space8),
                Wrap(
                  spacing: 5.0,
                  children: [
                    _buildChip('Semanal', 0, 'SEMANAL'),
                    _buildChip('Quincenal', 1, 'QUINCENAL'),
                    _buildChip('Mensual', 2, 'MENSUAL'),
                  ],
                ),
                SizedBox(height: Dimensions.space16),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 100,
                  child: TextFormField(
                    controller: controller.amountController,
                    inputFormatters: [ TextInputMask(mask: '9,999,999,999,999.99', placeholder: '0', maxPlaceHolders: 3, reverse: true)],
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    autofocus: false,
                    style: TextStyle(
                      fontSize: valueLoan.text.isEmpty
                          ? 60.0
                          : 60.0 -
                          (valueLoan.text.length *
                              2), // Ajuste del tamaño del texto basado en la longitud del texto
                      color: Color(0xFF22014D),
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "0.00",
                      hintStyle: TextStyle(
                        fontSize: 64.0,
                        color: Color(0xFF22014D),
                      ),
                    ),
                    textAlign: TextAlign.center,
                    onChanged: (text) => setState(() {}),
                  ),
                ),

                RoundedButton(
                  isLoading: controller.isSubmitLoading,
                  text: 'Solicitar adelanto',
                  press: () {
                    controller.requestLoan();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ChoiceChip _buildChip(String label, int index, String value) {
    return ChoiceChip(
      label: Text(label),
      selected: _value == index,
      onSelected: (selected) {
        setState(() {
          _value = selected ? index : null;
          period = value;
        });
      },
    );
  }
}
