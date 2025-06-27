import 'package:app_simasoft/data/model/User/user.model.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

Requets requetsFromJson(String str) => Requets.fromJson(json.decode(str));

String requetsToJson(Requets data) => json.encode(data.toJson());

class Requets { 
    int amount; 
    String? status; 
    int id;
    int? companyId;
    String? type;
    String? createdAt;

    Requets({ 
        required this.id,
        required this.amount,  
        required this.type,
        required this.status, 
        required this.createdAt, 
    });

    Requets copyWith({ 
        int? id, 
        int? amount,
        String? status,
        String? type,
        String? createdAt,

    }) => 
        Requets(
            id: id ?? this.id,   
            amount: amount ?? this.amount, 
            type: type ?? this.type,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
        );

    factory Requets.fromJson(Map<String, dynamic> json) => Requets( 
        id: json["id"], 
        amount: json["amount"], 
        type: json["type"], 
        status: json["status"],  
        createdAt: json["createdAt"] 
    );

    Map<String, dynamic> toJson() => {
        "id": id, 
        "amount": amount, 
        "type": type, 
        "status": status,
        "createdAt": createdAt
    };
}
