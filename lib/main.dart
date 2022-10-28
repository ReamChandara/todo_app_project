import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controller/task_controller.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/screen/home_screen.dart';
import 'package:todo_app/service/notification_service.dart';
import 'package:todo_app/service/theme_service.dart';
import 'package:todo_app/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late NotifyHelper service = NotifyHelper();
  var taskController = Get.put(TaskController());
  void setNotification() async {
    service.intialize();
    TaskModel? taskModel = taskController.taskModels
        .firstWhereOrNull((element) => element.repead == 'Daily');
    if (taskModel != null) {
      DateTime dateTime = DateFormat.jm().parse(taskModel.startTime.toString());
      var myTime = DateFormat("HH:mm").format(dateTime);
      service.schedleNotification(0, int.parse(myTime.toString().split(':')[0]),
          int.parse(myTime.toString().split(':')[1]), taskModel, "hello");
    }
  }

  void clearNotification() async {
    service.intialize();
    await service.cancelAllNotifications();
  }

  @override
  void initState() {
    super.initState();
    clearNotification();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {}
    final isbackground = state == AppLifecycleState.paused;
    if (isbackground) {
      setNotification();
    } else {}
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      themeMode: ThemeService().theme,
      darkTheme: Themes.dark,
      home: const HomeScreen(),
    );
  }
}
 // Workmanager().initialize(
  //   callBackDispatcher,
  //   isInDebugMode: true,
  // );
  // Workmanager().registerPeriodicTask(
  //   "1",
  //   "uniqueKey",
  //   frequency: const Duration(minutes: 15),
  // );

  // void callBackDispatcher() async {
//   Workmanager().executeTask((taskName, inputData) {
//     if (taskName == "uniqueKey") {
//       service.intialize();
//       service.showNotification(id: 1, title: "hello", body: "Alert task");
//       return Future.value(true);
//     } else {
//       return Future.value(false);
//     }
//   });
// }