import 'package:flutter/material.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:mimolda/const/constants.dart';
import 'package:mimolda/screens/Auth_Screen/auth_screen_1.dart';
import 'package:mimolda/welcome_screen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SplashScreenTwo extends StatefulWidget {
  const SplashScreenTwo({Key? key}) : super(key: key);

  @override
  State<SplashScreenTwo> createState() => _SplashScreenTwoState();
}

class _SplashScreenTwoState extends State<SplashScreenTwo> {
  double progressBur = 1/3;
  PageController pageController = PageController(initialPage: 0);

  final pageImage = [
    'images/Group 33923.png',
    'images/Group 33927.png',
    'images/Group 33928.png',
  ];

  final mainText = [
    'Welcome to Maanstore',
    'It’s Simple For You',
    'Choose Your Best Product',
  ];
  final subText = [
    'Pretium, ipsum pretium aliquet mollis cond imentum magna accumsan. Odio elit tellus id diam sit. Massa',
    'Pretium, ipsum pretium aliquet mollis cond imentum magna accumsan. Odio elit tellus id diam sit. Massa',
    'Pretium, ipsum pretium aliquet mollis cond imentum magna accumsan. Odio elit tellus id diam sit. Massa',
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () {
              const WelComeScreen().launch(
                context,
                isNewTask: true,
              );
            },
            child: Text(
              'Skip',
              style: kTextStyle,
            ),
          ),
        ],
      ),
      body: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        itemCount: pageImage.length,
        itemBuilder: (context, position) {
          return SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Image(
                    image: AssetImage(pageImage[position]),
                    height: size.height / 2,
                  ),
                  Stack(
                    children: [
                      const SizedBox(
                        width: double.infinity,
                        child: Image(
                          image: AssetImage('images/rectangle_1.png'),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20.0),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20.0),
                              topLeft: Radius.circular(20.0)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 20.0,
                            ),
                            GestureDetector(
                              child: CircularPercentIndicator(
                                radius: 30.0,
                                lineWidth: 4.0,
                                percent: progressBur,
                                center: const Icon(
                                  FeatherIcons.chevronsRight,
                                  color: Colors.red,
                                ),
                                progressColor: Colors.red,
                              ),
                              onTap: () {
                                if (progressBur < 0.70) {
                                  setState(() {
                                    progressBur = progressBur + 0.3333;
                                  });
                                } else {
                                  const AuthScreen()
                                      .launch(context, isNewTask: true);
                                }
                                pageController.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn,
                                );
                              },
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              mainText[position],
                              style: GoogleFonts.dmSans(
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              subText[position],
                              textAlign: TextAlign.center,
                              style: GoogleFonts.dmSans(
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: textColors,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
