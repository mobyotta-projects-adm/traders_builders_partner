import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:traders_builders_partner/TBTraders/TraderLogin.dart';
import 'package:traders_builders_partner/shared/TBAppColors.dart';

import 'TradersRegister.dart';

class TraderGetStarted extends StatefulWidget {
  const TraderGetStarted({Key? key}) : super(key: key);

  @override
  State<TraderGetStarted> createState() => _TraderGetStartedState();
}


class _TraderGetStartedState extends State<TraderGetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.appPrimaryLight,
      body: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.65,
                child: Column(
                  children: [
                    Image.asset("assets/getstarted.png"),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Sign up and become a partner today!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontSize: 28,
                            color: Colors.black,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Palette.appPrimaryDark,
                            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                          ),
                          onPressed: (){
                            Navigator.pushReplacement(
                                context, 
                                MaterialPageRoute(builder: (context)=>TradersRegister())
                            );
                          },
                          child: Text(
                            "Get Started",
                            style: TextStyle(
                                fontFamily: "Ubuntu",
                                fontSize: 18,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 5, 16, 8),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(
                              fontFamily: 'Ubuntu',
                              color: Colors.black,
                              fontWeight: FontWeight.w200,
                              fontSize: 16
                          ),
                          children: <TextSpan>[
                            TextSpan(text: 'Log in',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = (){
                                    Navigator.push(
                                        context, MaterialPageRoute(builder: (context) => TraderLogin()));
                                  },
                                style: TextStyle(
                                    fontFamily:'Ubuntu',
                                    fontWeight: FontWeight.w600,
                                    color: Palette.kToDark.shade800
                                )
                            ),
                          ],
                        ),
                      )
                    ),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
