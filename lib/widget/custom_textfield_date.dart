import 'package:flutter/material.dart';

import '../theme/theme.dart';

class CustomTextFieldDate extends StatelessWidget {
  final String? title;
  final Icon icon;
  final Function() onTap;
  final TextEditingController controller;
  const CustomTextFieldDate({
    Key? key,
    this.title = "Title",
    required this.icon,
    required this.onTap,
    required this.controller,
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
          const SizedBox(
            height: 10,
          ),
          Container(
              padding: const EdgeInsets.only(left: 10, top: 2),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)),
              width: double.infinity,
              height: 50,
              child: TextFormField(
                readOnly: true,
                onTap: onTap,
                controller: controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: icon,
                ),
              ))
        ],
      ),
    );
  }
}
