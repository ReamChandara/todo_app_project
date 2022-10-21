import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/screen/add_task_screen.dart';
import 'package:todo_app/screen/second_screen.dart';
import 'package:todo_app/screen/setting_screen.dart';
import 'package:todo_app/service/notification_service.dart';
import 'package:todo_app/service/theme_service.dart';
import 'package:todo_app/theme/theme.dart';
import 'package:todo_app/widget/custom_buttom.dart';

import '../widget/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late NotifyHelper service;
  late ThemeMode themeMode;
  DateTime _selectedValue = DateTime.now();
  bool isdark = true;
  void backgroundCallback() async {
    await Future.delayed(const Duration(seconds: 10)).whenComplete(
      () => service.showNotification(id: 1, title: "hello", body: "Alert task"),
    );
  }

  @override
  void initState() {
    service = NotifyHelper();
    service.intialize();
    listenToNotification();
    themeMode = ThemeService().theme;
    if (themeMode == ThemeMode.dark) {
      setState(() {
        isdark = true;
      });
    } else {
      setState(() {
        isdark = false;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: _buildappbar,
      body: _buildBody,
      floatingActionButton: _buildFloatingButton,
    );
  }

  get _buildDrawer {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(child: Text("Hello")),
          ListTile(
            onTap: () {
              Get.to(const SettingScreen());
            },
            leading: const Icon(Icons.settings),
            title: const Text("Setting"),
          )
        ],
      ),
    );
  }

  get _buildFloatingButton {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () {
        ThemeService().switchTheme();
        setState(() {
          isdark = !isdark;
        });
      },
      child: Icon(
        isdark ? Icons.nightlight_round_outlined : Icons.light_mode,
        color: Get.isDarkMode ? Colors.white : Colors.white,
        size: 20,
      ),
    );
  }

  get _buildappbar {
    return AppBar(
      // leading: IconButton(
      //     onPressed: (() async {
      //       // await service.showNotification(
      //       //     id: 0, title: "ChangeTheme", body: "Theme has been changed!");
      //       // await service.showSchedleNotification(
      //       //     id: 0,
      //       //     title: "change theme",
      //       //     body: "theme chnaged has deley",
      //       //     second: 4);
      //       // await service.showNotificationWithPayload(
      //       //     id: 0,
      //       //     title: 'ChangeTheme',
      //       //     body: "Theme has been change",
      //       //     payload: "Second Screen");
      //     }),
      //     icon: Icon(
      //       isdark ? Icons.nightlight_round_outlined : Icons.light_mode,
      //       size: 20,
      //     )),
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

  get _buildBody {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat.yMMMMd().format(DateTime.now()).toString(),
                    style: subHeadingStyte,
                  ),
                  Text("Today", style: headingStyte),
                ],
              ),
              CustomButtom(
                  lable: "+ Add Task",
                  ontap: () {
                    Get.to(const AddTaskScreen());
                  })
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          _buildTimeLinePicker()
        ],
      ),
    );
  }

  Widget _buildTimeLinePicker() {
    return DatePicker(
      DateTime.now(),
      height: 100,
      dateTextStyle: dateTimeTextStyte,
      monthTextStyle: dateTimeTextStyte,
      dayTextStyle: dateTimeTextStyte,
      initialSelectedDate: DateTime.now(),
      selectionColor: Theme.of(context).primaryColor,
      selectedTextColor: Colors.blue,
      onDateChange: (date) {
        // New date selected
        setState(() {
          _selectedValue = date;
        });
      },
    );
  }

  void listenToNotification() =>
      service.onNotificationClick.stream.listen(onNoticationListener);

  void onNoticationListener(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      Get.to(SecondScreen(payload: payload));
    }
  }
}
