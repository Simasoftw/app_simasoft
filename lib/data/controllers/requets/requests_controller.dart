import 'dart:convert';
import 'package:app_simasoft/core/route/route.dart';
import 'package:app_simasoft/data/model/Loan_applications/Loan_applications.dart';
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

    ResponseModel model = await requetsRepo.payrollAdvance(
        amountController.text.toString(),
        bankNameController.text.toString()
    );

    if (model.statusCode == 200 || model.statusCode == 201) {
      LoanApplications applications = LoanApplications.fromJson(
        jsonDecode(model.responseJson),
      );

      if (applications != null) {

        CustomSnackBar.success(successList:  "Solicitud enviada",duration:  2, position: SnackPosition.TOP);

      } else {
        CustomSnackBar.error(
          errorList: "Ha ocurrido un error al enviar la solicitud",
        );
      }
    } else {
      CustomSnackBar.error(errorList: model.message);
    }

    isSubmitLoading = false;
    update();

    Get.toNamed(RouteHelper.forgotPasswordScreen);
  }
}
