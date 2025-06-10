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
  final int userId;
  final int companyId;

  const LoanSelectorWidget({
    Key? key,
    required this.selectedIndex,
    required this.nameCustomer,
    required this.typeRequest,
    required this.title,
    required this.userId,
    required this.companyId
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
                SizedBox(height: Dimensions.space10),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 100,
                  child: TextFormField(
                    controller: controller.amountController,
                    inputFormatters: [ TextInputMask(mask: '9,999,999,999,999', placeholder: '0', reverse: true)],
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    autofocus: false,
                    style: boldOverMega,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "0",
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
                    controller.requestLoan(widget.userId, widget.companyId, widget.typeRequest);
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
