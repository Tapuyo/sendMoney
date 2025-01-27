// To parse this JSON data, do
//
//     final transactionModel = transactionModelFromJson(jsonString);

import 'dart:convert';

TransactionModel transactionModelFromJson(String str) => TransactionModel.fromJson(json.decode(str));

String transactionModelToJson(TransactionModel data) => json.encode(data.toJson());

class TransactionModel {
    String id;
    double amountSend;
    String sender;
    String receiver;
    DateTime date;

    TransactionModel({
        required this.id,
        required this.amountSend,
        required this.sender,
        required this.receiver,
        required this.date,
    });

    factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
        id: json["id"],
        amountSend: json["amountSend"],
        sender: json["sender"],
        receiver: json["receiver"],
        date: json["date"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "amountSend": amountSend,
        "sender": sender,
        "receiver": receiver,
        "date": date,
    };
}
