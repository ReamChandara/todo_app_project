import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/widget/custom_textfield.dart';

class AlertNotify extends StatefulWidget {
  const AlertNotify({Key? key}) : super(key: key);

  @override
  State<AlertNotify> createState() => _AlertNotifyState();
}

class _AlertNotifyState extends State<AlertNotify> {
  List<String> dateList = [
    "Select",
    "Minutes",
    "Hours",
    "Days",
    "Weeks",
    "Months",
    "Years",
  ];
  late String selectedValue = dateList.first;
  TextEditingController beforDateCon = TextEditingController(text: "");
  TextEditingController afterDateCon = TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildappbar,
      body: _buildBody,
    );
  }

  get _buildappbar {
    return AppBar(
      centerTitle: true,
      title: const Text("Alert Mangement"),
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
        Row(
          children: [
            Expanded(
                child: CustomTextField(
              controller: beforDateCon,
            )),
            Expanded(
                child: Container(
              margin: const EdgeInsets.only(top: 29, right: 5),
              padding: const EdgeInsets.only(left: 5, right: 5),
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  // hint: Text(
                  //   'Select Item',
                  //   style: TextStyle(
                  //     fontSize: 14,
                  //     color: Theme.of(context).hintColor,
                  //   ),
                  // ),
                  items: dateList
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  value: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value as String;
                    });
                  },
                ),
              ),
            ))
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
                child: CustomTextField(
              controller: afterDateCon,
            )),
            Expanded(
                child: Container(
              margin: const EdgeInsets.only(top: 29, right: 5),
              padding: const EdgeInsets.only(left: 5, right: 5),
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  // hint: Text(
                  //   'Select Item',
                  //   style: TextStyle(
                  //     fontSize: 14,
                  //     color: Theme.of(context).hintColor,
                  //   ),
                  // ),
                  items: dateList
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  value: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value as String;
                    });
                  },
                ),
              ),
            ))
          ],
        )
      ],
    );
  }
}
