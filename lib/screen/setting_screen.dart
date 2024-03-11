import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/screen/alert_notify.dart';
import 'package:todo_app/theme/theme.dart';

import 'test_notification_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildappbar,
      body: _buildBody,
    );
  }

  get _buildBody {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Get.to(const AlertNotify());
          },
          child: Card(
            child: Container(
                padding: const EdgeInsets.only(left: 10),
                alignment: Alignment.centerLeft,
                height: 60,
                width: double.infinity,
                child: Row(
                  children: [
                    const Icon(Icons.alarm),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Alert Notification",
                      style: miniTextStyte(fontSize: 20),
                    ),
                  ],
                )),
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.to(const TestNotificationScreen());
          },
          child: Card(
            child: Container(
                padding: const EdgeInsets.only(left: 10),
                alignment: Alignment.centerLeft,
                height: 60,
                width: double.infinity,
                child: Row(
                  children: [
                    const Icon(Icons.alarm),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Click Notification",
                      style: miniTextStyte(fontSize: 20),
                    ),
                  ],
                )),
          ),
        )
      ],
    );
  }

  get _buildappbar {
    return AppBar(
      centerTitle: true,
      title: const Text("Setting"),
      backgroundColor: Theme.of(context).primaryColor,
      actions: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.amber,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white),
            image: const DecorationImage(
              image: AssetImage("assets/images/mypic.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
