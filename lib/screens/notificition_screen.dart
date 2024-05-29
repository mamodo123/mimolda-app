import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../const/constants.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const MyGoogleText(
          text: 'Notifications',
          fontColor: Colors.black,
          fontWeight: FontWeight.normal,
          fontSize: 20,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              width: context.width(),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Container(
                            height: 60,
                            width: 60,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    'images/profile_pic.jpg',
                                  ),
                                  fit: BoxFit.fitWidth),
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                          ),
                          title: const MyGoogleText(
                            text: 'Leslie Alexander',
                            fontColor: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                          subtitle: const MyGoogleText(
                            text: '2 min ago “New Message”',
                            fontColor: textColors,
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                          ),
                          trailing: const Icon(
                            Icons.circle,
                            size: 8,
                            color: secondaryColor1,
                          ),
                        );
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
