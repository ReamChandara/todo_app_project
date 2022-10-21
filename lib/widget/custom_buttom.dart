import 'package:flutter/material.dart';
import 'package:todo_app/theme/theme.dart';

class CustomButtom extends StatelessWidget {
  final String lable;
  final Function() ontap;

  const CustomButtom({Key? key, required this.lable, required this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        alignment: Alignment.center,
        width: 120,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).primaryColor,
        ),
        child: Text(
          lable,
          style: miniTextStyte(),
        ),
      ),
    );
  }
}
