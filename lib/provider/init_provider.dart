import 'package:flutter/material.dart';
import 'package:moneysender/Models/transaction.dart';
import 'package:moneysender/Models/users_model.dart';
import 'package:moneysender/Services/user_service.dart';

class InitProvider with ChangeNotifier{
  UserModel _user = UserModel(id: '', token: '', user: '', balance: 0);
  List<TransactionModel> _userTrans = [];

  UserModel get user => _user;
  List<TransactionModel> get userTrans => _userTrans;

  void setUser(String id, token, user, double balance){
    _user = UserModel(id: id, token: token, user: user, balance: balance);
    notifyListeners();
  }

  Future<bool> sendMoneyToFakeJson(BuildContext context,String sendTo, double amount)async{
         UserService serv = UserService();
         await serv.sendMoneyPost(context, amount, );
    return   await serv.addTransaction(context, amount, sendTo);
    // return true;
  }

  void getTransactions(BuildContext context) async {
    UserService serv = UserService();
    List<TransactionModel> trans = await serv.getTransactions(context);
    _userTrans = trans;

    notifyListeners();
  }

    void getAllTransactions(BuildContext context) async {
    UserService serv = UserService();
    List<TransactionModel> trans = await serv.getTransactions(context);
    _userTrans = trans;

    notifyListeners();
  }

 
}