import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:moneysender/Models/transaction.dart';
import 'package:moneysender/provider/init_provider.dart';
import 'package:provider/provider.dart';

class UserService {
  Future<void> sendMoneyPost(BuildContext context, double sendingMoney) async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/todos/1'),
      // body: {}
    );
    var jsondata = json.decode(response.body);
    sendMoneyTofirebaseDb(context, sendingMoney);
  }

  Future<void> sendMoneyTofirebaseDb(
      BuildContext context, double sendingMoney) async {
    var user = context.read<InitProvider>().user;
    double newBalance = user.balance - sendingMoney;
    DocumentReference users =
        await FirebaseFirestore.instance.collection('users').doc(user.id);
    return users.update({'balance': newBalance}).then((value) {
      final userProvider = context.read<InitProvider>();
      userProvider.setUser(user.id, user.token, user.user, newBalance);
    });
  }

  Future<bool> addTransaction(
      BuildContext context, double sendingMoney, String sendTo) async {
    final userProvider = context.read<InitProvider>();
    CollectionReference trans =
        await FirebaseFirestore.instance.collection('transactions');
    return trans.add({
      'sender': userProvider.user.user,
      'amountSend': sendingMoney,
      'receiver': sendTo,
      'date': DateTime.now()
    }).then((value) {
      return true;
    });
  }

  Future<List<TransactionModel>> getTransactions(BuildContext context) async {
    List<TransactionModel> trans = [];
    final userProvider = context.read<InitProvider>();
    var collection = FirebaseFirestore.instance
        .collection('transactions')
        .where('sender', isEqualTo: userProvider.user.user).limit(10);
    var querySnapshots = await collection.get();
    for (var snapshot in querySnapshots.docs) {
      var documentID = snapshot.id; // <-- Document ID
      TransactionModel temp = TransactionModel(
          amountSend: double.parse(snapshot['amountSend'].toString()),
          id: documentID,
          sender: snapshot['sender'],
          receiver: snapshot['receiver'],
          date: snapshot['date'].toDate());
          trans.add(temp);
    }
    return trans;
  }

  Future<List<TransactionModel>> getAllTransactions(BuildContext context) async {
    List<TransactionModel> trans = [];
    final userProvider = context.read<InitProvider>();
    var collection = FirebaseFirestore.instance
        .collection('transactions')
        .where('email', isEqualTo: userProvider.user.user);
    var querySnapshots = await collection.get();
    for (var snapshot in querySnapshots.docs) {
      var documentID = snapshot.id; // <-- Document ID
      TransactionModel temp = TransactionModel(
          amountSend: snapshot['amountSend'],
          id: documentID,
          sender: snapshot['sender'],
          receiver: snapshot['receiver'],
          date: snapshot['date'].toDate());
          trans.add(temp);
    }
    return trans;
  }
}
