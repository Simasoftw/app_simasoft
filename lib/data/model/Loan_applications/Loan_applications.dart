import 'package:app_simasoft/data/model/User/user.model.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

LoanApplications loanApplicationsFromJson(String str) => LoanApplications.fromJson(json.decode(str));

String loanApplicationsToJson(LoanApplications data) => json.encode(data.toJson());

class LoanApplications { 
    int currentLoanAmount; 
    String? status; 
    int id;
    int companyId;
    String? type;
    int clientId;

    LoanApplications({ 
        required this.id,
        required this.currentLoanAmount, 
        required this.companyId, 
        required this.type,
        required this.status, 
        required this.clientId, 
    });

    LoanApplications copyWith({ 
        int? id,
        required int companyId,
        int? currentLoanAmount,
        String? status,
        String? type,
        required int clientId,

    }) => 
        LoanApplications(
            id: id ?? this.id, 
            companyId: companyId , 
            currentLoanAmount: currentLoanAmount ?? this.currentLoanAmount, 
            type: type ?? this.type,
            status: status ?? this.status,
            clientId: clientId ,
        );

    factory LoanApplications.fromJson(Map<String, dynamic> json) => LoanApplications( 
        id: json["id"], 
        companyId: json["companyId"], 
        currentLoanAmount: json["currentLoanAmount"] ?? json["amount"] , 
        type: json["type"], 
        status: json["status"], 
        clientId: json["clientId"], 
    );

    Map<String, dynamic> toJson() => {
        "id": id, 
        "currentLoanAmount": currentLoanAmount, 
        "type": type, 
        "status": status,
        "clientId": clientId
    };
}
