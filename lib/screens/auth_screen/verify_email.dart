import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mimolda/models/full_store.dart';
import 'package:provider/provider.dart';

import '../../const/constants.dart';

class VerifyEmail extends StatefulWidget {
  final String? origin;

  const VerifyEmail({super.key, required this.origin});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  late Timer _timer;
  late Timer _resend_timer;
  static const startTime = 90;
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
    return PopScope(
      canPop: false,
      child: GestureDetector(
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
                    const Image(
                        image: AssetImage('images/maanstore_logo_1.png')),
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
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        if (context.mounted) {
                          final fullStore = context.read<FullStoreNotifier>();
                          await fullStore.reloadUser(
                              reloadOrders: true, reloadPurchases: true);
                        }
                        if (context.mounted) {
                          if (widget.origin == null) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/home', (route) => false);
                          } else {
                            Navigator.of(context).pop();
                          }
                        }
                      },
                      child: MyGoogleText(
                        fontSize: 16,
                        fontColor:
                            _start != startTime ? Colors.grey : primaryColor,
                        text: 'Sair',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> functionCheckEmail(Timer timer, BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    await user?.reload();
    if (user?.emailVerified ?? false) {
      timer.cancel();
      if (context.mounted) {
        switch (widget.origin) {
          case null:
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/home', (route) => false);
            break;
          case '/home':
            Navigator.of(context)
                .popUntil((route) => route.settings.name == '/home');
            break;
          case '/cart':
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/checkout',
                (route) =>
                    !(route.settings.name?.startsWith('/login') ?? false));
            break;
        }
      }
    }
  }
}
