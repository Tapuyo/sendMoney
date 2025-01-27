import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:moneysender/Models/transaction.dart';
import 'package:moneysender/UI/SendMoneyPage.dart';
import 'package:moneysender/provider/init_provider.dart';
import 'package:provider/provider.dart';

class Historypage extends StatefulWidget {
  const Historypage({super.key});

  @override
  State<Historypage> createState() => _HistorypageState();
}

class _HistorypageState extends State<Historypage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callTransactions();
  }

  callTransactions() {
    final userProvider = context.read<InitProvider>();
    userProvider.getAllTransactions(context);
  }
  
   @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black54,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/homeback.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
            child: Column(
              children: [
                Container(
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back_ios,color: Colors.white,),
                          Text(
                            'History',
                            style: TextStyle(fontSize: 26, color: Colors.white),
                          ),
                          
                        ],
                      ),
                    ),
                  ),
                ),
               
                //Show all transaction
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: transactions(),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed:  () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Sendmoneypage())),
        label: Text(
          'Send Money',
          style: TextStyle(color: Colors.white),
        ),
        icon: Icon(
          Icons.send,
          color: Colors.white,
        ),
        backgroundColor: Color.fromARGB(255, 25, 178, 238),
      ),
    );
  }


 Widget transactions() {
    final userProvider = context.watch<InitProvider>();
    print(userProvider.userTrans.length);
    return Container(
      height: 500,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
      
        itemCount: userProvider.userTrans.length,
        itemBuilder: (context, i) {
          TransactionModel tran = userProvider.userTrans[i];
          
          return Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(tran.receiver,
                                    style: TextStyle(color: Colors.white70)),
                                Text('Jan 12, 2025',
                                    style: TextStyle(
                                        color: Colors.white70, fontSize: 10))
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('₱ 20.00',
                                    style: TextStyle(color: Colors.white70)),
                                Text('send',
                                    style: TextStyle(
                                        color: Colors.white70, fontSize: 10))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

