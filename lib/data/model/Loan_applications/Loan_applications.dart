import 'package:app_simasoft/data/model/User/user.model.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

LoanApplications loanApplicationsFromJson(String str) => LoanApplications.fromJson(json.decode(str));

String loanApplicationsToJson(LoanApplications data) => json.encode(data.toJson());

class LoanApplications {
    int clientId;
    int companyId;
    int amount;
    String bankName;
    String type;
    User? user;

    LoanApplications({
        required this.clientId,
        required this.companyId,
        required this.amount,
        required this.bankName,
        required this.type,
        this.user,
    });

    LoanApplications copyWith({
        int? clientId,
        int? companyId,
        int? amount,
        String? bankName,
        String? type,
    }) => 
        LoanApplications(
            clientId: clientId ?? this.clientId,
            companyId: companyId ?? this.companyId,
            amount: amount ?? this.amount,
            bankName: bankName ?? this.bankName,
            type: type ?? this.type,
        );

    factory LoanApplications.fromJson(Map<String, dynamic> json) => LoanApplications(
        clientId: json["clientId"],
        companyId: json["companyId"],
        amount: json["amount"],
        bankName: json["bankName"],
        type: json["type"],
        user: json["user"] != null ? User.fromJson(json["user"]) : null,
    );

    Map<String, dynamic> toJson() => {
        "clientId": clientId,
        "companyId": companyId,
        "amount": amount,
        "bankName": bankName,
        "type": type,
        "user": user?.toJson(),
    };
}
