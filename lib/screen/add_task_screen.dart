// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controller/task_controller.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/theme/theme.dart';
import 'package:todo_app/widget/custom_buttom.dart';
import 'package:todo_app/widget/custom_dropdow.dart';

import '../widget/custom_textfield.dart';
import '../widget/custom_textfield_date.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  List<String> remindList = [
    "None",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
  ];

  List<String> repeadList = [
    "None",
    "Daily",
    "Weeks",
    "Months",
    "Years",
  ];

  bool isBlueTick = false;
  bool isPinkTick = false;
  bool isYellowTick = false;
  int selectColor = 0;
  late String selectRepead = repeadList.first;
  late String selectRemind = remindList.first;
  TextEditingController tileCon = TextEditingController(text: "");
  TextEditingController noteCon = TextEditingController(text: "");
  TextEditingController dateCon = TextEditingController();
  TextEditingController startCon = TextEditingController();
  TextEditingController endCon = TextEditingController();
  DateTime now = DateTime.now();
  var timeOfDay = TimeOfDay.now();
  var taskController = Get.put(TaskController());
  @override
  void initState() {
    dateCon.text = DateFormat.yMd().format(now);
    Future.delayed(Duration.zero, () {
      startCon.text = timeOfDay.format(context).toString();
      endCon.text = timeOfDay.format(context).toString();
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar,
      body: _buildBody,
    );
  }

  get _buildBody {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add Task",
              style: miniTextStyte(fontSize: 24),
            ),
            CustomTextField(
              controller: tileCon,
            ),
            CustomTextField(
              hint: "Enter note here",
              title: "Note",
              controller: noteCon,
            ),
            CustomTextFieldDate(
              controller: dateCon,
              title: "Date",
              onTap: (() {
                print("Hello");
                _showDateTime();
              }),
              icon: const Icon(Icons.date_range),
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextFieldDate(
                    controller: startCon,
                    title: "Start Date",
                    onTap: (() {
                      _showStartTime();
                      // _showTime(isStartTime: true);
                    }),
                    icon: const Icon(Icons.schedule),
                  ),
                ),
                Expanded(
                  child: CustomTextFieldDate(
                    controller: endCon,
                    title: "End Date",
                    onTap: (() {
                      _showEndTime();
                    }),
                    icon: const Icon(Icons.schedule),
                  ),
                )
              ],
            ),
            CustomDropdown(
                title: "Remind",
                dateList: remindList,
                onChange: (value) {
                  setState(() {
                    selectRemind = value!;
                  });
                },
                selectValue: selectRemind.toString()),
            CustomDropdown(
                title: "Repeat",
                dateList: repeadList,
                onChange: (value) {
                  setState(() {
                    selectRepead = value!;
                  });
                },
                selectValue: selectRepead),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Color",
                        style: miniTextStyte(fontSize: 16),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 10, right: 5),
                          padding: const EdgeInsets.only(left: 10, right: 5),
                          child: Wrap(
                            children: List.generate(3, (int index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectColor = index;
                                    });
                                  },
                                  child: CircleAvatar(
                                    radius: 14,
                                    backgroundColor: index == 0
                                        ? primaryClr
                                        : index == 1
                                            ? pinkClr
                                            : yellowClr,
                                    child: selectColor == index
                                        ? const Icon(
                                            Icons.done,
                                            color: Colors.white,
                                            size: 14,
                                          )
                                        : const SizedBox(),
                                  ),
                                ),
                              );
                            }),
                          )),
                    ],
                  ),
                ),
                CustomButtom(
                  lable: "Create Task",
                  ontap: () async {
                    TaskModel taskModel = TaskModel(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      title: tileCon.text,
                      note: noteCon.text,
                      isComplate: 0,
                      date: dateCon.text,
                      startTime: startCon.text,
                      endTime: endCon.text,
                      remind: selectRemind,
                      repead: selectRepead,
                      color: selectColor,
                    );
                    print(taskModel.toMap());
                    await taskController.addTask(taskModel);
                    await taskController.showTask();
                    Get.back();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _showDateTime() async {
    DateTime? datetime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2121),
    );
    if (datetime != null) {
      setState(() {
        dateCon.text = DateFormat.yMd().format(datetime);
      });
    }
  }

  Future<void> _showStartTime() async {
    await showTimePicker(
            initialEntryMode: TimePickerEntryMode.input,
            context: context,
            initialTime: TimeOfDay.now())
        .then((value) {
      if (value != null) {
        setState(() {
          startCon.text = value.format(context).toString();
        });
      }
    });
  }

  Future<void> _showEndTime() async {
    await showTimePicker(
            initialEntryMode: TimePickerEntryMode.input,
            context: context,
            initialTime: TimeOfDay.now())
        .then((value) {
      if (value != null) {
        setState(() {
          endCon.text = value.format(context).toString();
        });
      }
    });
  }

  get _buildAppbar {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).primaryColor,
      actions: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
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
