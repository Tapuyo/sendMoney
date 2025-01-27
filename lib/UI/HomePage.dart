import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:moneysender/Models/transaction.dart';
import 'package:moneysender/UI/HistoryPage.dart';
import 'package:moneysender/UI/SendMoneyPage.dart';
import 'package:moneysender/UI/SignInPage.dart';
import 'package:moneysender/main.dart';
import 'package:moneysender/provider/init_provider.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callTransactions();
  }

  callTransactions() {
    final userProvider = context.read<InitProvider>();
    userProvider.getTransactions(context);
  }

  @override
  Widget build(BuildContext context) {
    final flipController = FlipCardController();

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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'MoneySender',
                            style: TextStyle(fontSize: 26, color: Colors.white),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => Signinpage())),
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: Color.fromARGB(255, 21, 236, 229),
                              child: ClipOval(
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  FlipCard(
                    rotateSide: RotateSide.bottom,
                    onTapFlipping:
                        true, //When enabled, the card will flip automatically when touched.
                    axis: FlipAxis.horizontal,
                    controller: flipController,
                    frontWidget: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromARGB(255, 25, 178, 238),
                                Color.fromARGB(255, 21, 236, 229)
                              ],
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Balance',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.remove_red_eye,
                                    color: Colors.white60,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '₱ ',
                                    style: TextStyle(
                                        fontSize: 80, color: Colors.white70),
                                  ),
                                  Text(
                                    context
                                        .watch<InitProvider>()
                                        .user
                                        .balance
                                        .toStringAsFixed(2),
                                    style: TextStyle(
                                        fontSize: 50,
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    backWidget: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromARGB(255, 25, 178, 238),
                                Color.fromARGB(255, 21, 236, 229)
                              ],
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Balance',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.remove_red_eye_outlined,
                                    color: Colors.white60,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '₱ ',
                                    style: TextStyle(
                                        fontSize: 80, color: Colors.white70),
                                  ),
                                  Text(
                                    '******',
                                    style: TextStyle(
                                        fontSize: 50,
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  //Previous 10
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Previous Transaction',
                                style: TextStyle(color: Colors.white70),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => Historypage())),
                                child: Text(
                                  'Show all',
                                  style: TextStyle(color: Colors.white70),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          transactions()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Sendmoneypage())),
        // child: Icon(Icons.send, color: Colors.black, size: 29,),
        label: Text('Send Money'),
        icon: Icon(Icons.send),
        backgroundColor: Colors.white,
        tooltip: 'Send Money',
        elevation: 5,
        splashColor: Colors.grey,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
