import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controller/task_controller.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/screen/add_task_screen.dart';
import 'package:todo_app/screen/second_screen.dart';
import 'package:todo_app/service/notification_service.dart';
import 'package:todo_app/service/theme_service.dart';
import 'package:todo_app/theme/theme.dart';
import 'package:todo_app/widget/custom_buttom.dart';
import 'package:todo_app/widget/task_tilte.dart';

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
  var taskController = Get.put(TaskController());

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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
          child: Row(
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
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: _buildTimeLinePicker(),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(child: GetX<TaskController>(
          builder: ((controller) {
            if (taskController.isLoading.value) {
              return const CircularProgressIndicator();
            } else {
              return ListView.builder(
                  itemCount: taskController.taskModels.length,
                  itemBuilder: (context, index) {
                    TaskModel taskModel = taskController.taskModels[index];
                    if (taskModel.repead == "Daily") {
                      return AnimationConfiguration.staggeredList(
                          delay: const Duration(milliseconds: 500),
                          position: index,
                          child: SlideAnimation(
                            child: FadeInAnimation(
                                child: Row(
                              children: [
                                GestureDetector(
                                  onTap: (() {
                                    // service.schedleNotification(
                                    //   1,
                                    //   int.parse(
                                    //       myTime.toString().split(':')[0]),
                                    //   int.parse(
                                    //       myTime.toString().split(':')[1]),
                                    //   taskModel,
                                    //   "Hello",
                                    // );
                                    _buildBottomSheet(context, taskModel);
                                  }),
                                  child: TaskTile(
                                    task: taskModel,
                                  ),
                                )
                              ],
                            )),
                          ));
                    }
                    if (taskModel.date ==
                        DateFormat.yMd().format(_selectedValue)) {
                      return AnimationConfiguration.staggeredList(
                          delay: const Duration(milliseconds: 500),
                          position: index,
                          child: SlideAnimation(
                            child: FadeInAnimation(
                                child: Row(
                              children: [
                                GestureDetector(
                                  onTap: (() {
                                    _buildBottomSheet(context, taskModel);
                                  }),
                                  child: TaskTile(
                                    task: taskModel,
                                  ),
                                )
                              ],
                            )),
                          ));
                    } else {
                      return const SizedBox();
                    }
                  });
            }
          }),
        ))
      ],
    );
  }

  _buildBottomSheet(BuildContext context, TaskModel taskModel) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 0.4),
        height: taskModel.isComplate == 1
            ? MediaQuery.of(context).size.height * 0.24
            : MediaQuery.of(context).size.height * 0.38,
        color: Get.isDarkMode ? Colors.black : Colors.white,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: bluishClr,
              ),
            ),
            const Spacer(),
            taskModel.isComplate == 1
                ? const SizedBox()
                : _bottomSheetButton(
                    label: "Complate Task",
                    onTap: () {
                      taskController.makeTakeComplate(taskModel.id);
                      taskController.showTask();
                      Get.back();
                    },
                    clr: bluishClr,
                    context: context),
            const SizedBox(
              height: 5,
            ),
            _bottomSheetButton(
                label: "Delete Task",
                onTap: () {
                  taskController.deleteTask(taskModel.id);
                  taskController.showTask();
                  Get.back();
                },
                clr: Colors.red[300]!,
                context: context),
            const SizedBox(
              height: 20,
            ),
            _bottomSheetButton(
                label: "Close",
                onTap: () {
                  Get.back();
                },
                clr: Colors.red[300]!,
                context: context,
                isClose: true),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  _bottomSheetButton(
      {required String label,
      required Function() onTap,
      required Color clr,
      required BuildContext context,
      bool isClose = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            border: Border.all(
                width: 2,
                color: isClose == true
                    ? Get.isDarkMode
                        ? Colors.grey[600]!
                        : Colors.grey[300]!
                    : clr),
            color: isClose == true ? Colors.transparent : clr,
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          label,
          style: miniTextStyte(fontSize: 16),
        ),
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

// AnimationLimiter(
//                 child: Column(
//                   children: AnimationConfiguration.toStaggeredList(
//                       duration: const Duration(milliseconds: 375),
//                       childAnimationBuilder: (widget) => SlideAnimation(
//                             horizontalOffset:
//                                 MediaQuery.of(context).size.width / 2,
//                             child: FadeInAnimation(child: widget),
//                           ),
//                       children: taskController.taskModels.map((e) {
//                         if (e.repead == "Dialy") {
//                           return GestureDetector(
//                             onTap: (() {
//                               _buildBottomSheet(context, e);
//                             }),
//                             child: TaskTile(
//                               task: e,
//                             ),
//                           );
//                         } else if (e.date ==
//                             DateFormat.yMd().format(_selectedValue)) {
//                           return GestureDetector(
//                             onTap: (() {
//                               _buildBottomSheet(context, e);
//                             }),
//                             child: TaskTile(
//                               task: e,
//                             ),
//                           );
//                         } else {
//                           return const SizedBox();
//                         }
//                       }).toList()),
//                 ),
//               );

// return ListView.builder(
//                   itemCount: taskController.taskModels.length,
//                   itemBuilder: (context, index) {
//                     TaskModel taskModel = taskController.taskModels[index];
//                     if (taskModel.repead == "Daily") {
//                       return AnimationConfiguration.staggeredList(
//                           position: index,
//                           child: SlideAnimation(
//                             child: FadeInAnimation(
//                                 child: Row(
//                               children: [
//                                 GestureDetector(
//                                   onTap: (() {
//                                     _buildBottomSheet(context, taskModel);
//                                   }),
//                                   child: TaskTile(
//                                     task: taskModel,
//                                   ),
//                                 )
//                               ],
//                             )),
//                           ));
//                     }
//                     if (taskModel.date ==
//                         DateFormat.yMd().format(_selectedValue)) {
//                       return AnimationConfiguration.staggeredList(
//                           position: index,
//                           child: SlideAnimation(
//                             child: FadeInAnimation(
//                                 child: Row(
//                               children: [
//                                 GestureDetector(
//                                   onTap: (() {
//                                     _buildBottomSheet(context, taskModel);
//                                   }),
//                                   child: TaskTile(
//                                     task: taskModel,
//                                   ),
//                                 )
//                               ],
//                             )),
//                           ));
//                     } else {
//                       return const SizedBox();
//                     }
//                   });