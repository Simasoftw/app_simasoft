import 'dart:convert';

import 'package:app_simasoft/core/utils/my_strings.dart';
import 'package:app_simasoft/data/model/Loan_applications/Loan_applications.dart';
import 'package:app_simasoft/data/model/User/user.model.dart';
import 'package:app_simasoft/data/model/auth/login_response_model.dart';
import 'package:app_simasoft/data/model/response_model/response_model.dart'; 
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart'; 

class UserController extends GetxController {
  Rxn<User> user = Rxn<User>();
  Rx<LoanApplications?> loan = Rx<LoanApplications?>(null);
  // UserRepo userRepo;
  // UserController({required this.userRepo});

  void setUser(User newUser) {
    user.value = newUser;
  }

  void setLoan(LoanApplications newLoan) {
    loan.value = newLoan;
  }

  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonUser = prefs.getString('user');
    if (jsonUser != null) {
      return User.fromJson(jsonDecode(jsonUser));
    }
    return null;
  }

  User? get currentUser => user.value; 
}
