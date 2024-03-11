import 'package:flutter/material.dart';
import 'package:todo_app/service/notification_service.dart';

class TestNotificationScreen extends StatefulWidget {
  const TestNotificationScreen({Key? key}) : super(key: key);

  @override
  State<TestNotificationScreen> createState() => _TestNotificationScreenState();
}

class _TestNotificationScreenState extends State<TestNotificationScreen> {
  LocalNotificationService notify = LocalNotificationService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                notify.showSimpleNotification(
                    title: "Hello",
                    body: "New notification",
                    payload: "New payload");
              },
              child: const Text("Simple Notification"),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                notify.showPeriodicNotifications(
                    title: "My flutter",
                    body: "New notification periodic notification",
                    payload: "New data");
              },
              child: const Text("Show predic Notification"),
            ),
          )
        ],
      ),
    );
  }
}
