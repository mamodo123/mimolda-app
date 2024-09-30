import 'package:flutter/material.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:mimolda/const/constants.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProbationTutorial extends StatefulWidget {
  const ProbationTutorial({super.key});

  @override
  State<ProbationTutorial> createState() => _ProbationTutorialState();
}

class _ProbationTutorialState extends State<ProbationTutorial> {
  late double progressBur = 1 / pageImage.length;
  int step = 1;
  PageController pageController = PageController(initialPage: 0);

  final pageImage = [
    'images/tutorial1.png',
    'images/tutorial2.png',
    'images/tutorial3.png',
  ];

  final mainText = [
    'Como funciona a provação?',
    'Pré-autorização do cartão',
    'Prazo'
  ];
  final subText = [
    'Prove as peças que desejar, em qualquer lugar, antes de comprar\n\nSeu pedido é enviado para análise da loja e ao ser aceito inicia-se o processo de provação, com entrega ou retirada das peças em loja.',
    'Uma parte do valor da compra é retida em seu cartão e o valor é devolvido assim que os produtos retornarem à loja sem avarias',
    'Após o prazo estipulado pela loja vá até SEUS PEDIDOS, escolha se quer comprar ou devolver algum produto e clique em FINALIZAR PROVAÇÃO',
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
              Navigator.of(context).pop();
            },
            child: Text(
              'Pular',
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
                                  color: primaryColor,
                                ),
                                progressColor: primaryColor,
                              ),
                              onTap: () {
                                if (step < pageImage.length) {
                                  setState(() {
                                    step += 1;
                                    progressBur =
                                        progressBur + 1 / pageImage.length;
                                  });
                                } else {
                                  Navigator.of(context).pop();
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
