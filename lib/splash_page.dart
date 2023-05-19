import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'homepage.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    startAnimation();
    super.initState();
  }

  void navigationPage() async {
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MyHomePage(title: "Foody")));
    }



  bool animate = false;
  bool startSlide = false;
  bool showText = false;
  bool hideText = false;

  Future startAnimation() async {
    await Future.delayed(Duration(milliseconds: 200));
    setState(() {
      animate = true;
    });
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      showText = true;
    });
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      startSlide = true;
      ajustSaturation();
    });
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      hideText = true;
    });
    final _duration = Duration(seconds: 4);
    return Timer(_duration, navigationPage);
  }

  double saturation = -0.2;

  ajustSaturation() async {
    for (var i = 0; i < 10; i++) {
      await Future.delayed(const Duration(milliseconds: 250), () {
        setState(() {
          saturation = saturation + 0.02; //Increment Counter
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHT = MediaQuery.of(context).size.height;
    final screenWD = MediaQuery.of(context).size.width;
    final ratio = MediaQuery.of(context).devicePixelRatio;

    var slideAmount = 1079 - screenWD;
    final delay = 5000;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [

          AnimatedPositioned(
            top: 0,
            right: startSlide ?0: -slideAmount ,
            height: screenHT,
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: delay),
            child: Image.asset(
              "assets/images/splash_bg.png",
              scale: 2,
              fit: BoxFit.fill,
            ),
          ),

          AnimatedOpacity(
            duration: Duration(seconds: 4),
            opacity: hideText ? 0 : 1,
            child: Stack(
              alignment: Alignment.center,
              children: [

                Positioned(
                  bottom:390,
                  child: AnimatedRotation(
                    duration: Duration(milliseconds: 2500),
                    turns: animate ? 0.5 : 1.5,
                    // curve: Curves.linear,
                    child: AnimatedScale(
                      duration: Duration(milliseconds: 2500),
                      scale: animate ? 1 : 40,
                      curve: Curves.easeOut,
                      child: Image.asset(
                        "assets/images/splash_logo_white.png",
                        height: 180,
                        width: 180,
                      ),
                    ),
                  ),
                ),

                // if (showText)
                AnimatedPositioned(
                    duration: Duration(milliseconds: 1200),
                    bottom: showText ? 290 : 270,
                    curve: Curves.linearToEaseOut,
                    child: AnimatedOpacity(
                      duration: Duration(seconds: 1),
                      opacity: showText ? 1 : 0,
                      child: Text("FOODY",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                              fontSize: 52,
                              fontWeight: FontWeight.w900,
                              fontFamily: "QanelasSoft",
                              color: Colors.white)),
                    )),
                // if (showText)
                AnimatedPositioned(
                    duration: Duration(milliseconds: 1200),
                    bottom: showText ? 68 : 48,
                    child: AnimatedOpacity(
                      duration: Duration(seconds: 1),
                      opacity: showText ? 1 : 0,
                      child: Container(
                        width: screenWD,
                        child: Center(
                          child: Text(
                            "Online food and grocery delivery\nright to your doorsteps.",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),


        ],
      ),
    );
  }
}
