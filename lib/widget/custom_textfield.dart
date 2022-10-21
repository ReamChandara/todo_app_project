import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/theme.dart';

class CustomTextField extends StatelessWidget {
  final String? title;
  final Icon? icon;
  final String? hint;
  const CustomTextField(
      {Key? key,
      this.title = "Title",
      this.icon,
      this.hint = "Enter title here"})
      : super(key: key);

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
          const SizedBox(
            height: 10,
          ),
          Container(
              padding: const EdgeInsets.only(left: 10, top: 2),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  //  color: Get.isDarkMode ? Colors.blueGrey[400] : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)),
              width: double.infinity,
              height: 50,
              child: TextFormField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hint!,
                    suffixIcon: icon ?? const SizedBox()),
              ))
        ],
      ),
    );
  }
}
