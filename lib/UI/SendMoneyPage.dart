import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:moneysender/Services/user_service.dart';
import 'package:moneysender/UI/SuccessPage.dart';
import 'package:moneysender/provider/init_provider.dart';
import 'package:provider/provider.dart';

class Sendmoneypage extends StatefulWidget {
  const Sendmoneypage({super.key});

  @override
  State<Sendmoneypage> createState() => _SendmoneypageState();
}

class _SendmoneypageState extends State<Sendmoneypage> {
  TextEditingController recevierNameController =
      TextEditingController(text: '');
  TextEditingController amountController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/homeback.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: Container(
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
                                    Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'History',
                                      style: TextStyle(
                                          fontSize: 26, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 30, left: 30, bottom: 20, top: 50),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Info',
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 30, left: 30, bottom: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Receiver',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30, left: 30),
                            child: TextField(
                              controller: recevierNameController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                filled: true,
                                hintStyle: TextStyle(color: Colors.grey[800]),
                                hintText: "Enter receiver\'s full name",
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 30, left: 30, bottom: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Amount',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30, left: 30),
                            child: TextField(
                              controller: amountController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                filled: true,
                                hintStyle: TextStyle(color: Colors.grey[800]),
                                hintText: "0.00",
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 100),
                            child: GestureDetector(
                              onTap: () async {
                                final userProvider =
                                    context.read<InitProvider>();
                                var res =
                                    await userProvider.sendMoneyToFakeJson(
                                        context,
                                        recevierNameController.text,
                                        double.parse(amountController.text));
                                if (res) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Successpage(
                                            receiver:
                                                recevierNameController.text,
                                            amountSend: amountController.text,
                                          )));
                                }
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 30, left: 30),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.white54),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Send Now!',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Icon(
                                        Icons.send,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
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
    );
  }
}
