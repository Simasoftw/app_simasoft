import 'package:app_simasoft/data/model/User/user.model.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

LoanApplications loanApplicationsFromJson(String str) => LoanApplications.fromJson(json.decode(str));

String loanApplicationsToJson(LoanApplications data) => json.encode(data.toJson());

class LoanApplications {
    int clientId;
    int companyId;
    double? amount;
    String bankName;
    String requestType;

    LoanApplications({
        required this.clientId,
        required this.companyId,
        this.amount,
        required this.bankName,
        required this.requestType,
    });

    LoanApplications copyWith({
        int? clientId,
        int? companyId,
        double? amount,
        String? bankName,
        String? type,
    }) => 
        LoanApplications(
            clientId: clientId ?? this.clientId,
            companyId: companyId ?? this.companyId,
            amount: amount ?? this.amount,
            bankName: bankName ?? this.bankName,
            requestType: requestType ?? this.requestType,
        );

    factory LoanApplications.fromJson(Map<String, dynamic> json) => LoanApplications(
        clientId: json["clientId"],
        companyId: json["companyId"],
        amount: json["amount"] != null
            ? (json["amount"] is String
            ? double.tryParse(json["amount"]) ?? 0
            : json["amount"].toDouble())
            : 0,
        bankName: json["bankName"],
        requestType: json["requestType"],
    );


    Map<String, dynamic> toJson() => {
        "clientId": clientId,
        "companyId": companyId,
        "amount": amount,
        "bankName": bankName,
        "requestType": requestType,
    };
}
