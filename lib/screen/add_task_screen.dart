import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/theme/theme.dart';

import '../widget/custom_textfield.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
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
            const CustomTextField(),
            const CustomTextField(
              hint: "Enter note here",
              title: "Note",
            ),
            const CustomTextField(
              title: "Date",
              icon: Icon(Icons.date_range),
            ),
            Row(
              children: const [
                Expanded(
                  child: CustomTextField(
                    title: "Start Date",
                    hint: "21/10/2022",
                    icon: Icon(Icons.schedule),
                  ),
                ),
                Expanded(
                  child: CustomTextField(
                    title: "End Date",
                    hint: "21/10/2022",
                    icon: Icon(Icons.schedule),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
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
