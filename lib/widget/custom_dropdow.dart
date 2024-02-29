import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../theme/theme.dart';

class CustomDropdown extends StatelessWidget {
  final String? hintText;
  final String? title;
  final List<String> dateList;
  final void Function(String?) onChange;
  final String selectValue;
  const CustomDropdown({
    Key? key,
    this.hintText = 'select remind',
    this.title = "Title",
    required this.dateList,
    required this.onChange,
    required this.selectValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title!,
            style: miniTextStyte(fontSize: 16),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, right: 5),
            padding: const EdgeInsets.only(left: 10, right: 5),
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                //hint: Text(hintText!),
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
                value: selectValue,
                onChanged: onChange,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
