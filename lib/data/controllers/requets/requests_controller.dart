import 'dart:convert';
import 'package:app_simasoft/data/model/response_model/response_model.dart';
import 'package:app_simasoft/data/repository/requets_repo.dart';
import 'package:app_simasoft/presentation/widgets/snack_bar/show_custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RequestController extends GetxController {
  RequetsRepo requetsRepo;
  RequestController({required this.requetsRepo});

  TextEditingController amountController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();

  bool isSubmitLoading = false;
  void requestLoan() async {
    final model = await requetsRepo.payrollAdvance(
        double.parse(amountController.text.replaceAll(',', '')),
        "NEQUI"
    );

    ResponseModel decodedResponse = jsonDecode(model.responseJson);
    final message = decodedResponse.message ?? 'Ocurrió un error desconocido';

    if(decodedResponse.statusCode ==  200 || decodedResponse.statusCode ==  201){
      CustomSnackBar.success(

          successList: message,
      );
    } else {
      CustomSnackBar.error(
          errorList: message
      );
    }

    isSubmitLoading = false;
    update();
  }

}
