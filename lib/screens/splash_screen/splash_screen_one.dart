import 'package:flutter/material.dart';
import 'package:mimolda/const/constants.dart';
import 'package:mimolda/models/full_store.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../functions/route.dart';

class SplashScreenOne extends StatefulWidget {
  const SplashScreenOne({super.key});

  @override
  State<SplashScreenOne> createState() => _SplashScreenOneState();
}

class _SplashScreenOneState extends State<SplashScreenOne> {
  Future<void> pageNavigation(BuildContext context) async {
    final fullStore = context.read<FullStoreNotifier>();
    final storeLoaded = await fullStore.loadStore();
    if (storeLoaded) {
      await fullStore.reloadFullStore();
      final route = await getRoute();
      if (context.mounted) {
        launchNewScreenWithNewTask(context, route);
      }
    } else {
      // TODO set state as error
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => pageNavigation(context));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: primaryColor,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: size.height / 3),
            Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(180),
              ),
              child: const Image(
                image: AssetImage(
                  'images/mimolda.png',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
