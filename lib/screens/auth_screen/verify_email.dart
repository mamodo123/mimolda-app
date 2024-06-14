import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../const/constants.dart';
import '../home_screens/home.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  late Timer _timer;
  late Timer _resend_timer;
  static const startTime = 180;
  var _start = startTime;

  String get currentTime =>
      '${_start ~/ 60}:${(_start % 60).toString().padLeft(2, '0')}';

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _resend_timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            _start = startTime;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 5),
        (timer) => functionCheckEmail(timer, context));
    functionCheckEmail(_timer, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    final email = user?.email ?? '';
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(image: AssetImage('images/maanstore_logo_1.png')),
                  const SizedBox(
                    height: 50,
                  ),
                  const MyGoogleText(
                    fontSize: 20,
                    fontColor: textColors,
                    text: 'Verifique seu email',
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyGoogleText(
                    fontSize: 16,
                    fontColor: textColors,
                    text:
                        'Para continuar, acesse o link de verificação que enviamos ao seu e-mail cadastrado:\n$email.\n\nNão esqueça de verificar sua caixa de spam.',
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: _start == startTime
                        ? () async {
                            if (user != null) {
                              startTimer();
                              await user.sendEmailVerification();
                            }
                          }
                        : null,
                    child: MyGoogleText(
                      fontSize: 16,
                      fontColor:
                          _start != startTime ? Colors.grey : primaryColor,
                      text: 'Reenviar link',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (_start != startTime)
                    Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        MyGoogleText(
                          fontSize: 16,
                          fontColor: Colors.grey,
                          text: currentTime,
                          fontWeight: FontWeight.normal,
                        ),
                      ],
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> functionCheckEmail(Timer timer, BuildContext context) async {
    await FirebaseAuth.instance.currentUser?.reload();
    final user = FirebaseAuth.instance.currentUser;
    if (user?.emailVerified ?? false) {
      timer.cancel();
      if (context.mounted) {
        const Home().launch(context, isNewTask: true);
      }
    }
  }
}
