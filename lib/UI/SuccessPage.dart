import 'dart:math';
import 'dart:ui';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneysender/UI/HomePage.dart';

class Successpage extends StatefulWidget {
  String receiver;
  String amountSend;
  Successpage({super.key, required this.amountSend, required this.receiver});

  @override
  State<Successpage> createState() => _SuccesspageState();
}

class _SuccesspageState extends State<Successpage> {
  late ConfettiController _controllerCenter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 30));
        _controllerCenter.play();
  }


  @override
  void dispose() {
    _controllerCenter.dispose();

    super.dispose();
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Container(
        //  decoration: BoxDecoration(
        //     image: DecorationImage(
        //       image: AssetImage("assets/homeback.jpg"),
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Stack(
            children: [
              Container(
                child: Image.asset('assets/authimage.jpg'),
              ),
               
              Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 200),
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Successfully Send',
                                style: TextStyle(
                                    fontSize: 30, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                       Padding(
                        padding: const EdgeInsets.only(top: 200),
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.receiver,
                                style: TextStyle(
                                    fontSize: 30, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                                Text(
                                '₱ ${widget.amountSend}',
                                style: TextStyle(
                                    fontSize: 40, color: Colors.white, fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                                Text(
                                DateFormat.yMMMd().format(DateTime.now()),
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Spacer(),
                    
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Homepage())),
                            child: Text(
                              'Back to Home',
                              style: TextStyle(
                                color: Color.fromARGB(255, 25, 178, 238),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
              confettiController: _controllerCenter,
              blastDirectionality: BlastDirectionality
                  .explosive, // don't specify a direction, blast randomly
              shouldLoop:
                  true, // start again as soon as the animation is finished
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple
              ], // manually specify the colors to be used
              createParticlePath: drawStar, // define a custom shape/path.
            ),
          ),
            ],
          ),
        ),
      ),
    );
  }

   Path drawStar(Size size) {
    // Method to convert degrees to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }
}
