import 'dart:convert';

import 'package:app_simasoft/core/utils/my_strings.dart';
import 'package:app_simasoft/data/model/Loan_applications/Loan_applications.dart';
import 'package:app_simasoft/data/model/User/user.model.dart';
import 'package:app_simasoft/data/model/auth/login_response_model.dart';
import 'package:app_simasoft/data/model/response_model/response_model.dart';
import 'package:app_simasoft/data/repository/loan_repo.dart';
import 'package:get/get.dart'; 

class LoanController extends GetxController {
  Rxn<User> user = Rxn<User>();
  Rx<LoanApplications?> loan = Rx<LoanApplications?>(null);
  LoanRepo loanRepo;
  LoanController({required this.loanRepo});
 
  void setLoan(LoanApplications newLoan) {
    loan.value = newLoan;
  }
 
  LoanApplications? get currentLoan => loan.value;

  Future loanFilterByClient() async { 
    update();

    ResponseModel model = await loanRepo.loanFilterByClient();

    if (model.statusCode == 200 || model.statusCode == 201) {
      List<dynamic> loans = jsonDecode(model.responseJson); 
      Map<String, dynamic> firstLoan = loans.isNotEmpty ? loans.first : null;

      LoanApplications loanModel = LoanApplications.fromJson(firstLoan);

      final loanController = Get.find<LoanController>();

      if (loanModel.status.toString().toLowerCase() ==
          MyStrings.activeM.toLowerCase()) { 
          dynamic? user = loanModel ;

        // ⬇️ Aquí guardas el usuario en el controlador global 
        if (user != null) {
          loanController.setLoan(user);
        }
 
      } 
    }  
    
    update();
  }
}
