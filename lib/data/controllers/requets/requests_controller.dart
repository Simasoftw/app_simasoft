import 'dart:convert';
import 'package:app_simasoft/core/route/route.dart';
import 'package:app_simasoft/data/model/Loan_applications/Loan_applications.dart';
import 'package:app_simasoft/data/model/response_model/response_model.dart';
import 'package:app_simasoft/data/repository/requets_repo.dart';
import 'package:app_simasoft/presentation/widgets/dialog/alertMessage.dart';
import 'package:app_simasoft/presentation/widgets/snack_bar/show_custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestController extends GetxController {
  RequetsRepo requetsRepo;
  RequestController({required this.requetsRepo});

  TextEditingController amountController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();

  bool isSubmitLoading = false;
  void requestLoan(int userId, int companyId, String typeRequest, context) async {

    ResponseModel model = await requetsRepo.payrollAdvance(
        amountController.text.toString(),
        bankNameController.text.toString(),
        userId,
        companyId,
        typeRequest
    );

    if (model.statusCode == 200 || model.statusCode == 201) {
      LoanApplications applications = LoanApplications.fromJson(
        jsonDecode(model.responseJson),
      );
      Navigator.of(context).pop();
      if (applications != null) { 
        AlertScreen(message: "Registro huardado con exito", title: "Solicitud enviada", icon:  Icons.check_circle, colorIcon: Color(0xFF01e63d),).mostrarAlerta(context);
      } else {
        AlertScreen(message: "Ha ocurrido un error al enviar la solicitud", title: "Error", icon: Icons.cancel, colorIcon: Color(0xFFf03705) ).mostrarAlerta(context);
      }
    } else {
      Navigator.of(context).pop();
      return  AlertScreen(message: model.message, title: "Aviso", icon: Icons.info, colorIcon: Colors.blue ).mostrarAlerta(context);

      // CustomSnackBar.error(errorList: model.message);
    }

    isSubmitLoading = false;
    update();

   
  }

   Future<LoanApplications?> requestByClient(int userId) async {

    ResponseModel model = await requetsRepo.getRequets( 
        userId 
    );

    if (model.statusCode == 200 || model.statusCode == 201) {
      LoanApplications applications = LoanApplications.fromJson(
        jsonDecode(model.responseJson),
      );

      if (applications != null) {
        return applications;
      }  
    }  

    return null; 
  }
}
